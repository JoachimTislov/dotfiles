#!/usr/bin/env python3
"""Install the reviewed Dolphin/Waybar files with timestamped backups."""
from datetime import datetime
from pathlib import Path
import shutil

root = Path(__file__).resolve().parents[1]
home = Path.home()
files = {
    'VagueMacchiato.colors': home / '.local/share/color-schemes/VagueMacchiato.colors',
    'qt6ct.conf': home / '.config/qt6ct/qt6ct.conf',
    'dolphinrc': home / '.config/dolphinrc',
    'waybar.css': home / '.config/waybar/style.css',
    'waybar-modules.json': home / '.config/waybar/modules.json',
}
stamp = datetime.now().strftime('%Y%m%d-%H%M%S-%f')
for source, destination in files.items():
    destination.parent.mkdir(parents=True, exist_ok=True)
    if destination.exists():
        shutil.copy2(destination, destination.with_name(destination.name + '.before-rice-' + stamp))
    shutil.copyfile(root / 'rice/generated' / source, destination)
    print(destination)
