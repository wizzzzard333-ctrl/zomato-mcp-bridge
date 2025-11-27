# 📱 Termux Setup Guide

Run Zomato MCP Bridge locally on your Android phone using Termux!

## 🚀 Quick Setup (One Command)

Open Termux and run:

```bash
curl -fsSL https://raw.githubusercontent.com/wizzzzard333-ctrl/zomato-mcp-bridge/main/termux-setup.sh | bash
```

That's it! The script will:
- ✅ Install Node.js
- ✅ Clone the repository
- ✅ Install dependencies
- ✅ Create helper scripts

## 📱 Usage

### Start Server (Foreground)
```bash
cd ~/zomato-mcp-bridge
./start.sh
```
Server runs on: `http://localhost:3000`

Press `Ctrl+C` to stop.

### Start Server (Background)
```bash
cd ~/zomato-mcp-bridge
./start-background.sh
```
Server runs in background. You can close Termux!

### Stop Background Server
```bash
cd ~/zomato-mcp-bridge
./stop.sh
```

### View Logs
```bash
tail -f ~/zomato-mcp-bridge/server.log
```

## 🌐 Expose to Internet (Optional)

To access from other devices or use with Telegram bot:

### Option 1: LocalTunnel (Easiest)
```bash
pkg install -y localtunnel
lt --port 3000
```
You'll get a public URL like: `https://random-name.loca.lt`

### Option 2: Ngrok
```bash
# Download ngrok for Android
curl -O https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz
tar xvzf ngrok-v3-stable-linux-arm64.tgz
./ngrok http 3000
```

### Option 3: Cloudflare Tunnel
```bash
pkg install -y cloudflared
cloudflared tunnel --url http://localhost:3000
```

## 🧪 Test Your API

### Health Check
```bash
curl http://localhost:3000/
```

### Search Restaurants
```bash
curl "http://localhost:3000/search?query=pizza&location=Mumbai"
```

### Get Coupons
```bash
curl "http://localhost:3000/coupons?restaurantId=12345&location=Mumbai"
```

## 🔄 Auto-Start on Boot

To start server automatically when Termux opens:

```bash
echo "cd ~/zomato-mcp-bridge && ./start-background.sh" >> ~/.bashrc
```

## 🛠️ Troubleshooting

### Server won't start
```bash
# Check if port 3000 is in use
netstat -tuln | grep 3000

# Kill any process on port 3000
kill $(lsof -t -i:3000)
```

### Update the code
```bash
cd ~/zomato-mcp-bridge
git pull
npm install
./stop.sh
./start-background.sh
```

### Check server status
```bash
ps aux | grep node
```

## 📞 Use with Telegram

Once server is running with a public URL (via localtunnel/ngrok):

1. Tell Bhindi AI your server URL
2. Say: "Order pizza from Domino's"
3. Bhindi will call your local server
4. You get payment link + coupons!

## 💡 Tips

- **Battery**: Run in background to save battery
- **Network**: Works on WiFi or mobile data
- **Wake Lock**: Use Termux:Boot app to keep running
- **Notifications**: Use Termux:API for order notifications

## 🔒 Security

Your server runs locally. Only expose to internet when needed!

## 📝 Manual Setup (If Script Fails)

```bash
# Install Node.js
pkg install -y nodejs git

# Clone repo
cd ~
git clone https://github.com/wizzzzard333-ctrl/zomato-mcp-bridge.git
cd zomato-mcp-bridge

# Install dependencies
npm install

# Start server
node index.js
```

## 🆘 Need Help?

Check logs:
```bash
cat ~/zomato-mcp-bridge/server.log
```

Restart everything:
```bash
cd ~/zomato-mcp-bridge
./stop.sh
./start-background.sh
```
