#!/bin/bash

# macOS System Cleanup Script
# Compatible with macOS 26.1 (Darwin 25.x)
# Created for CamoZeroDay

echo "=========================================="
echo "macOS System Cleanup Script"
echo "=========================================="
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This script is designed for macOS only."
    exit 1
fi

# Get macOS version
macos_version=$(sw_vers -productVersion)
darwin_version=$(uname -r)
echo "macOS Version: $macos_version"
echo "Darwin Kernel: $darwin_version"
echo ""

# Function to print section headers
print_section() {
    echo ""
    echo ">>> $1"
}

# Function to get directory size
get_size() {
    if [ -d "$1" ]; then
        du -sh "$1" 2>/dev/null | awk '{print $1}'
    else
        echo "0B"
    fi
}

# Check disk space before cleanup
print_section "Disk Space Before Cleanup"
df -h / | grep -v Filesystem

# 1. Clear User Caches
print_section "Clearing user caches..."
cache_size=$(get_size ~/Library/Caches)
echo "User cache size: $cache_size"
rm -rf ~/Library/Caches/* 2>/dev/null
echo "✓ User caches cleared"

# 2. Clear System Caches (requires sudo)
print_section "Clearing system caches..."
system_cache_size=$(get_size /Library/Caches)
echo "System cache size: $system_cache_size"
sudo rm -rf /Library/Caches/* 2>/dev/null
echo "✓ System caches cleared"

# 3. Clear DNS Cache
print_section "Flushing DNS cache..."
sudo dscacheutil -flushcache 2>/dev/null
sudo killall -HUP mDNSResponder 2>/dev/null
echo "✓ DNS cache flushed"

# 4. Clear Download History/Quarantine
print_section "Clearing download quarantine history..."
if [ -f ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2 ]; then
    rm -f ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2
    echo "✓ Download history cleared"
else
    echo "✓ No download history to clear"
fi

# 5. Empty Trash
print_section "Emptying trash..."
trash_size=$(get_size ~/.Trash)
echo "Trash size: $trash_size"
rm -rf ~/.Trash/* 2>/dev/null
echo "✓ Trash emptied"

# 6. Clear application logs
print_section "Clearing old application logs..."
log_size=$(get_size ~/Library/Logs)
echo "Log size: $log_size"
find ~/Library/Logs -type f -mtime +30 -delete 2>/dev/null
echo "✓ Old logs cleared (>30 days)"

# 7. Run system maintenance (if available)
print_section "Running system maintenance scripts..."
if command -v periodic &> /dev/null; then
    sudo periodic daily weekly monthly 2>/dev/null
    echo "✓ System maintenance completed"
else
    echo "✓ Periodic maintenance not available (macOS 26.1+)"
fi

# 8. Clear old system logs
print_section "Clearing old system logs..."
sudo log collect --last 7d >/dev/null 2>&1
echo "✓ System logs archived"

# 9. Clear Homebrew cache (if Homebrew is installed)
if command -v brew &> /dev/null; then
    print_section "Clearing Homebrew cache..."
    brew_cache_size=$(get_size $(brew --cache))
    echo "Homebrew cache size: $brew_cache_size"
    brew cleanup -s 2>/dev/null
    brew autoremove 2>/dev/null
    echo "✓ Homebrew cache cleared"
fi

# 10. Clear old iOS/iPadOS backups (if any)
print_section "Checking for old iOS backups..."
backup_dir=~/Library/Application\ Support/MobileSync/Backup
if [ -d "$backup_dir" ]; then
    backup_size=$(get_size "$backup_dir")
    echo "iOS backup size: $backup_size"
    echo "  (Skipping - manual review recommended)"
else
    echo "✓ No iOS backups found"
fi

# 11. Clear Mail downloads cache
print_section "Clearing Mail downloads..."
if [ -d ~/Library/Mail/V* ]; then
    find ~/Library/Mail/V*/MailData -name "Envelope Index*" -delete 2>/dev/null
    echo "✓ Mail cache cleared"
else
    echo "✓ No Mail cache to clear"
fi

# 12. Clear Safari cache (if Safari is used)
print_section "Clearing Safari cache..."
if [ -d ~/Library/Caches/com.apple.Safari ]; then
    rm -rf ~/Library/Caches/com.apple.Safari/* 2>/dev/null
    echo "✓ Safari cache cleared"
else
    echo "✓ No Safari cache to clear"
fi

# 13. Clear Xcode derived data (if Xcode is installed)
print_section "Clearing Xcode derived data..."
if [ -d ~/Library/Developer/Xcode/DerivedData ]; then
    xcode_size=$(get_size ~/Library/Developer/Xcode/DerivedData)
    echo "Xcode derived data size: $xcode_size"
    rm -rf ~/Library/Developer/Xcode/DerivedData/* 2>/dev/null
    echo "✓ Xcode derived data cleared"
else
    echo "✓ No Xcode derived data found"
fi

# 14. Clear Docker cache (if Docker is installed)
if command -v docker &> /dev/null; then
    print_section "Clearing Docker cache..."
    echo "  (Skipping - use 'docker system prune' manually if needed)"
fi

# 15. Purge inactive memory (force macOS to free up RAM)
print_section "Purging inactive memory..."
sudo purge 2>/dev/null
echo "✓ Memory purged"

# Final disk space check
print_section "Disk Space After Cleanup"
df -h / | grep -v Filesystem

# Summary
echo ""
echo "=========================================="
echo "Cleanup Complete!"
echo "=========================================="
echo ""
echo "Recommendations:"
echo "  1. Restart your Mac for best results"
echo "  2. Run this script monthly for maintenance"
echo "  3. Check disk usage: 'du -sh ~/* | sort -hr | head -20'"
echo ""
