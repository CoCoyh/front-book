#  使用http-proxy-middleware代理跨域

例如请求的url:“http://f.apiplus.cn/bj11x5.json”

1、打开config/index.js,在proxyTable中添写如下代码：

```
proxyTable: { 
  '/api': {  //使用"/api"来代替"http://f.apiplus.c" 
    target: 'http://f.apiplus.cn', //源地址 
    changeOrigin: true, //改变源 
    pathRewrite: { 
      '^/api': 'http://f.apiplus.cn' //路径重写 
      } 
  } 
}
```

2、使用axios请求数据时直接使用“/api”：

```
getData () { 
 axios.get('/api/bj11x5.json', function (res) { 
   console.log(res) 
 })
```

通过这中方法去解决跨域，打包部署时还按这种方法会出问题。解决方法如下：

```
let serverUrl = '/api/'  //本地调试时 
// let serverUrl = 'http://f.apiplus.cn/'  //打包部署上线时 
export default { 
  dataUrl: serverUrl + 'bj11x5.json' 
}
```