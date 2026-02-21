#!/bin/bash

# Automated Daily GitHub Push Script
# This script creates a daily entry and pushes to GitHub
# Only runs once per day - safe to trigger multiple times

# Change to the script directory
cd "$(dirname "$0")"

# Get current date
DATE=$(date +"%Y-%m-%d")
LAST_RUN_FILE=".last-run-date"

# Check if already ran today
if [ -f "$LAST_RUN_FILE" ]; then
    LAST_RUN=$(cat "$LAST_RUN_FILE")
    if [ "$LAST_RUN" = "$DATE" ]; then
        echo "⏭️  Already pushed today ($DATE). Skipping..."
        exit 0
    fi
fi

# Calculate day number
DAY_NUMBER=$((($(date +%s) - $(date -j -f "%Y-%m-%d" "2026-02-22" +%s)) / 86400 + 1))

# Create or append to daily log file
echo "Day $DAY_NUMBER - $DATE" >> daily-log.txt
echo "Automated push completed at $(date +"%H:%M:%S")" >> daily-log.txt
echo "---" >> daily-log.txt

# Git operations
git add daily-log.txt

# Commit with date
git commit -m "Day $DAY_NUMBER: Automated daily push - $DATE"

# Push to GitHub
git push origin main

# Mark today as completed
echo "$DATE" > "$LAST_RUN_FILE"

echo "✅ Successfully pushed Day $DAY_NUMBER to GitHub!"
