//
//  PSSNoneDataView.m
//  PSSTableViewNoneData
//
//  Created by 山和霞 on 17/4/26.
//  Copyright © 2017年 庞仕山. All rights reserved.
//

#import "PSSNoneDataView.h"

@interface PSSNoneDataView ()

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation PSSNoneDataView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 此处添加姿势图
    }
    return self;
}

// 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.messageLabel sizeToFit];
    self.messageLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel new];
        _messageLabel.text = @"暂无数据";
        _messageLabel.textColor = [UIColor lightGrayColor];
        _messageLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_messageLabel];
    }
    return _messageLabel;
}

@end





