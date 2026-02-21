# Automated Daily GitHub Push

This project automatically pushes a daily log file to GitHub every day.

## Setup Instructions

### 1. Initialize Git Repository

```bash
cd "/Users/joviansanjayaputra/Documents/Personal Projects/automated-github-push"
git init
git add .
git commit -m "Initial commit"
```

### 2. Create GitHub Repository

1. Go to https://github.com/new
2. Create a new repository (e.g., "daily-push-log")
3. Don't initialize with README (we already have files)

### 3. Connect to GitHub

```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```

### 4. Make Script Executable

```bash
chmod +x daily-push.sh
```

### 5. Test the Script

```bash
./daily-push.sh
```

### 6. Set Up Daily Automation (Cron Job)

#### Option A: Using Crontab (Traditional)

1. Open crontab editor:
```bash
crontab -e
```

2. Add this line (runs daily at 9:00 AM):
```
0 9 * * * /bin/bash "/Users/joviansanjayaputra/Documents/Personal Projects/automated-github-push/daily-push.sh" >> "/Users/joviansanjayaputra/Documents/Personal Projects/automated-github-push/cron.log" 2>&1
```

3. Save and exit

#### Option B: Using launchd (macOS Recommended)

Create a launch agent file:

```bash
# Create the plist file
nano ~/Library/LaunchAgents/com.user.dailygithubpush.plist
```

Add this content (see setup-launchd.plist for template)

Then load it:
```bash
launchctl load ~/Library/LaunchAgents/com.user.dailygithubpush.plist
```

## Cron Schedule Examples

- `0 9 * * *` - Every day at 9:00 AM
- `0 12 * * *` - Every day at 12:00 PM (noon)
- `0 20 * * *` - Every day at 8:00 PM
- `0 */6 * * *` - Every 6 hours
- `0 0 * * *` - Every day at midnight

## Troubleshooting

### Script not running automatically?

1. Check if cron has permissions on macOS:
   - System Preferences > Security & Privacy > Privacy > Full Disk Access
   - Add Terminal or cron

2. Check cron logs:
```bash
tail -f cron.log
```

3. Verify crontab is set:
```bash
crontab -l
```

### Git authentication issues?

Use SSH instead of HTTPS:
```bash
git remote set-url origin git@github.com:YOUR_USERNAME/YOUR_REPO_NAME.git
```

Or use a Personal Access Token for HTTPS.

## Manual Test

Run the script manually anytime:
```bash
./daily-push.sh
```

## What It Does

Every day, the script:
1. ✅ Creates a new entry in `daily-log.txt` with the day number and date
2. ✅ Commits the changes to git
3. ✅ Pushes to GitHub automatically

## Files

- `daily-push.sh` - Main automation script
- `daily-log.txt` - Daily log file that gets updated
- `README.md` - This file
- `cron.log` - Log file for cron execution (created automatically)
