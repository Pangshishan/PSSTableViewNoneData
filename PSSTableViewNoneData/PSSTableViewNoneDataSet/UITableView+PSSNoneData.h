//
//  UITableView+PSSNoneData.h
//  PSSTableViewNoneData
//
//  Created by 山和霞 on 17/4/26.
//  Copyright © 2017年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PSSNoneDataView;
typedef enum : NSUInteger {
    PSSNoneDataStyleNone, // 关闭此机制
    PSSNoneDataStyleDefault, // 使用PSS默认的视图 (默认视图)
    PSSNoneDataStyleDIY, // 自定义DIY视图, 如果DIY视图为nil 使用PSS默认视图
} PSSNoneDataStyle;

// 这是默认的style, 默认是使用 PSS默认视图 的
extern PSSNoneDataStyle PSS_DefaultStyle;

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


