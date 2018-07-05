//
//  LLPlayerView.h
//  LLPlayer
//
//  Created by wangze on 2018/5/24.
//  Copyright © 2018年 wangze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPlayerModel.h"
@class LLPlayerControlView;

//播放器状态
typedef enum : NSUInteger {
    LLPlayerStateFailed,
    LLPlayerStatePlaying,
    LLPlayerStatePaues,
    
} LLPlayerState;

@interface LLPlayerView : UIView

/** 播放器状态 */
@property (nonatomic, assign) LLPlayerState playerState;
/** 静音播放/默认不静音 */
@property (nonatomic, assign) BOOL          muted;

/** controlview */
@property (nonatomic, strong) LLPlayerControlView       *currentControlView;


/**
 配置playerModel

 @param playerModel 播放属性
 */
- (void)setUpPlayerModel:(LLPlayerModel *)playerModel;


/**
 自动播放
 */
- (void)autoPlayTheVideo;


/**
 播放
 */
- (void)play;


/**
 暂停
 */
- (void)pause;
@end
