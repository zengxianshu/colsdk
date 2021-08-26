
[TOC]

## 适用范围

- 中文在线-作品内容相关信息的输出
- SDK为Swift开发，需要swift项目或者oc-swift混编项目，纯oc项目需要改成支持swift（混编）

### 接入流程

- 申请颁发appId 和 私钥(secret) 
- 申请时候需要提供包名（ Bundle ldentifier）
- appId 和 私钥(secret)  需要 配套的 Bundle ldentifier 才能使用

#### 增量

- iOS9+ 增量5.1M 双架构（armv7 + arm64）
- iOS11+ 增量 3.5M 单架构（arm64）

## 使用方法

### 集成

#### Installation with CocoaPods（推荐）

To integrate `Reader17kSDK` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
# 阅读SDK
pod 'Reader17kSDK',    :git => 'https://gitee.com/zm_ios_example/col_sdk_example.git'
```

#### xcframework集成

```
将 Reader17kSDK.xcframework 文件直接拖入目标工程

// 设置
target - General - Frameworks, Libraries, and Embedded Content 需要设置为 Embed 模式
```

### 使用说明 （详情参考demo 需要 pod install）

#### import

```swift
import Reader17kSDK
```

```objective-c
#import <Reader17kSDK/Reader17kSDK.h>
```

#### 配置

```swift
    /// 配置SDK 必要步骤
    /// - Parameters:
    ///   - appid:  渠道 申请获得
    ///   - secret: 渠道 申请获得
    ///   - options: 其它信息
    ///     {
    ///         "enableService" = "（0 或 1）" //是否显示联系客服入口 default  1
    ///         “servcie” = "urlStr" // 客服链接地址 默认使用SDK客服地址
    ///     }
    @objc public func config(appid: String,
                             secret: String,
                             options:NSDictionary? = [:])
```

#### 使用

```swift
    /// SDK 实例
    @objc public static let shared:ReaderColSDK
```

```swift
    /// 获取 单页面 （通常当作分页接入，例如顶部分栏的子页面）
    @objc public func getHomePageVc()->UIViewController
```

```swift
    /// 打开 SDK 主页（tabVC）
    /// - Parameter controller: 当前控制器，用来打开SDK （presentingViewController）
    @objc public func openColSdkFromViewController(_ controller:UIViewController)
```

```swift
    /// version
    @objc public var version: String? 
```

```swift
    /// version
    @objc public var version: String?
```

```swift
    /// buildVersion
    @objc public var buildVersion: String?
```

```swift
    /// infoDictionary （plist.info）
    @objc public var infoDictionary: [String:Any]?
```

```swift
    /// 页面信息
    @objc public static let pageMap
```

## 广告

```swift
/// 广告协议 （可选）
@objc public protocol ReaderAdDelegate

ReaderColSDK.shared.readerAdDelegate = self
```

```swift
    /// 展示视频广告  （可选  未实现该协议则不会展示激励视频广告相关）
    /// - Parameters:
    ///   - viewController: 触发激励视频广告的 viewController
    ///   - parameter:
    ///     {
    ///       "isBackSide"  // 是否为阅读页背面 (仅当仿真翻页时存在)
    ///       "isDark"  // 是否为阅读深色模式
    ///     }
    ///   - completion: 激励视频 结果回调  【completion(true) 激励视频激励完成；completion(false) 则为失败】
    @objc optional func showRewardAd(from viewController: UIViewController,
                                     parameter:NSDictionary,
                                     completion: @escaping ((Bool)->Void))
```

```swift
    /// 每日首次打开阅读器弹窗广告 （可选 未实现该协议则不会展示每日首次打开阅读器弹窗广告相关）
    /// - Parameters:
    ///   - viewController: 触发广告的 viewController
    ///   - parameter:
    ///     {
    ///       "isDark"  // 是否为阅读深色模式
    ///     }
    ///   - renderSuccess: 更新广告size renderSuccess(adPressView.bounds.size)
    @objc optional func newDayFirstOpenReaderAdView(from viewController: UIViewController,
                                                    parameter:NSDictionary,
                                                    renderSuccess:@escaping(_ size:CGSize)->Void) ->  UIView
```

```swift
    /// 章节内容广告 （可选 未实现该协议则不会展示章节内容间的广告相关）
    /// - Parameters:
    ///   - viewController: 触发广告的 viewController
    ///   - parameter:
    ///     {
    ///       "isDark"  // 是否为阅读深色模式
    ///       "isBackSide"  // 是否为阅读页背面 (仅当仿真翻页时存在)
    ///     }
    @objc optional func readerContentAdView(from viewController: UIViewController,
                                            parameter:NSDictionary) ->  UIView
```

```swift
    /// 书籍末页广告 （可选 未实现该协议则不会展示阅读末页广告相关）
    /// - Parameters:
    ///   - viewController: 触发广告的 viewController
    ///   - parameter: 拓展属性 当前为空
    ///   - renderSuccess: 更新广告size renderSuccess(adPressView.bounds.size)
    @objc optional func readerEndAdView(from viewController: UIViewController,
                                        parameter:NSDictionary,
                                        renderSuccess:@escaping(_ size:CGSize)->Void) ->  UIView
