module.exports = {
  devServer: {
    // port: 8000,
    proxy: "http://127.0.0.1:8000",
    //   before: require('./mock/mock-server.js')
  },
  assetsDir: 'static',
};
