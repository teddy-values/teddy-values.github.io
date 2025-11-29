#!/bin/bash

# Check if a category is provided
if [ -z "$1" ]; then
  echo "Error: A top-level category is required."
  echo "Usage: $0 <TOP_CATEGORY>"
  exit 1
fi

# --- Variables ---
TOP_CATEGORY=$1
POSTS_DIR="_posts"

# Prompt for user input
read -p "Enter post title: " title
read -p "Enter sub-category: " sub_category
read -p "Enter tags (comma-separated): " tags

# Check for empty title
if [ -z "$title" ]; then
  echo "Error: Title cannot be empty."
  exit 1
fi

# --- Formatting ---
# Date format for filename: YYYY-MM-DD
DATE_SLUG=$(date +%Y-%m-%d)

# Date format for front matter: YYYY-MM-DD HH:MM:SS +/-TTTT
FULL_DATE=$(date +"%Y-%m-%d %H:%M:%S %z")

# Create a URL-friendly slug from the title
# 1. Convert to lowercase
# 2. Replace spaces and underscores with hyphens
# 3. Remove any characters that aren't alphanumeric or a hyphen
SLUG=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed -e 's/[ _]/-/g' -e 's/[^a-z0-9-]//g')

# Format tags for YAML array
FORMATTED_TAGS=$(echo "$tags" | sed 's/,/, /g')

# --- File Creation ---
FILENAME="${POSTS_DIR}/${DATE_SLUG}-${SLUG}.md"

# Create the _posts directory if it doesn't exist
mkdir -p $POSTS_DIR

# Create the post file with the specified front matter using a heredoc
cat << EOM > "$FILENAME"
---
title: $title
date: $FULL_DATE
categories: [$TOP_CATEGORY, $sub_category]
tags: [$FORMATTED_TAGS]     # TAG names should always be lowercase
---
EOM

echo "Successfully created new post: $FILENAME"
