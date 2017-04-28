# PSSTableViewNoneData
tableView没有数据时，需要展示占位图，如果项目还不成熟，没有这方面的机制，需要添加时，我们每一个使用了tableView的VC都添加代码，手动判断是否需要显示占位图，非常的麻烦，于是我就给UITableView 写了个categary, 只需要拖入文件到工程(连头文件都不需要导入)，就可以完成项目中所有tableView的占位图的批量设置，非常舒服。[PSSTableViewNoneData （demo链接点击此处）](https://github.com/Pangshishan/PSSTableViewNoneData.git)

#### 用到的技术
- Runtime 方法交换（hook）
- Runtime 给categary动态添加属性关联
- categary的应用

### demo图片演示

![1.有数据时](http://upload-images.jianshu.io/upload_images/5379614-f3babd64ce9e5006.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![2.点击了清空数据时](http://upload-images.jianshu.io/upload_images/5379614-e327292891620915.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 使用方法：直接拖入工程

### 提供接口
- 如果只是用到demo中默认的视图 或者 直接修改自定义的视图，则不需要导入头文件，拖进去就能用，需要修改实现的类名为：**PSSNoneDataView**
- 如果需要手动设置自定义视图，或者需要手动设置视图的显现，则需要导入头文件：**UITableView+PSSNoneData**
- 以下是提供的接口：

```Objective-C
#import <UIKit/UIKit.h>
@class PSSNoneDataView;
typedef enum : NSUInteger {
    PSSNoneDataStyleNone, // 关闭此机制
    PSSNoneDataStyleDefault, // 使用PSS默认的视图 (默认视图)
    PSSNoneDataStyleDIY, // 自定义DIY视图, 如果DIY视图为nil 使用PSS默认视图
} PSSNoneDataStyle;

// 这是默认的style, 默认是使用 PSS默认视图 的
PSSNoneDataStyle PSS_DefaultStyle = PSSNoneDataStyleDefault;

@interface UITableView (PSSNoneData)

@property (nonatomic, assign) PSSNoneDataStyle pss_noneDataStyle;

/*
 * 只在 PSSNoneDataStyleDIY 下生效
 * frame 或者 布局, 需要自己给定
 */
@property (nonatomic, strong) UIView *pss_diyView;

/*
 * 描述: 是否显示 无数据视图
 * 只在 非PSSNoneDataStyleNone并且pss_isManualShow==YES  时生效
 */
@property (nonatomic, assign) BOOL pss_showNoneDataView;
/*
 * 描述: 是否手动显示 无数据视图; 默认为NO
 */
@property (nonatomic, assign) BOOL pss_isManualShow;

// 默认视图, readonly
@property (nonatomic, strong, readonly) PSSNoneDataView *pss_defaultView;

@end

@interface UIScrollView (PSS)

- (void)pss_setContentSize:(CGSize)contentSize;

@end
```


如果您感兴趣，想要查看.m文件，欢迎下载[PSSTableViewNoneData （demo链接点击此处）](https://github.com/Pangshishan/PSSTableViewNoneData.git)

*如果觉得对您有帮助，就star一下吧。您的star就是对我最大的鼓励！
如果发现什么问题，或者有什么意见，请加我qq或微信：704158807
电子邮箱：pangshishan@aliyun.com*
