# macOS Utilities

![macOS](https://img.shields.io/badge/macOS-26.1+-000000?style=for-the-badge&logo=apple&logoColor=white)
![Shell](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen?style=for-the-badge)

Collection of utility scripts for macOS system maintenance, optimization, and automation.

## 🎯 Purpose

Simplify macOS system maintenance with safe, automated cleanup scripts that free disk space and optimize performance.

## 📦 Available Scripts

### macos_cleanup.sh

Comprehensive system cleanup script that safely removes temporary files, caches, and performs system maintenance.

**Key Features:**
- ✅ Safe cache cleanup (user & system)
- ✅ DNS and memory optimization
- ✅ Log management and archiving
- ✅ Developer tools cleanup (Xcode, Homebrew, Docker)
- ✅ Disk space reporting (before/after)
- ✅ Non-destructive operations only

## 🚀 Quick Start

### Prerequisites

- macOS 26.1+ (Darwin 25.x) - compatible with earlier versions
- Administrator privileges (sudo access)
- Terminal access

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/CamoRageaholic1/macos-utilities.git
   cd macos-utilities
   ```

2. **Make scripts executable**
   ```bash
   chmod +x macos_cleanup.sh
   ```

### Usage

```bash
# Run the cleanup script
./macos_cleanup.sh
```

You'll be prompted for your administrator password for system-level operations.

## 📋 What Gets Cleaned

| Item | Location | Safe? | Typical Size |
|------|----------|-------|--------------|
| User caches | `~/Library/Caches/*` | ✅ Yes | 1-5 GB |
| System caches | `/Library/Caches/*` | ✅ Yes | 500MB-2GB |
| DNS cache | System memory | ✅ Yes | N/A |
| Download history | Quarantine database | ✅ Yes | <1 MB |
| Trash | `~/.Trash/*` | ✅ Yes | Varies |
| Old logs (>30 days) | `~/Library/Logs` | ✅ Yes | 100MB-1GB |
| Safari cache | Safari caches | ✅ Yes | 500MB-2GB |
| Homebrew cache | `$(brew --cache)` | ✅ Yes | 1-5 GB |
| Xcode derived data | DerivedData folder | ✅ Yes | 5-20 GB |

**Protected Items:**
- ❌ iOS backups (reported but NOT deleted)
- ❌ User documents and files
- ❌ Application settings and preferences

## 🔧 Features in Detail

### Cache Cleanup
- Clears user-level caches (`~/Library/Caches`)
- Removes system caches (`/Library/Caches`)
- Cleans Safari browsing cache
- Purges Homebrew package cache

### System Maintenance
- Flushes DNS cache for network refresh
- Purges inactive memory
- Clears download quarantine history
- Empties trash automatically

### Log Management
- Removes application logs older than 30 days
- Archives system logs
- Clears Mail application cache

### Developer Tools
- Clears Xcode derived data (saves 5-20GB)
- Reports Docker cache size (manual cleanup recommended)
- Homebrew cleanup and autoremove

### Disk Space Reporting
- Shows disk usage before cleanup
- Displays size of each cache being cleared
- Provides comprehensive cleanup summary
- Calculates total space recovered

## 📊 Example Output

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

>>> Flushing DNS cache...
✓ DNS cache flushed

>>> Clearing Xcode derived data...
Xcode cache size: 12.4G
✓ Xcode derived data cleared

>>> Disk Space After Cleanup
/dev/disk3s1s1  460Gi  334Gi  126Gi  73%  /

==========================================
Cleanup Complete!
Space Recovered: ~16GB
==========================================

Recommendations:
  1. Restart your Mac for best results
  2. Run this script monthly for maintenance
  3. Check disk usage: 'du -sh ~/* | sort -hr | head -20'
```

## 📅 Recommended Usage Schedule

- **Monthly:** Regular maintenance and optimization
- **After Major Updates:** Clear old system files
- **When Disk is Full:** Free up significant space quickly
- **Before Backups:** Reduce backup size and time

## 🔒 Safety Features

- ✅ **Non-destructive** - Only removes temporary/cache files
- ✅ **Permission checks** - Requires sudo only when necessary
- ✅ **Conditional execution** - Skips missing apps/directories
- ✅ **Error handling** - Gracefully handles missing files
- ✅ **iOS backup protection** - Reports but never deletes backups

## 🛠️ Troubleshooting

### "Permission denied" errors
```bash
# Run with sudo
sudo ./macos_cleanup.sh

# Or fix permissions
chmod +x macos_cleanup.sh
```

### "Command not found" errors
The script automatically checks for command availability and skips missing tools.

### Homebrew cleanup fails
```bash
# Run manually
brew cleanup -s && brew autoremove
```

## 💻 Compatibility

| macOS Version | Status | Notes |
|---------------|--------|-------|
| 26.1+ (Latest) | ✅ Tested | Fully compatible |
| 25.x (Sequoia) | ✅ Compatible | Should work perfectly |
| 24.x (Sonoma) | ✅ Compatible | Fully supported |
| 23.x (Ventura) | ✅ Compatible | Fully supported |
| 22.x and older | ⚠️ Unknown | May need modifications |

**Architecture Support:**
- ✅ Apple Silicon (M1, M2, M3, M4)
- ✅ Intel Macs

## 📁 Project Structure

```
macos-utilities/
├── macos_cleanup.sh      # System cleanup script
├── README.md             # This file
├── LICENSE               # MIT License
└── .gitignore           # Git ignore rules
```

## 🛣️ Roadmap

Future utilities planned:

- [ ] Automated backup script
- [ ] Network diagnostics tool
- [ ] Application uninstaller
- [ ] Duplicate file finder
- [ ] Startup optimization script
- [ ] Security audit tool
- [ ] System health monitor

## 🤝 Contributing

Contributions welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-utility`)
3. Commit your changes (`git commit -m 'Add new utility'`)
4. Push to branch (`git push origin feature/new-utility`)
5. Open a Pull Request

**Ideas for contributions:**
- Additional utility scripts
- Performance improvements
- Better error handling
- Cross-version compatibility
- Automation features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Disclaimer

This script is provided as-is. Always review scripts before running them with administrator privileges. While designed to be safe, the author is not responsible for any data loss or system issues.

**Best Practices:**
- Review script contents before first run
- Test in a safe environment if concerned
- Ensure important data is backed up
- Don't run scripts you don't understand

## 📫 Support

- 🐛 **Bug Reports:** Open an issue on GitHub
- 💡 **Feature Requests:** Open an issue with the "enhancement" label
- 📧 **Contact:** Reach out via GitHub

## 🙏 Acknowledgments

Built to make macOS maintenance simple and accessible for all users.

---

**Author:** David Osisek (CamoZeroDay)  
**Made with ❤️ for the macOS community**
