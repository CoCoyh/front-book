# 场景

在我个人博客中文章列表，采用滚动加载的方式显示文章

```
  componentDidMount() {
    if (this.props.location.pathname === '/hot') {
      this.setState(
        {
          likes: true,
        },
        () => {
          this.handleSearch();
        },
      );
    } else {
      this.handleSearch();
    }
    window.onscroll = () => {
      if (getScrollTop() + getWindowHeight() > getDocumentHeight() - 100) {
        // 如果不是已经没有数据了，都可以继续滚动加载
        if (this.state.isLoadEnd === false && this.state.isLoading === false) {
          this.handleSearch();
        }
      }
    };

    document.addEventListener('scroll', lazyload);
  }
```

为当前页面的页面滚动事件添加处理函数。

```
window.onscroll = funcRef
```
获取页面顶部被卷起来的高度

```
export function getScrollTop() {
  return Math.max(
    //chrome
    document.body.scrollTop,
    //firefox/IE
    document.documentElement.scrollTop,
  );
}
```

获取浏览器视口的高度

```
export function getWindowHeight() {
  return document.compatMode === 'CSS1Compat'
    ? document.documentElement.clientHeight
    : document.body.clientHeight;
}
```

获取页面文档的总高度
```
export function getDocumentHeight() {
  //现代浏览器（IE9+和其他浏览器）和IE8的document.body.scrollHeight和document.documentElement.scrollHeight都可以
  return Math.max(
    document.body.scrollHeight,
    document.documentElement.scrollHeight,
  );
}
```


