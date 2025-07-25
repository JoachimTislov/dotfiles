#!/usr/bin/env python3

#  ___           _     __  __      _   _           
# |   \ __ _ _ _| |__ |  \/  |__ _| |_| |_ ___ _ _ 
# | |) / _` | '_| / / | |\/| / _` |  _|  _/ -_) '_|
# |___/\__,_|_| |_\_\ |_|  |_\__,_|\__|\__\___|_|   GRUB THEME
#
# Version: 2.0                    Written by Vandal (VandalByte)
#
# GitLab (repo)   : https://gitlab.com/VandalByte/darkmatter-grub-theme 
# Github (mirror) : https://github.com/VandalByte/darkmatter-grub2-theme 

# imports
import subprocess
import os
import shutil
import sys


# colors
C = "\033[0m"     # clear (end)
R = "\033[0;31m"  # red (error)
G = "\033[0;32m"  # green (process)
B = "\033[0;36m"  # blue (choice)
Y = "\033[0;33m"  # yellow (info)


# functions
def check_root():
    id = int(subprocess.check_output("id -u", shell=True).decode("utf-8"))
    if id != 0:
        print(f"\n{R}(!){C} Run the script with 'sudo' privileges or as root user !!\n")
        exit()


def check_distro():
    try:
        lsb_id = subprocess.check_output("lsb_release -i", shell=True).decode("utf-8")
        id = lsb_id.split(":")[-1].lower().strip()
    except Exception:
        id = ""
    return id


def change_grub_theme(grub_theme_path):
    with open("/etc/default/grub", "r") as grub_file:
        data = grub_file.readlines()
        flag = False
        for i, line in enumerate(data):
            if line.startswith("GRUB_TERMINAL_OUTPUT"):
                data.pop(i)
                data.insert(i, f"#{line}\n")
            elif line.startswith("GRUB_TIMEOUT_STYLE"):
                data.pop(i)
                data.insert(i, f"#{line}\n")
            elif line.startswith("GRUB_ENABLE_BLSCFG"):
                data.pop(i)
                data.insert(i, "GRUB_ENABLE_BLSCFG=false\n")
            elif line.startswith("GRUB_THEME"):
                flag = True
                data.pop(i)
                data.insert(i, f'GRUB_THEME="{grub_theme_path}"\n')

        if not flag:
            data.append(f'GRUB_THEME="{grub_theme_path}"\n')

    with open("/etc/default/grub", "w") as grub_file:
        grub_file.writelines(data)


def reset_grub_theme():
    with open("/etc/default/grub", "r") as grub_file:
        data = grub_file.readlines()

        for i, line in enumerate(data):
            if line.startswith("GRUB_THEME"):
                data.pop(i)  # removing existing line

    with open("/etc/default/grub", "w") as grub_file:
        grub_file.writelines(data)


def banner():
    print(B)
    print(r"""    ___           _     __  __      _   _           
   |   \ __ _ _ _| |__ |  \/  |__ _| |_| |_ ___ _ _ 
   | |) / _` | '_| / / | |\/| / _` |  _|  _/ -_) '_|
   |___/\__,_|_| |_\_\ |_|  |_\__,_|\__|\__\___|_|  """,end="")
    print(f"{C} GRUB THEME\n")
    print(f"   Written by {B}Vandal{C} (VandalByte)")


def install():
    # installer script
    print("\n   INSTALLER ✔️")
    THEME = "darkmatter"

    # debian | arch
    if os.path.exists("/boot/grub/"):
        GRUB_THEMES_DIR = "/boot/grub/themes/"
        GRUB_UPDATE_CMD = "sudo grub-mkconfig -o /boot/grub/grub.cfg"

        if not os.path.exists(GRUB_THEMES_DIR):
            os.mkdir(GRUB_THEMES_DIR)
    else:
        print(f"\n{R}(!){C} Couldn't find the GRUB directory. Exiting the script ...")
        exit()

    THEME_DIR = f"{GRUB_THEMES_DIR}{THEME}"

    if os.path.exists(THEME_DIR):
        print("\n")
        raise Exception("Theme directory already exists, uninstall it first")
    else:
        os.mkdir(THEME_DIR)

    DIR_PATH = f"{os.getcwd()}/{THEME}/"

    print(f"\n{G}($){C} Copying assets to {THEME_DIR}")
    shutil.copytree(DIR_PATH, THEME_DIR, dirs_exist_ok=True)
    print("    done.\n")

    print(f"\n{G}($){C} Editing the GRUB file ...")
    THEME_PATH = f"{THEME_DIR}/theme.txt"
    change_grub_theme(THEME_PATH)
    print("    done.\n")

    print(f"{G}($){C} Updating GRUB ...\n")
    subprocess.run(GRUB_UPDATE_CMD, shell=True)

    print(f"\n{Y}(#){C} Dark Matter GRUB theme has been successfully installed !!\n")

    distro = check_distro()
    if distro == "kali":  # checking if it's Kali Linux
        print(f"""{R}PS{C}: If you see this note, it means that the script identified your distro as Kali Linux.\n
    To get the theme to work in Kali, you must remove/edit some default files, which you can do by
    following the instructions at {B}https://github.com/VandalByte/grub-tweaks{C}""")
    exit()


def uninstall():
    # uninstaller script
    print("\n   UNINSTALLER ❌\n")
    THEME = "darkmatter"  # theme name

    # debian | arch
    if os.path.exists("/boot/grub/"):
        GRUB_THEME_DIR = f"/boot/grub/themes/{THEME}/"
        GRUB_UPDATE_CMD = "grub-mkconfig -o /boot/grub/grub.cfg"

    # fedora | redhat
    elif os.path.exists("/boot/grub2/"):
        GRUB_THEME_DIR = f"/boot/grub2/themes/{THEME}/"
        GRUB_UPDATE_CMD = "grub2-mkconfig -o /boot/grub2/grub.cfg"

    else:  # if theme not found
        print(f"\n{R}(!){C} Couldn't find the GRUB directory. Exiting the script ...")
        exit()

    ask = input(f"{B}(?){C} Remove Dark Matter GRUB Theme (y/n)? {Y}[default = n]{C} : ")
    if ask.lower() != "y":
        print(f"\n{R}(!){C} No changes were made. Exiting the script ...\n")
        exit()
    else:
        # removing theme folder
        print(f"\n{G}($){C} Removed the theme directory ...\n")
        shutil.rmtree(GRUB_THEME_DIR)
        print("    done.\n")

    # resetting the grub file
    print(f"{G}($){C} Resetting the GRUB file ...\n")
    reset_grub_theme()
    print("    done.\n")

    # updating grub
    print(f"{G}($){C} Updating GRUB ...\n")
    subprocess.run(GRUB_UPDATE_CMD, shell=True)

    print(f"\n{Y}(#){C} Dark Matter GRUB Theme has been successfully removed !!\n")
    exit()


if __name__ == "__main__":
    check_root()  # checking root access
    banner()  # shows banner
    try:
        if len(sys.argv) != 2:
            raise Exception("Invalid number of arguments: Use either '-i' or '-u'")
        if sys.argv[-1] in ["-i", "--install"]:
            install()  # installer
        elif sys.argv[-1] in ["-u", "--uninstall"]:
            uninstall()  # uninstaller
        else:
            raise Exception("Invalid argument provided: Use either '-i' or '-u'")
    except Exception as e:
        print(f"\n{R}(!){C} An unexpected error occurred while running the script !!\n")
        print(f"{R}(!){C} ERROR : {R}{e}{C}")
        exit()
