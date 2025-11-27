const express = require('express');
const { Client } = require('@modelcontextprotocol/sdk/client/index.js');
const { StdioClientTransport } = require('@modelcontextprotocol/sdk/client/stdio.js');

const app = express();
app.use(express.json());

let mcpClient = null;

// Initialize MCP connection
async function initializeMCP() {
  try {
    const transport = new StdioClientTransport({
      command: 'npx',
      args: ['mcp-remote', 'https://mcp-server.zomato.com/mcp']
    });

    mcpClient = new Client({
      name: 'zomato-bridge',
      version: '1.0.0'
    }, { capabilities: {} });

    await mcpClient.connect(transport);
    console.log('✅ Connected to Zomato MCP server');
  } catch (error) {
    console.error('❌ Failed to connect to MCP:', error.message);
  }
}

// Health check endpoint
app.get('/', (req, res) => {
  res.json({
    status: 'running',
    service: 'Zomato MCP Bridge',
    mcpConnected: mcpClient !== null,
    endpoints: {
      order: 'POST /order',
      search: 'GET /search',
      coupons: 'GET /coupons',
      menu: 'GET /menu/:restaurantId'
    }
  });
});

// Place order endpoint
app.post('/order', async (req, res) => {
  try {
    if (!mcpClient) {
      return res.status(503).json({ error: 'MCP client not initialized' });
    }

    const { restaurant, items, location, address } = req.body;
    
    const result = await mcpClient.callTool({
      name: 'place_order',
      arguments: { restaurant, items, location, address }
    });
    
    res.json({
      success: true,
      paymentLink: result.paymentLink,
      coupons: result.availableCoupons,
      orderId: result.orderId,
      estimatedDelivery: result.estimatedDelivery,
      totalAmount: result.totalAmount
    });
  } catch (error) {
    res.status(500).json({ 
      success: false,
      error: error.message 
    });
  }
});

// Search restaurants endpoint
app.get('/search', async (req, res) => {
  try {
    if (!mcpClient) {
      return res.status(503).json({ error: 'MCP client not initialized' });
    }

    const { query, location, cuisine, rating } = req.query;
    
    const result = await mcpClient.callTool({
      name: 'search_restaurants',
      arguments: { query, location, cuisine, rating }
    });
    
    res.json({
      success: true,
      restaurants: result.restaurants,
      count: result.count
    });
  } catch (error) {
    res.status(500).json({ 
      success: false,
      error: error.message 
    });
  }
});

// Get available coupons endpoint
app.get('/coupons', async (req, res) => {
  try {
    if (!mcpClient) {
      return res.status(503).json({ error: 'MCP client not initialized' });
    }

    const { restaurantId, location } = req.query;
    
    const result = await mcpClient.callTool({
      name: 'get_coupons',
      arguments: { restaurantId, location }
    });
    
    res.json({
      success: true,
      coupons: result.coupons
    });
  } catch (error) {
    res.status(500).json({ 
      success: false,
      error: error.message 
    });
  }
});

// Get restaurant menu endpoint
app.get('/menu/:restaurantId', async (req, res) => {
  try {
    if (!mcpClient) {
      return res.status(503).json({ error: 'MCP client not initialized' });
    }

    const { restaurantId } = req.params;
    
    const result = await mcpClient.callTool({
      name: 'get_menu',
      arguments: { restaurantId }
    });
    
    res.json({
      success: true,
      menu: result.menu,
      restaurant: result.restaurantInfo
    });
  } catch (error) {
    res.status(500).json({ 
      success: false,
      error: error.message 
    });
  }
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, async () => {
  console.log(`🚀 Server running on port ${PORT}`);
  await initializeMCP();
});
