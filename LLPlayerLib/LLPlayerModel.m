//
//  LLPlayerModel.m
//  LLPlayer
//
//  Created by wangze on 2018/5/24.
//  Copyright © 2018年 wangze. All rights reserved.
//

#import "LLPlayerModel.h"

@implementation LLPlayerModel
- (void)setVideoURL:(NSURL *)videoURL
{
    NSParameterAssert(videoURL);
    _videoURL = videoURL;
}
@end
