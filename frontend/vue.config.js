module.exports = {
    devServer: {
        // port: 8000,
        proxy: 'http://127.0.0.1:5959',
        //   before: require('./mock/mock-server.js')
      }
  }