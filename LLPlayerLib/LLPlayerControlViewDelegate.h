//
//  LLPlayerControlViewDelegate.h
//  LLPlayer
//
//  Created by wangze on 2018/5/24.
//  Copyright © 2018年 wangze. All rights reserved.
//

#ifndef LLPlayerControlViewDelegate_h
#define LLPlayerControlViewDelegate_h


#endif /* LLPlayerControlViewDelegate_h */

@protocol LLPlayerControlViewDelegate <NSObject>

@optional
- (void)ll_controllerView:(UIView *)controlView fullScreenAction:(UIButton *)sender;
@end
