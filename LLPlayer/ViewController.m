//
//  ViewController.m
//  LLPlayer
//
//  Created by wangze on 2018/5/24.
//  Copyright © 2018年 wangze. All rights reserved.
//

#import "ViewController.h"
#import "LLPlayer.h"
@interface ViewController ()
/** lll */
@property (nonatomic, strong) LLPlayerView *playerView;
@end

@implementation ViewController

//UIDeviceOrientationDidChangeNotification: 只要设备旋转,则注册的对象会接收到此消息,不管是否禁止旋转
//UIApplicationWillChangeStatusBarOrientationNotification与UIApplicationDidChangeStatusBarOrientationNotification: 若禁止旋转,则不会接收到此消息


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
//    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    NSURL *videoURL = [NSURL URLWithString:@"https://s3.vevue.com/video/DFEF839AEB73E0EF306EC86E78502E6E.mp4"];
    
    LLPlayerModel *model = [[LLPlayerModel alloc] init];
    model.videoURL = videoURL;
    
    LLPlayerView *ll_playerView = [[LLPlayerView alloc] init];
    self.playerView = ll_playerView;
    ll_playerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 9 / 16);
    [self.view addSubview:ll_playerView];
    [ll_playerView setUpPlayerModel:model];
    
}



- (IBAction)mute:(id)sender {
    self.playerView.muted = YES;
}

- (IBAction)playOrPause:(id)sender {
    if (self.playerView.playerState == LLPlayerStatePlaying) {
        [self.playerView pause];
    } else {
        [self.playerView play];
    }
}

- (IBAction)loadPlay:(id)sender {
    [self.playerView autoPlayTheVideo];
}

- (IBAction)landscapeOrShupingqiehuan:(id)sender {
//    [self.playerView removeFromSuperview];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.playerView];
//
//    [UIView animateWithDuration:0.3 animations:^{
//        self.playerView.transform = CGAffineTransformMakeRotation(M_PI_2);
//        self.playerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    }];
//
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
    
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
@end
