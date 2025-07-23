#!/bin/bash

# === Colors ===
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}"
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
 EOF



# === Configuration ===
zip_file="secret.zip"
wordlist="d3c0d3d.txt"

# === Check files ===
if [ ! -f "$zip_file" ]; then
  echo -e "${RED}[!] ZIP file '$zip_file' nahi mila.${NC}"
  exit 1
fi

if [ ! -f "$wordlist" ]; then
  echo -e "${RED}[!] Wordlist file '$wordlist' nahi mila.${NC}"
  exit 1
fi

echo -e "${YELLOW}🔐 ZIP Cracker by D3C0D3D${NC}"
echo -e "${YELLOW}📁 ZIP File: $zip_file${NC}"
echo -e "${YELLOW}📄 Wordlist: $wordlist${NC}"
echo -e "${YELLOW}🔄 Passwords try ho rahe hain...${NC}"

count=0

# === Start cracking ===
while read -r password; do
  count=$((count + 1))
  echo -e "${YELLOW}🔍 Trying: $password${NC}"

  unzip -t -P "$password" "$zip_file" >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}✅ Password mil gaya: $password${NC}"
    echo -e "${GREEN}🔢 Attempts: $count${NC}"
    exit 0
  fi
done < "$wordlist"

# === Not Found ===
echo -e "\n${RED}❌ Sorry, password nahi mila wordlist me.${NC}"
echo -e "${RED}🔢 Total attempts: $count${NC}"
exit 1