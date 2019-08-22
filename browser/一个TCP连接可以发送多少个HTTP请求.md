# Q1 现代浏览器在与服务器建立了一个TCP连接后是和否会在一个HTTP请求完成后断开？什么情况下会断开？

在HTTP/1.0中，一个服务器在发送完一个HTTP像影后，会断开TCP链接。但是这样每次请求都会重新建立和断开TCP连接，代价过大（TCP的三次握手四次挥手）。所以虽然标准中没有设定，某些服务器对Connection：keep-alive的Header进行了支持。意思是说，完成这个HTTP请求之后，不要断开HTTP请求使用TCP连接，以及如果维持连接，那么SSL的开销也可以避免，两张图篇是我短时间内两次反问https://github.com/

![](https://mmbiz.qpic.cn/mmbiz_jpg/8Jeic82Or04kzuVt4sxB6wvha4kH2Rxbu9n33RJTvpH4hw8rqMKuqIF1NhFDgk1VEJLMORr4NJ5nQ2O1MwP3Beg/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1)

初始化连接和SSL开销小时了，说明使用的是同一个TCP连接

持久连接：既然维持TCP连接好处这么多，HTTP/1.1就把Connection头写进标准，并且默认开启持久连接，除非请求中写明Connection：close，那么浏览器和服务器之间是会维持一段时间的TCP连接，不会一个请求结束就会断开

> R1: 默认情况下建立TCP连接不会断开，只有在请求报头中声名Connection：close才会在请求完成后关闭连接。

# Q2 一个TCP连接可以对应几个HTTP请求？

> R2：如果维持连接，一个TCP连接是可以发送多个HTTP请求的。

# Q3 一个TCP连接中HTTP请求可以一起发送吗（比如一起发三个请求，在三个响应一起接收）？

HTTP/1.1存在一个问题，单个TCP连接在同一时刻只能处理一个请求，意思是说，两个请求的生命周期不能重叠，任意两个HTTP请求从开始到结束的时间在同一个TCP连接里不能重叠。

虽然HTTP/1.1规范中规定了Pipelining来试图解决这个问题，但是这个功能在浏览器中默认是关闭的。

先来看一下Pipelining是什么，RFC2616中规定了：

> 一个支持持久连接的客户端可以在一个连接中发送多个请求（不需要等待任意请求的响应）。收到请求的服务器必须按照请求收到的顺序发送响应【翻译】

至于标准为什么这么设定，我们可以大概推测一个原因，由于HTTP/1.1是个文本协议，同时返回的内容并不能区分对应于哪个发送的请求，所以顺序必须一致。服务器返回两个结果浏览器是没有办法根据响应结果来判断响应对应于哪一个请求的。

Pipelining这种设想看起来比较美好，但是在实践中会出现许多问题：

- 一些代理服务器不能正确的处理HTTP Pipelinling。
- 正确的流水线实现是复杂的。
- Head-of-line Blocking 连接头阻塞：在建立期一个TCP连接之后，假设客户端在这个连接连续向服务器发送几个请求。按照标准，服务器应该按照收到请求的顺序返回结果，假设服务器在处理首个请求花费了大量时间，那么后面所欲的请求都需要等着这个请求结束后才能响应。

所以现代浏览器默认是不开启HTTP Pipelining的。

但是，HTTP2提供了 Multiplexing 多路传输特性，可以在一个TCP连接中同时完成多个HTTP请求。至于Multiplexing具体怎么实现的就是另一个问题了。我们可以看一下使用HTTP2的效果。

![](https://mmbiz.qpic.cn/mmbiz_jpg/8Jeic82Or04kzuVt4sxB6wvha4kH2RxbuerYia3tGhhUFeicSxWLnRWwgQ5JoDdBFCiapjUCe9Uk2rUibzTSf0VSeKQ/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1)

绿色是发起请求到请求返回的等待时间，蓝色是响应的下载时间，可以看到都是在同一个Connection，并行完成的。

> R3: 在HTTP/1.1存在Pipelinling技术可以完成这个多个请求同时发送，但是由于浏览器默认是关闭的，所以可以认为是不可行的。在HTTP2中由于Multiplexing特点的寻在，多个HTTP请求是可以在同一个TCP连接中并行进行

那么在HTTP/1.1时代，浏览器是如何提高页面加载效率的呢？主要有下面两点：

- 维持和服务器



