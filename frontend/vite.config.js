import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    host: '0.0.0.0',
    proxy: {
      '/api': {
        target: process.env.NODE_ENV === 'production' 
          ? 'https://finport-unbk.onrender.com' 
          : 'http://localhost:5000',
        changeOrigin: true,
        secure: true
      }
    }
  },
  preview: {
    port: process.env.PORT || 3000,
    host: '0.0.0.0'
  },
  build: {
    outDir: 'build',
    assetsDir: 'assets',
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom'],
          charts: ['chart.js', 'react-chartjs-2'],
          icons: ['react-icons']
        }
      }
    }
  },
  define: {
    'process.env.VITE_API_URL': JSON.stringify(
      process.env.NODE_ENV === 'production' 
        ? 'https://finport-unbk.onrender.com'
        : 'http://localhost:5000'
    )
  }
});
