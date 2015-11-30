# KSNetRequest

##使用方法
  KSNetRequest使用起来非常简单，<br>
  因为是对AFNetworking的封装，所以首先导入AFNetworking<br>
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
### 带有缓存，可自定义
### 无网络提示，可自定义
### 活动指示器，可自定义
![断网下的加载](http://code.cocoachina.com/uploads/attachments/20151127/128447/05d360bd738d669f061d9684bb7483f8.gif)

* 断网下的视图可自定义KSNoNetView 即可实现自己需要的效果.

最后感谢AFNetworking提供技术支持.
