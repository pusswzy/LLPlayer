//
//  LLPlayerControlView.h
//  LLPlayer
//
//  Created by wangze on 2018/5/24.
//  Copyright © 2018年 wangze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPlayerControlViewDelegate.h"

@interface LLPlayerControlView : UIView
/** controlViewDelegate */
@property (nonatomic, weak) id<LLPlayerControlViewDelegate> delegate;

/* method */
- (void)showOrHideControlView;
- (void)showControlView;
- (void)hideControlView;
@end
