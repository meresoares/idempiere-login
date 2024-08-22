const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();

// Middleware para habilitar CORS en todas las respuestas
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*'); // Permitir todas las fuentes
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS'); // Métodos permitidos
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization'); // Headers permitidos

  // Responder a las solicitudes OPTIONS
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  next();
});

app.use(createProxyMiddleware({
  target: 'https://idempiere-api.monalisa.com.py:8443',
  changeOrigin: true,
  secure: false, // Esto deshabilita la verificación del certificado SSL
  onProxyRes: function (proxyRes, req, res) {
    // Asegurarse de que las cabeceras CORS están presentes en las respuestas del proxy
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
  }
}));

app.listen(3000, () => {
  console.log('Proxy server listening on port 3000');
});