```

```swift
    /// 信息流广告 （可选 未实现该协议则不会展示信息流广告相关）
    /// - Parameters:
    ///   - viewController: 触发广告的 viewController
    ///   - parameter: 拓展属性 当前为空
    ///   - renderSuccess: 更新广告size renderSuccess(adPressView.bounds.size)
    @objc optional func cellAdView(from viewController: UIViewController,
                                   parameter:NSDictionary?,
                                   renderSuccess:@escaping(_ size:CGSize)->Void) ->  UIView
```

## 生命周期

```swift
/// 界面控制器（viewController）生命周期 协议 （可选）
@objc public protocol ReaderLifecycleDelegate: NSObjectProtocol

ReaderColSDK.shared.readerLifecycleDelegate = self
```

```swift
    @objc optional func viewWillAppear(viewController: UIViewController,parameter:NSDictionary)
    @objc optional func viewDidAppear(viewController: UIViewController,parameter:NSDictionary)
    @objc optional func viewWillDisappear(viewController: UIViewController,parameter:NSDictionary)
    @objc optional func viewDidDisappear(viewController: UIViewController,parameter:NSDictionary)
```


## 回调

```swift
    /// 阅读定时处理 （可选）
    ///
    ///     Reader17kSDK.shared.config(readCycle: 10) { (parameter) in
    ///         print(parameter)
    ///         //  Prints {
    ///                     bookName = "\U9ed1\U6697\U81f3\U4e0a";//书名
    ///                     chapterName = "001 \U906d\U9047\U6076\U9b54";//章节名
    ///                     chapterIndex = 2;// 当前正在阅读第几章
    ///                     chapterTotalPages = 11;//章节内容分页数量
    ///                     chapterContentCount = 1000;//章节字数
    ///
    ///                     pageInChapter = 8;// 当前正在阅读第几页（从1开始计数）
    ///                     pageContentCount = 100;// 当前正在阅读页字数
    ///
    ///                     time = 710000;// 已阅读时长 毫秒（关闭阅读器会重新计时）
    ///                     }
    ///     }
    ///
    /// - Parameters:
    ///   - readCycle:  周期 单位秒.
    ///   - handler: 闭包事件
    @objc public func configRead(cycle: NSInteger,
                                 handler:@escaping ((_ parameter:NSDictionary)->Void))
```

```swift
    /// 阅读（一本书）退出回调
    ///
    ///     Reader17kSDK.shared.configReadQuit() { (parameter) in
    ///         print(parameter)
    ///         //  Prints {
    ///                     bookName = "\U9ed1\U6697\U81f3\U4e0a";//书名
    ///                     chapterName = "001 \U906d\U9047\U6076\U9b54";//章节名
    ///                     chapterIndex = 2;// 当前正在阅读第几章
    ///                     chapterTotalPages = 11;//章节内容分页数量
    ///                     chapterContentCount = 1000;//章节字数
    ///
    ///                     pageInChapter = 8;// 当前正在阅读第几页（从1开始计数）
    ///                     pageContentCount = 100;// 当前正在阅读页字数
    ///
    ///                     time = 710000;// 已阅读时长 毫秒（关闭阅读器会重新计时）
    ///                     }
    ///     }
    ///
    /// - Parameter handler: 回调闭包事件
    @objc public func configReadQuit(handler:@escaping ((_ parameter:NSDictionary)->Void)) 
```

```swift
    /// 阅读页面变化回调
    ///
    ///     Reader17kSDK.shared.configReadPageChanged() { (parameter) in
    ///         print(parameter)
    ///         //  Prints {
    ///                     bookName = "\U9ed1\U6697\U81f3\U4e0a";//书名
    ///                     chapterName = "001 \U906d\U9047\U6076\U9b54";//章节名
    ///                     chapterIndex = 2;// 当前正在阅读第几章
    ///                     chapterTotalPages = 11;//章节内容分页数量
    ///                     chapterContentCount = 1000;//章节字数
    ///
    ///                     pageInChapter = 8;// 当前正在阅读第几页（从1开始计数）
    ///                     pageContentCount = 100;// 当前正在阅读页字数
    ///
    ///                     isContentChange = 1;是否为内容变化 0 常规页码变更， 1 内容变化。
    ///
    ///                     time = 710000;// 已阅读时长 毫秒（关闭阅读器会重新计时）
    ///                     }
    ///     }
    ///
    /// - Parameters:
    ///   - handler: 闭包事件
    @objc public func configReadPageChanged(handler:@escaping ((_ parameter:NSDictionary)->Void))
```

## 问题

* dyld: Library not loaded: @rpath/XXXX Reason:XXX问题
  - 把库加入到工程中，Embed模式
* 网络链接失败,有部分链接使用的是http请求需要在info中配置
  - 在Info.plist中添加NSAppTransportSecurity类型Dictionary。
  - 在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES
* 无权操作 & 无此权限
  - 无此权限 请检查 appId , 私钥(secret) ,包名() Bundle ldentifier) 三者是否配套
  - 无权操作 请检查手机时间是否正常

## License

[`Reader17kSDK`](https://gitee.com/zm_ios_example/col_sdk_example) is released under the MIT license. See [LICENSE](https://gitee.com/zm_ios_example/col_sdk_example/LICENSE) for details.



