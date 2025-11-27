#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 Setting up Zomato MCP Bridge on Termux..."

# Update packages
echo "📦 Updating Termux packages..."
pkg update -y && pkg upgrade -y

# Install Node.js
echo "📦 Installing Node.js..."
pkg install -y nodejs

# Install git if not present
pkg install -y git

# Clone the repository
echo "📥 Cloning repository..."
cd ~
rm -rf zomato-mcp-bridge
git clone https://github.com/wizzzzard333-ctrl/zomato-mcp-bridge.git
cd zomato-mcp-bridge

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Create start script
cat > start.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
cd ~/zomato-mcp-bridge
node index.js
EOF

chmod +x start.sh

# Create background service script
cat > start-background.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
cd ~/zomato-mcp-bridge
nohup node index.js > server.log 2>&1 &
echo $! > server.pid
echo "✅ Server started in background (PID: $(cat server.pid))"
echo "📝 Logs: tail -f ~/zomato-mcp-bridge/server.log"
echo "🛑 Stop: kill $(cat ~/zomato-mcp-bridge/server.pid)"
EOF

chmod +x start-background.sh

# Create stop script
cat > stop.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
if [ -f ~/zomato-mcp-bridge/server.pid ]; then
  kill $(cat ~/zomato-mcp-bridge/server.pid)
  rm ~/zomato-mcp-bridge/server.pid
  echo "✅ Server stopped"
else
  echo "❌ Server not running"
fi
EOF

chmod +x stop.sh

echo ""
echo "✅ Setup complete!"
echo ""
echo "📱 To start the server:"
echo "   cd ~/zomato-mcp-bridge"
echo "   ./start.sh"
echo ""
echo "🔄 To run in background:"
echo "   ./start-background.sh"
echo ""
echo "🛑 To stop background server:"
echo "   ./stop.sh"
echo ""
echo "🌐 Server will run on: http://localhost:3000"
echo ""
