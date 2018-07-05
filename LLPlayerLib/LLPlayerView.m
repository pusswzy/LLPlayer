//
//  LLPlayerView.m
//  LLPlayer
//
//  Created by wangze on 2018/5/24.
//  Copyright © 2018年 wangze. All rights reserved.
//

#import "LLPlayerView.h"
#import "LLPlayerControlView.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
@interface LLPlayerView ()<LLPlayerControlViewDelegate>
/** 播放器属性 */
@property (nonatomic, strong) AVURLAsset                *playerAsset;
@property (nonatomic, strong) AVPlayerItem              *playerItem;
@property (nonatomic, strong) AVPlayer                  *player;
@property (nonatomic, strong) AVPlayerLayer             *playerLayer;
/** 视频播放URL */
@property (nonatomic, strong) NSURL                     *videoURL;
/** 加载动画 */
@property (nonatomic, strong) UIActivityIndicatorView   *indicatorView;

@end

@implementation LLPlayerView

#pragma mark - initialization
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializePlayer];
    };
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initializePlayer];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.playerItem removeObserver:self forKeyPath:@"status"];
}

- (void)initializePlayer
{
    self.backgroundColor = [UIColor blackColor];
    LLPlayerControlView *llControlView = [[LLPlayerControlView alloc] init];
    llControlView.delegate = self;
    [self addSubview:llControlView];
    self.currentControlView = llControlView;
    [llControlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)createGesture
{
    UITapGestureRecognizer *singerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapPlayerView:)];
    singerTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singerTap];
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
}

#pragma mark - Public method
- (void)setUpPlayerModel:(LLPlayerModel *)playerModel
{
    _videoURL = playerModel.videoURL;
    
    [self createGesture];
}

- (void)autoPlayTheVideo
{
    if (self.player) {
        NSLog(@"我不知道这么进行return是否正确");
        return;
    }
    [self addLoadingAnim];
    [self configPlayer];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self.player.currentItem) {
        if ([keyPath isEqualToString:@"status"]) { //play之后才会修改status
            if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
                self.playerState = LLPlayerStatePlaying;
                [self setNeedsLayout]; //这里才添加playerlayer
                [self layoutIfNeeded];
                [self.layer insertSublayer:_playerLayer atIndex:0];
                
                self.player.muted = _muted;
            } else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
                self.playerState = LLPlayerStateFailed;
            }
            
            [self removeLoadingAnim];
        }
        
    }
}

#pragma mark - LLPlayerControlViewDelegate
- (void)ll_controllerView:(UIView *)controlView fullScreenAction:(UIButton *)sender
{
    NSLog(@"%s", __func__);
}

#pragma mark - Player Method
- (void)configPlayer
{
    self.playerAsset = [AVURLAsset assetWithURL:self.videoURL];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.playerAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];

    
    [self play];
}

- (void)play
{
    if (self.playerState == LLPlayerStatePaues) {
        self.playerState = LLPlayerStatePlaying;
    }
    [_player play];
}

#pragma mark - Gesture method
- (void)singleTapPlayerView:(UITapGestureRecognizer *)tapGesture
{
    [self.currentControlView showOrHideControlView];
}

- (void)pause
{
    if (self.playerState == LLPlayerStatePlaying) {
        self.playerState = LLPlayerStatePaues;
    }
    [_player pause];
}

#pragma mark - view method
- (void)addLoadingAnim
{
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self addSubview:self.indicatorView];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
    }];
    [self.indicatorView startAnimating];
    
}

- (void)removeLoadingAnim
{
    if (self.indicatorView) {
        [self.indicatorView removeFromSuperview];
    }
}

#pragma set method
- (void)setMuted:(BOOL)muted
{
    _muted = muted;
    self.player.muted = muted;
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem
{
    //更新通知和KVO
    if (_playerItem == playerItem) {
        return;
    }
    
    if (_playerItem) {
        [_playerItem removeObserver:self forKeyPath:@"status"];
    }
    _playerItem = playerItem;
    
    if (playerItem) {
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
}

@end
