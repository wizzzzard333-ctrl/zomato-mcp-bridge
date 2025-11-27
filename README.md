# 🍕 Zomato MCP Bridge

AI-powered Zomato ordering bridge with MCP integration for mobile food ordering via Telegram.

## 🚀 Features

- **Search Restaurants**: Find restaurants by name, cuisine, location, or rating
- **Place Orders**: Order food with AI assistance
- **Get Coupons**: Fetch available coupons and discounts
- **View Menus**: Browse restaurant menus
- **Payment Links**: Get direct payment links for orders

## 📡 API Endpoints

### Health Check
```
GET /
```

### Search Restaurants
```
GET /search?query=pizza&location=Mumbai&cuisine=Italian&rating=4
```

### Place Order
```
POST /order
Content-Type: application/json

{
  "restaurant": "Domino's Pizza",
  "items": ["Margherita Pizza", "Garlic Bread"],
  "location": "Mumbai",
  "address": "123 Main Street"
}
```

### Get Coupons
```
GET /coupons?restaurantId=12345&location=Mumbai
```

### Get Menu
```
GET /menu/:restaurantId
```

## 🛠️ Deployment

### Deploy to Railway

1. Click the button below:

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/wizzzzard333-ctrl/zomato-mcp-bridge)

2. Your API will be live at: `https://your-app.up.railway.app`

### Manual Deployment

```bash
# Clone the repo
git clone https://github.com/wizzzzard333-ctrl/zomato-mcp-bridge.git
cd zomato-mcp-bridge

# Install dependencies
npm install

# Start server
npm start
```

## 📱 Mobile Usage

Use with Telegram bot or any HTTP client:

```bash
# Search for restaurants
curl "https://your-app.up.railway.app/search?query=pizza&location=Mumbai"

# Place an order
curl -X POST https://your-app.up.railway.app/order \
  -H "Content-Type: application/json" \
  -d '{"restaurant":"Dominos","items":["Pizza"],"location":"Mumbai"}'
```

## 🔗 Integration with Bhindi AI

Once deployed, you can order food via Telegram by simply saying:
- "Order pizza from Domino's"
- "Find Italian restaurants near me"
- "Get coupons for Burger King"

## 📝 License

MIT
