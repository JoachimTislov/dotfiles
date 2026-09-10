#!/usr/bin/env python3
"""Focus an application's most recently focused window, or launch its argv.

Inspired by Omarchy's bin/omarchy-launch-or-focus (see rice/SOURCES.md).
Uses exact app classes and Desktop Entry StartupWMClass, never window titles.
"""
import configparser
import json
import os
from pathlib import Path
import shlex
import subprocess
import sys


def classes_for(command):
    executable = Path(command[0]).name.lower()
    classes = {executable}
    roots = [os.environ.get("XDG_DATA_HOME", str(Path.home() / ".local/share"))]
    roots += os.environ.get("XDG_DATA_DIRS", "/usr/local/share:/usr/share").split(":")
    seen = set()
    for root in roots:
        for path in sorted((Path(root) / "applications").glob("**/*.desktop")):
            desktop_id = str(path.relative_to(Path(root) / "applications")).replace("/", "-")
            if desktop_id in seen:
                continue
            seen.add(desktop_id)
            entry = configparser.ConfigParser(interpolation=None, strict=False)
            try:
                entry.read(path)
                section = entry["Desktop Entry"]
                argv = shlex.split(section.get("Exec", ""))
                if not argv or Path(argv[0]).name.lower() != executable:
                    continue
                classes.add(desktop_id.removesuffix(".desktop").lower())
                if section.get("StartupWMClass"):
                    classes.add(section["StartupWMClass"].lower())
            except (configparser.Error, KeyError, ValueError, OSError):
                continue
    return classes


def choose_window(clients, classes):
    matches = [w for w in clients if not w.get("hidden", False)
               and any(w.get(key, "").lower() in classes for key in ("class", "initialClass"))]
    return min(matches, key=lambda w: w.get("focusHistoryID", 999999)
               if w.get("focusHistoryID", -1) >= 0 else 999999, default=None)


def main(command):
    if not command:
        raise SystemExit("Usage: launch-or-focus.py [--class APP_ID] command [args...]")
    explicit = None
    if command[0] == "--class":
        if len(command) < 3:
            raise SystemExit("--class requires an app ID and command")
        explicit, command = command[1].lower(), command[2:]
    classes = {explicit} if explicit else classes_for(command)
    try:
        result = subprocess.run(["hyprctl", "clients", "-j"], check=True,
                                capture_output=True, text=True)
        window = choose_window(json.loads(result.stdout), classes)
        if window:
            address = "address:" + window["address"]
            # Lua dispatcher for current Hyprland; legacy fallback for older versions.
            focus = "hl.dsp.focus({ window = " + json.dumps(address) + " })"
            result = subprocess.run(["hyprctl", "dispatch", focus], capture_output=True)
            if result.returncode == 0:
                return
            if subprocess.run(["hyprctl", "dispatch", "focuswindow", address]).returncode == 0:
                return
            raise SystemExit("Could not focus existing window; application was not duplicated")
    except (OSError, subprocess.CalledProcessError, json.JSONDecodeError) as error:
        print(f"launch-or-focus: cannot query Hyprland: {error}", file=sys.stderr)
        raise SystemExit(1)
    os.execvp("uwsm", ["uwsm", "app", "--", *command])


if __name__ == "__main__":
    main(sys.argv[1:])
