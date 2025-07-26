#!/bin/bash

# X Cyber Squad Module: AIOSEO WordPress API Enumeration Tool
# Author: Neerav Patel (Cyber Expert and Forensic Investigator and Crime Investigator)

# Colors
GR="\033[1;32m"
RD="\033[1;31m"
YL="\033[1;33m"
NC="\033[0m"

echo -e "${GR}╔══════════════════════════════════════════╗"
echo -e "║   X Cyber Squad - AIOSEO API Enumerator  ║"
echo -e "╚══════════════════════════════════════════╝${NC}"

# Input target
if [ -z "$1" ]; then
  echo -e "${YL}[!] Usage: $0 https://target-wordpress-site.com${NC}"
  exit 1
fi

TARGET="$1"
API_URL="$TARGET/wp-json"

echo -e "${GR}[*] Target: $TARGET${NC}"
echo -e "${GR}[*] Fetching REST API map...${NC}"

# Fetch API response
RESPONSE=$(curl -s "$API_URL")

if [ -z "$RESPONSE" ]; then
  echo -e "${RD}[!] No response from target. Target may be blocking or down.${NC}"
  exit 1
fi

# Parse and filter AIOSEO endpoints
echo -e "${GR}[*] Extracting AIOSEO endpoints...${NC}"
ENDPOINTS=$(echo "$RESPONSE" | jq -r '.routes | keys[]' | grep '^/aioseo/v1/' | sort -u)

if [ -z "$ENDPOINTS" ]; then
    echo -e "${RD}[!] No AIOSEO endpoints found on this target.${NC}"
    exit 0
fi

# Output file setup
OUTPUT_FILE="xcs_aioseo_results_$(date +%Y%m%d_%H%M%S).txt"
touch "$OUTPUT_FILE"

# Scan endpoints
echo -e "${YL}[*] Scanning endpoints...${NC}"
for endpoint in $ENDPOINTS; do
    FULL_URL="$TARGET/wp-json$endpoint"
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" -A "Mozilla/5.0" "$FULL_URL")

    case $STATUS in
        200)
            echo -e "[✅] $FULL_URL -> 200 OK (Public)"
            echo "[200] $FULL_URL" >> "$OUTPUT_FILE"
            ;;
        401)
            echo -e "[🔒] $FULL_URL -> 401 Unauthorized"
            echo "[401] $FULL_URL" >> "$OUTPUT_FILE"
            ;;
        403)
            echo -e "[⛔] $FULL_URL -> 403 Forbidden"
            echo "[403] $FULL_URL" >> "$OUTPUT_FILE"
            ;;
        404)
            echo -e "[❌] $FULL_URL -> 404 Not Found"
            echo "[404] $FULL_URL" >> "$OUTPUT_FILE"
            ;;
        *)
            echo -e "[❓] $FULL_URL -> $STATUS"
            echo "[${STATUS}] $FULL_URL" >> "$OUTPUT_FILE"
            ;;
    esac
done

# Done
echo -e "\n${GR}[✓] Scan Complete. Results saved to: $OUTPUT_FILE${NC}"
