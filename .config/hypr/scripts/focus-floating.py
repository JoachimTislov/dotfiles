#!/usr/bin/env python3
"""Focus the nearest floating window in a direction on the active workspace."""
import json
import subprocess
import sys


def choose_window(clients, active, workspace, direction):
    candidates = [w for w in clients if w.get('floating') and not w.get('hidden')
                  and w['workspace']['id'] == workspace
                  and w['address'] != active.get('address')]
    if not candidates:
        return None
    def center(w):
        return [w['at'][i] + w['size'][i] / 2 for i in (0, 1)]
    origin = center(active) if active.get('at') else center(candidates[0])
    axis, sign = {'h': (0, -1), 'j': (1, 1), 'k': (1, -1), 'l': (0, 1)}[direction]
    def distance(w):
        pos = center(w)
        return sum((pos[i] - origin[i]) ** 2 for i in (0, 1))
    directional = [w for w in candidates if (center(w)[axis] - origin[axis]) * sign > 1]
    # A centered dialog may overlap its tiled parent in every direction.
    pool = directional or (candidates if not active.get('floating') else [])
    return min(pool, key=distance, default=None)


def main():
    def query(name):
        return json.loads(subprocess.check_output(['hyprctl', '-j', name], text=True))
    target = choose_window(query('clients'), query('activewindow'),
                           query('activeworkspace')['id'], sys.argv[1])
    if target:
        window = json.dumps('address:' + target['address'])
        for command in [f'hl.dsp.focus({{ window = {window} }})',
                        f'hl.dsp.window.alter_zorder({{ window = {window}, mode = "top" }})']:
            subprocess.run(['hyprctl', 'dispatch', command], check=True)


if __name__ == '__main__':
    main()
