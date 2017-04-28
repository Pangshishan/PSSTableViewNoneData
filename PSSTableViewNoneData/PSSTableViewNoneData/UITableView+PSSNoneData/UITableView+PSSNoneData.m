//
//  UITableView+PSSNoneData.m
//  PSSTableViewNoneData
//
//  Created by 山和霞 on 17/4/26.
//  Copyright © 2017年 庞仕山. All rights reserved.
//

#import "UITableView+PSSNoneData.h"
#import "PSSNoneDataView.h"
#import <objc/runtime.h>

const NSString *Pss_Key_NoneDataStyle = @"Pss_Key_NoneDataStyle";
const NSString *Pss_Key_ShowNoneDataView = @"Pss_Key_ShowNoneDataView";
const NSString *Pss_Key_DefaultView = @"Pss_Key_DefaultView";
const NSString *Pss_Key_DiyView = @"Pss_Key_DiyView";
const NSString *Pss_Key_ManualShow = @"Pss_Key_ManualShow";
const NSString *Pss_Key_AutoShowing = @"Pss_Key_AutoShowing";



@interface UITableView ()

@property (nonatomic, assign) BOOL isAutoShowing; // 记录自动判断是否显示

@end

@implementation UITableView (PSSNoneData)

+ (void)load
{
    Method layoutSubviews = class_getInstanceMethod(self, @selector(layoutSubviews));
    Method pss_layoutSubviews = class_getInstanceMethod(self, @selector(pss_layoutSubviews));
    method_exchangeImplementations(layoutSubviews, pss_layoutSubviews);
    
    Method initWithFrame_style = class_getInstanceMethod(self, @selector(initWithFrame:style:));
    Method pss_initWithFrame_style = class_getInstanceMethod(self, @selector(pss_initWithFrame:style:));
    method_exchangeImplementations(initWithFrame_style, pss_initWithFrame_style);
}
- (instancetype)pss_initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    UITableView *tableView = [self pss_initWithFrame:frame style:style];
    tableView.pss_noneDataStyle = PSS_DefaultStyle;
    return tableView;
}
- (void)pss_setContentSize:(CGSize)contentSize
{
    [super pss_setContentSize:contentSize];
    BOOL isHavingData = NO; // tableView中是否有数据
    NSInteger numberOfSections = [self numberOfSections];
    for (NSInteger i = 0; i < numberOfSections; i++) {
        if ([self numberOfRowsInSection:i] > 0) {
            isHavingData = YES;
        }
    }
    self.isAutoShowing = !isHavingData;
    [self judgeNowStateWithShow:!isHavingData];
}

- (void)pss_layoutSubviews
{
    [self pss_layoutSubviews];
    [self bringSubviewToFront:self.pss_defaultView];
    self.pss_defaultView.frame = self.bounds;
    if (self.pss_diyView) {
        [self bringSubviewToFront:self.pss_diyView];
    }
}
- (void)judgeNowStateWithShow:(BOOL)show
{
    switch (self.pss_noneDataStyle) {
        case PSSNoneDataStyleNone:
            self.pss_defaultView.hidden = YES;
            if (self.pss_diyView) {
                self.pss_diyView.hidden = YES;
            }
            break;
        case PSSNoneDataStyleDefault:
            if (self.pss_diyView) {
                self.pss_diyView.hidden = YES;
            }
            self.pss_defaultView.hidden = self.pss_isManualShow ? !self.pss_showNoneDataView : !show;
            break;
        case PSSNoneDataStyleDIY:
            if (self.pss_diyView) {
                self.pss_defaultView.hidden = NO;
                self.pss_diyView.hidden = self.pss_isManualShow ? !self.pss_showNoneDataView : !show;;
            } else {
                self.pss_defaultView.hidden = self.pss_isManualShow ? !self.pss_showNoneDataView : !show;
            }
            break;
        default:
            break;
    }
}
#pragma mark - setter + gatter
- (void)setPss_diyView:(UIView *)pss_diyView
{
    if (self.pss_diyView) {
        [self.pss_diyView removeFromSuperview];
    }
    [self addSubview:pss_diyView];
    objc_setAssociatedObject(self, (__bridge const void *)(Pss_Key_DiyView), pss_diyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)pss_diyView
{
    return objc_getAssociatedObject(self, (__bridge const void *)(Pss_Key_DiyView));
}

- (void)setPss_defaultView:(PSSNoneDataView *)pss_defaultView
{
    objc_setAssociatedObject(self, (__bridge const void *)(Pss_Key_DefaultView), pss_defaultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (PSSNoneDataView *)pss_defaultView
{
    PSSNoneDataView *defaultView = objc_getAssociatedObject(self, (__bridge const void *)(Pss_Key_DefaultView));
    if (!defaultView) {
        defaultView = [[PSSNoneDataView alloc] init];
        defaultView.hidden = YES;
        [self addSubview:defaultView];
        objc_setAssociatedObject(self, (__bridge const void *)(Pss_Key_DefaultView), defaultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return defaultView;
}

- (void)setPss_showNoneDataView:(BOOL)pss_showNoneDataView
{
    objc_setAssociatedObject(self, (__bridge const void *)(Pss_Key_ShowNoneDataView), @(pss_showNoneDataView), OBJC_ASSOCIATION_ASSIGN);
    if (self.pss_isManualShow) {
        [self judgeNowStateWithShow:pss_showNoneDataView];
    }
}
- (BOOL)pss_showNoneDataView
{
    return [objc_getAssociatedObject(self, (__bridge const void *)(Pss_Key_ShowNoneDataView)) intValue];
}

- (void)setPss_noneDataStyle:(PSSNoneDataStyle)pss_noneDataStyle
{
    objc_setAssociatedObject(self, (__bridge const void *)(Pss_Key_NoneDataStyle), @(pss_noneDataStyle), OBJC_ASSOCIATION_ASSIGN);
}
- (PSSNoneDataStyle)pss_noneDataStyle
{
    return [objc_getAssociatedObject(self, (__bridge const void *)(Pss_Key_NoneDataStyle)) intValue];
}

- (void)setPss_isManualShow:(BOOL)pss_isManualShow
{
    objc_setAssociatedObject(self, (__bridge const void *)(Pss_Key_ManualShow), @(pss_isManualShow), OBJC_ASSOCIATION_ASSIGN);
    [self judgeNowStateWithShow:pss_isManualShow ? self.pss_showNoneDataView :self.isAutoShowing];
}
- (BOOL)pss_isManualShow
{
    return [objc_getAssociatedObject(self, (__bridge const void *)(Pss_Key_ManualShow)) boolValue];
}

- (void)setIsAutoShowing:(BOOL)isAutoShowing
{
    objc_setAssociatedObject(self, (__bridge const void *)(Pss_Key_AutoShowing), @(isAutoShowing), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isAutoShowing
{
    return [objc_getAssociatedObject(self, (__bridge const void *)(Pss_Key_AutoShowing)) boolValue];
}

@end

@implementation UIScrollView (PSS)

+ (void)load
{
    Method setContentSize = class_getInstanceMethod(self, @selector(setContentSize:));
    Method pss_setContentSize = class_getInstanceMethod(self, @selector(pss_setContentSize:));
    method_exchangeImplementations(setContentSize, pss_setContentSize);
}

- (void)pss_setContentSize:(CGSize)contentSize
{
    [self pss_setContentSize:contentSize];
}

@end



