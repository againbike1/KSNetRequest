# KSNetRequest

##使用方法
  KSNetRequest使用起来非常简单，<br>
  * 因为是对AFNetworking的封装，所以首先导入AFNetworking<br>
  * 因为封装了缓存技术，所以需要手动导入libsqlite3.tdb
  * 导入头文件"KSNetRequest.h"<br>
  
```Objective-C
[KSNetRequest requestTarget:self 
                        POST:@"urlString" 
                        parameters:@{} 
                        success:^(NSURLSessionDataTask * _Nullable   task, id  _Nullable responseObject) {} 
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {}]
```

* target参数目的是用来显示活动指示器

##实现效果
![断网下的加载](https://raw.githubusercontent.com/18301125620/KSNetRequest/master/KSNetRequest/ImageSource/Untitled.gif)

### 带有缓存，可自定义<br>
自定义方法:KSNetRequest.m 里面 宏定义ISCACHE 设置位NO，可以取消缓存,YES添加缓存（默认是YES）
```Objective-C
//====================是不是需要缓存==YES需要==NO不需要====================//
#define ISCACHE YES
```
KSNetRequest.m在警告处来设置缓存的条件，
### 无网络提示，可自定义<br>
自定义 KSNoNetView即可,但是刷新网络按钮必须连接到KSNoNetView.m的- (IBAction)reloadNetworkDataSource:(id)sender里面,具体方法看Demo
### 活动指示器，可自定义<br>
在KSNoNetView.m的+ (void)requestProgress:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(requestSuccess)success failure:(requestFailure)failure方法里面，添加指示器即可

* 提示，代码已经集成了网络状态检测功能，不需要用户在其他地方添加Reachability相关等代码

最后感谢AFNetworking提供技术支持.
