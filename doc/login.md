# Login API

登录或注册时均通过科大统一身份认证接口(passport.ustc.edu.cn)。
后端通过token认证用户身份，可以通过ticket和service请求`api/login/`接口获取token。可以简化流程为
- 若前端没有token或token过期，前端请求`casUrl`获取ticket和service参数。然后请求后端`api/login/`接口获取token
- 若前端有valid token即可直接请求
- 用户首次登录时后端会自动新建用户

相关资料
- CAS协议可以参考[doc](https://apereo.github.io/cas/4.2.x/protocol/CAS-Protocol.html)中的时序图。
- jwt可以参考[wiki](https://django-rest-framework-simplejwt.readthedocs.io/en/latest/)

前端获取token的伪代码
```javascript
const currentUrl = window.location.href;
if (currentUrl.includes('ticket')) {
    // 已经通过统一身份认证登录，获得了ticket
    // 直接请求后端login api
    const ticket = currentUrl.match(/ticket=([\s\S]+?)&/)[1];
    const service = currentUrl.match(/service=([\s\S]+?)&/)[1];
    // import login from @api
    login(ticket, service)
} else if (invalid token) {
    // 没有token或token过期 需要重新通过统一身份认证接口获取用户身份
    const casUrl = 'https://passport.ustc.edu.cn/login?service=http://home.ustc.edu.cn/~kelleykuang/cas/index.html?id=null';
    // 获取ticket后进入上一个分支
    window.location.href = casUrl;
}
```