#!/usr/bin/env python3
"""Efficient chapter generator for 末世星河 using JSON data."""
import json, os, sys

CHAPTERS_DIR = "/root/.openclaw/workspace/novel-projects/novel-04/chapters"
os.makedirs(CHAPTERS_DIR, exist_ok=True)

def write_chapter(num, cn_num, title, body, cliffhanger):
    fn = f"{num:03d}-{cn_num}.md"
    path = os.path.join(CHAPTERS_DIR, fn)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(f"# {cn_num} {title}\n\n{body}\n\n---\n\n*{cliffhanger}*\n")
    return fn

# Load chapter data from JSON file
data_file = sys.argv[1] if len(sys.argv) > 1 else "chapters_data.json"
with open(data_file, 'r', encoding='utf-8') as f:
    chapters = json.load(f)

count = 0
for ch in chapters:
    fn = write_chapter(ch['num'], ch['cn'], ch['title'], ch['body'], ch['cliff'])
    print(f"  {fn}")
    count += 1

print(f"\nGenerated {count} chapters!")
