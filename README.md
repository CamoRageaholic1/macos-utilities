# macOS Utilities

Collection of utility scripts for macOS system maintenance and optimization.

## Scripts

### macos_cleanup.sh

A comprehensive system cleanup script for macOS that safely removes temporary files, caches, and performs system maintenance.

#### Compatibility

- **macOS Version:** 26.1+ (Darwin 25.x)
- **Architecture:** Universal (Intel & Apple Silicon)

#### Features

- **Cache Cleanup**
  - Clears user caches (`~/Library/Caches`)
  - Clears system caches (`/Library/Caches`)
  - Clears Safari cache
  - Clears Homebrew cache (if installed)

- **System Maintenance**
  - Flushes DNS cache
  - Purges inactive memory
  - Clears download quarantine history
  - Empties trash

- **Log Management**
  - Removes old application logs (>30 days)
  - Archives system logs
  - Clears Mail cache

- **Developer Tools**
  - Clears Xcode derived data (if installed)
  - Notes Docker cache (manual cleanup recommended)

- **Disk Space Reporting**
  - Shows before/after disk usage
  - Displays size of caches being cleared
  - Provides cleanup summary

#### Usage

```bash
# Make the script executable (if not already)
chmod +x macos_cleanup.sh

# Run the cleanup script
./macos_cleanup.sh
```

You will be prompted for your administrator password (sudo) to clear system-level caches and perform privileged operations.

#### What Gets Cleaned

| Item | Location | Safe to Remove? |
|------|----------|-----------------|
| User caches | `~/Library/Caches/*` | Yes |
| System caches | `/Library/Caches/*` | Yes |
| DNS cache | System memory | Yes |
| Download history | Quarantine database | Yes |
| Trash | `~/.Trash/*` | Yes |
| Old logs | `~/Library/Logs` (>30 days) | Yes |
| Safari cache | `~/Library/Caches/com.apple.Safari` | Yes |
| Homebrew cache | `$(brew --cache)` | Yes |
| Xcode derived data | `~/Library/Developer/Xcode/DerivedData` | Yes |

#### Safety Features

- **Non-destructive:** Only removes temporary files and caches
- **Permission checks:** Requires sudo only for system-level operations
- **Conditional execution:** Skips missing applications/directories
- **Error suppression:** Handles missing files gracefully
- **iOS backup protection:** Reports but doesn't delete iOS backups

#### Recommended Schedule

- **Monthly:** Regular maintenance
- **After major updates:** Clear old system files
- **When disk is full:** Free up significant space

#### Output Example

```
==========================================
macOS System Cleanup Script
==========================================

macOS Version: 26.1
Darwin Kernel: 25.1.0

>>> Disk Space Before Cleanup
/dev/disk3s1s1  460Gi  350Gi  110Gi  77%  /

>>> Clearing user caches...
User cache size: 2.3G
✓ User caches cleared

>>> Clearing system caches...
System cache size: 1.1G
✓ System caches cleared

...

>>> Disk Space After Cleanup
/dev/disk3s1s1  460Gi  345Gi  115Gi  75%  /

==========================================
Cleanup Complete!
==========================================

Recommendations:
  1. Restart your Mac for best results
  2. Run this script monthly for maintenance
  3. Check disk usage: 'du -sh ~/* | sort -hr | head -20'
```

#### Troubleshooting

**"Permission denied" errors**
- Run with sudo: `sudo ./macos_cleanup.sh`
- Check file permissions: `chmod +x macos_cleanup.sh`

**"Command not found" errors**
- The script checks for command availability
- Missing commands are skipped automatically

**Homebrew cleanup fails**
- Run manually: `brew cleanup -s && brew autoremove`

#### macOS Version Compatibility

| macOS Version | Status | Notes |
|---------------|--------|-------|
| 26.1 | Tested | Fully compatible |
| 25.x (Sequoia) | Compatible | Should work |
| 24.x (Sonoma) | Compatible | Should work |
| 23.x (Ventura) | Compatible | `periodic` command available |
| Older | Unknown | May require modifications |

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - Feel free to use and modify as needed.

## Author

**CamoZeroDay** (David Osisek)

## Disclaimer

This script is provided as-is. Always review scripts before running them with administrator privileges. While this script is designed to be safe, the author is not responsible for any data loss or system issues.

## Additional Notes

- The script automatically detects your system configuration
- Homebrew-specific cleanup only runs if Homebrew is installed
- Developer tool cleanup (Xcode, Docker) is conditional
- iOS backups are identified but not deleted (manual review recommended)
