# RCGroup
RongCloud Group Demo
### Networking Extensions - 融云 API
因为没有 Server 端，所以在客户端直接向融云服务器发起请求，生产环境会有安全隐患，不能这样做。
- RCAPIClient: 通过 `AFHTTPSessionManager` 配置融云的服务器签名规则
- RCAPIProvider: 提供融云群组 API

### 演示需要注意的：
创建群组并不会直接显示列表中（目前遇到的问题，暂时没想到好的解决方式），因为创建没有发送群消息，所以不会显示在聊天列表中。如果需要显示可以在API调试中群组消息功能。
