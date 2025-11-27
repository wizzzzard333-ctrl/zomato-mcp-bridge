#!/data/data/com.termux/files/usr/bin/bash

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

BASE_URL="${1:-http://localhost:3000}"

echo -e "${YELLOW}🧪 Testing Zomato MCP Bridge API${NC}"
echo -e "${YELLOW}Base URL: $BASE_URL${NC}"
echo ""

# Test 1: Health Check
echo -e "${YELLOW}Test 1: Health Check${NC}"
response=$(curl -s "$BASE_URL/")
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✅ Server is running${NC}"
  echo "$response" | jq '.' 2>/dev/null || echo "$response"
else
  echo -e "${RED}❌ Server is not responding${NC}"
fi
echo ""

# Test 2: Search Restaurants
echo -e "${YELLOW}Test 2: Search Restaurants${NC}"
response=$(curl -s "$BASE_URL/search?query=pizza&location=Mumbai")
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✅ Search endpoint working${NC}"
  echo "$response" | jq '.' 2>/dev/null || echo "$response"
else
  echo -e "${RED}❌ Search endpoint failed${NC}"
fi
echo ""

# Test 3: Get Coupons
echo -e "${YELLOW}Test 3: Get Coupons${NC}"
response=$(curl -s "$BASE_URL/coupons?restaurantId=12345&location=Mumbai")
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✅ Coupons endpoint working${NC}"
  echo "$response" | jq '.' 2>/dev/null || echo "$response"
else
  echo -e "${RED}❌ Coupons endpoint failed${NC}"
fi
echo ""

# Test 4: Place Order
echo -e "${YELLOW}Test 4: Place Order${NC}"
response=$(curl -s -X POST "$BASE_URL/order" \
  -H "Content-Type: application/json" \
  -d '{"restaurant":"Dominos","items":["Margherita Pizza"],"location":"Mumbai","address":"123 Main St"}')
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✅ Order endpoint working${NC}"
  echo "$response" | jq '.' 2>/dev/null || echo "$response"
else
  echo -e "${RED}❌ Order endpoint failed${NC}"
fi
echo ""

echo -e "${GREEN}✅ All tests completed!${NC}"
