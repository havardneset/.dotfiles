
# Dotfiles Setup Guide

This guide will walk you through the process of cloning a dotfiles repository and managing your configurations using **GNU Stow**. 

## Prerequisites

1. **GNU Stow**: Install GNU Stow:
   ```bash
   brew install stow         # macOS
   ```

## Cloning the Repository

1. Navigate to your home directory:
   ```bash
   cd ~
   ```
2. Clone the dotfiles repository:
   ```bash
   git clone https://github.com/havardneset/.dotfiles.git
   ```
3. Move into the repository:
   ```bash
   cd .dotfiles
   ```

## Directory Structure

The repository should be organized to be similar to how the paths should be relative to your home folder 

```
.dotfiles/
├── .config/
│   └── nvim
├── .zshrc
```

## Using GNU Stow

GNU Stow creates symlinks from the files in your repository to your home directory. Follow these steps to link configurations:

1. Create symlinks for all files
   ```bash
   stow .
   ```
   This creates a symlink for every folder in the repository in your home directory.

## Updating Configurations

1. Edit the files directly in the `.dotfiles` repository.
2. Commit and push your changes:
   ```bash
   git add .
   git commit -m "Update configuration"
   git push
   ```

