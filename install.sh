#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Backup directory setup
BACKUP_DIR="./backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Define packages: "Package Name:Binary Name"
# Config path is now automatically detected based on stow structure.
PACKAGES=(
    "ghostty:ghostty"
    "nvim:nvim"
    "zsh:zsh"
    "helix:hx"
    "rofi:rofi"
    "zed:zed"
    "starship:starship"
)

# Directories that should NOT be moved/symlinked directly, but folded into.
# We will recurse into these looking for the actual package configs.
PROTECTED_PATHS=(
    ".config"
    ".local"
    ".local/share"
    ".local/bin"
    ".local/state"
    ".cache"
    "."
)

# Function to check if a path is protected
is_protected() {
    local path="$1"
    # Remove leading ./
    path="${path#./}"
    # Remove trailing /
    path="${path%/}"
    
    for protected in "${PROTECTED_PATHS[@]}"; do
        if [ "$path" == "$protected" ]; then
            return 0 # True
        fi
    done
    return 1 # False
}

echo -e "${GREEN}Starting dotfiles installation...${NC}"
echo -e "${YELLOW}Backups will be stored in: $BACKUP_DIR${NC}\n"

for entry in "${PACKAGES[@]}"; do
    IFS=":" read -r pkg binary <<< "$entry"
    
    echo -e "Processing ${GREEN}$pkg${NC}..."

    # 1. Check if program is installed
    if ! command -v "$binary" &> /dev/null; then
        echo -e "${YELLOW}  -> Warning: '$binary' not found. Skipping $pkg.${NC}"
        continue
    fi

    # 2. Detect conflicts automatically
    pkg_dir="./$pkg"
    
    if [ ! -d "$pkg_dir" ]; then
         echo -e "${RED}  -> Error: Package directory '$pkg_dir' not found!${NC}"
         continue
    fi

    # We walk the package directory structure
    # find . -mindepth 1 outputs: ./file, ./.config, ./.config/app ...
    # We process depth-first naturally, but we need to be careful not to process children of moved dirs.
    # Actually, checking existence of target handles that.

    while IFS= read -r rel_path; do
        # rel_path is like "./.config/ghostty"
        clean_path="${rel_path#./}"
        target="$HOME/$clean_path"

        # If this path is protected (e.g. .config), we skip it (stow will fold it)
        if is_protected "$clean_path"; then
            # Ensure the protected directory exists on target so stow folds into it
            if [ ! -d "$target" ]; then
                echo -e "  -> Creating system directory $target"
                mkdir -p "$target"
            fi
            continue
        fi

        # If target exists and is not a symlink, it's a conflict
        if [ -e "$target" ] || [ -L "$target" ]; then
            # Check if it's already correctly linked to our source
            # We use readlink -f to get canonical paths for both
            abs_source=$(readlink -f "$pkg_dir/$rel_path")
            # For target, readlink -f works even if it's a symlink or file
            abs_target=$(readlink -f "$target")
            
            if [ "$abs_source" == "$abs_target" ]; then
                # It is already pointing to the correct place.
                # We only log if it's the actual symlink (the anchor), 
                # to avoid logging every file inside a linked folder.
                if [ -L "$target" ]; then
                    echo -e "  -> Symlink already correct: $clean_path"
                fi
                continue
            fi

            # If it's a symlink but points somewhere else
            if [ -L "$target" ]; then
                 echo -e "${YELLOW}  -> Warning: Symlink at $target points elsewhere ($abs_target). Skipping backup/stow for this specific file.${NC}"
                 continue
            fi
            
            # It exists, is not a symlink, and paths don't match -> Real Conflict
            echo -e "${YELLOW}  -> Conflict found at $target. Backing up...${NC}"
            
            # Create parent dir in backup
            backup_target="$BACKUP_DIR/$pkg/$(dirname "$clean_path")"
            mkdir -p "$backup_target"
            
            # Move
            mv "$target" "$backup_target/"
            echo -e "  -> Moved to $backup_target/"
        fi

    done < <(find "$pkg_dir" -mindepth 1)

    # 4. Run stow - we capture output to see what happened
    echo -e "  -> Stowing $pkg..."
    stow_output=$(stow -v "$pkg" 2>&1)
    stow_exit_code=$?

    # Check output for specific messages
    if [[ "$stow_output" == *"LINK:"* ]]; then
         echo -e "${GREEN}  -> New symlinks created.${NC}"
         echo "$stow_output" | grep "LINK:" | sed 's/^/     /' 
    elif [[ "$stow_output" == *""* ]] && [ $stow_exit_code -eq 0 ]; then
         # If exit code is 0 and no LINK message, it likely did nothing or just maintained
         # But stow -v usually prints something. If it's empty/quiet, it means all good.
         # However, checking my previous logic, if I skip backup because it matches, 
         # stow might just say nothing or verify.
         echo -e "${GREEN}  -> Configuration already properly linked.${NC}"
    else
         echo -e "${RED}  -> Stow encountered an issue:${NC}"
         echo "$stow_output"
    fi
    
    if [ $stow_exit_code -ne 0 ]; then
         echo -e "${RED}  -> Failed to stow $pkg (Exit code $stow_exit_code)${NC}"
    fi
    echo ""
done

echo -e "${GREEN}Done!${NC}"
# Remove backup dir if empty
if [ -z "$(ls -A $BACKUP_DIR)" ]; then
   rmdir "$BACKUP_DIR"
   echo "No backups were needed, removed empty backup directory."
fi
