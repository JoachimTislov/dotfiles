# Windows configuration files

This repository contains configuration files and scripts for setting up and customizing a Windows environment. It includes settings for various applications, system tweaks, and automation scripts to streamline the setup process.

## Setting up symbolic links

Choose either of the following commands to create symbolic links for configuration files:

- $sourcePath - Path to the original configuration file or directory.
- $targetPath - Path where the symbolic link should be created.

```powershell
New-Item -ItemType SymbolicLink -Path $targetPath -Target $sourcePath -Force
```

```cmd
mklink $targetPath $sourcePath
```
