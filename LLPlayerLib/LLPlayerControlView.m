//
//  LLPlayerControlView.m
//  LLPlayer
//
//  Created by wangze on 2018/5/24.
//  Copyright © 2018年 wangze. All rights reserved.
//

#import "LLPlayerControlView.h"
#import <Masonry.h>
@interface LLPlayerControlView ()
/** 全屏按钮 */
@property (nonatomic, strong) UIButton *fullScreenButton;
/** 当前controlView的是否显示的状态 */
@property (nonatomic, assign) BOOL isShow;
@end

@implementation LLPlayerControlView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self resetControlView];
        [self setUpSubviews];
        [self makeSubviewsConstraints];
    }
    return self;
}

- (void)setUpSubviews
{
    [self addSubview:self.fullScreenButton];
}

- (void)makeSubviewsConstraints
{
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self).offset(-6);
        make.right.mas_equalTo(self).offset(-10);
    }];
}

#pragma mark - public method
- (void)showOrHideControlView
{
    if (self.isShow == YES) {
        [self hideControlView];
    } else {
        [self showControlView];
    }
}

- (void)showControlView
{
    self.isShow = YES;
    
    self.fullScreenButton.alpha = 1;
}

- (void)hideControlView
{
    self.isShow = NO;
    
    self.fullScreenButton.alpha = 0;
}

#pragma mark - target method
- (void)fullScreenButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if ([self.delegate respondsToSelector:@selector(ll_controllerView:fullScreenAction:)]) {
        [self.delegate ll_controllerView:self fullScreenAction:sender];
    }
}

#pragma mark - private method
- (void)resetControlView
{
    self.backgroundColor = [UIColor clearColor];
    [self hideControlView];
}


#pragma mark - get method
- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"fullScreen"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"normalScreen"] forState:UIControlStateSelected];
        [_fullScreenButton addTarget:self action:@selector(fullScreenButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}

@end
