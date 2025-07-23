#!/usr/bin/env bash

# Check internet connection
ping -c 1 google.com >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Please check your internet connection."
  exit 1
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No color

clear
echo -e "${RED}"
cat << "EOF"
                 uuuuuuu
             uu$$$$$$$$$$$uu
          uu$$$$$$$$$$$$$$$$$uu
         u$$$$$$$$$$$$$$$$$$$$$u
        u$$$$$$$$$$$$$$$$$$$$$$$u
       u$$$$$$$$$$$$$$$$$$$$$$$$$u
       u$$$$$$$$$$$$$$$$$$$$$$$$$u
       u$$$$$$"   "$$$"   "$$$$$$u
       "$$$$"      u$u       $$$$"
        $$$u       u$u       u$$$
        $$$u      u$$$u      u$$$
         "$$$$uu$$$   $$$uu$$$$"
          "$$$$$$$"   "$$$$$$$"
            u$$$$$$$u$$$$$$$u
             u$"$"$"$"$"$"$u
  uuu        $$u$ $ $ $ $u$$       uuu
 u$$$$        $$$$$u$u$u$$$       u$$$$
  $$$$$uu      "$$$$$$$$$"     uu$$$$$$
u$$$$$$$$$$$uu    """""    uuuu$$$$$$$$$$
$$$$"""$$$$$$$$$$uuu   uu$$$$$$$$$"""$$$"
 """      ""$$$$$$$$$$$uu ""$"""
           uuuu ""$$$$$$$$$$uuu
  u$$$uuu$$$$$$$$$uu ""$$$$$$$$$$$uuu$$$
  $$$$$$$$$$""""           ""$$$$$$$$$$$"
   "$$$$$"                      ""$$$$""
     $$$"                         $$$$"

     🔐 ZIP PASSWORD CRACKER 🔐
            By: D3C0D3D
EOF
echo -e "${NC}"
echo ""

# Ask for zip file
read -p "Enter zip filename: " zipfile
if [ ! -f "$zipfile" ]; then
  echo -e "${RED}[✘] ZIP file not found!${NC}"
  exit 1
fi

# Use included wordlist
wordlist="d3c0d3d.txt"
if [ ! -f "$wordlist" ]; then
  echo -e "${RED}[✘] Wordlist file '$wordlist' not found in current folder!${NC}"
  exit 1
fi

# Start cracking
echo ""
echo -e "${GREEN}[*] Starting brute-force using '$wordlist'...${NC}"
while read -r pass; do
  echo -ne "Trying: $pass\r"
  unzip -P "$pass" -t "$zipfile" &>/dev/null
  if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}[✓] Password found: $pass${NC}"
    exit 0
  fi
done < "$wordlist"

echo -e "\n${RED}[✘] Password not found in wordlist.${NC}"
