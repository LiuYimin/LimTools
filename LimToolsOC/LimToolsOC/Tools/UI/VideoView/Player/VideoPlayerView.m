//
//  VideoPlayerView.m
//  PlayerVideoDemo
//
//  Created by LiuYimin on 16/4/5.
//  Copyright © 2016年 LiuYimin. All rights reserved.
//

#import "VideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>

// 播放器的几种状态
typedef NS_ENUM(NSInteger, YLPlayerState) {
    YLPlayerState_Failed,     // 播放失败
    YLPlayerState_Buffering,  // 缓冲中
    YLPlayerState_Playing,    // 播放中
    YLPlayerState_Stopped,    // 停止播放
    YLPlayerState_Pause       // 暂停播放
};

@interface VideoPlayerView ()
//当前是否需要播放  用于在程序退到后台返回前台时, 视频加载完成时去判断是否开始播放视频
@property (nonatomic, assign) BOOL           needPlay;
//视频已经播放结束标志   用于视频循环播放时,重复播放
@property (nonatomic, assign) BOOL           hadEnd;
//播放器当前的状态
@property (nonatomic, assign) YLPlayerState  state;


@property (nonatomic, strong) AVPlayer      *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem  *playerItem;
@end

@implementation VideoPlayerView

#pragma mark -- Public
- (void)playVideo;
{
    _needPlay = YES;
    if (_hadEnd) {
        [self resetPlay];
    }else {
        [_player play];
    }
}

- (void)pauseVideo;
{
    _needPlay = NO;
    [_player pause];
}

- (uint)moveToTimeWithPercent:(float)proportion
{
    CGFloat total = (CGFloat)_playerItem.duration.value/_playerItem.duration.timescale;
    NSInteger dragedSeconds = floorf(total * proportion);
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime     = CMTimeMake(dragedSeconds, 1);
    [_player seekToTime:dragedCMTime];
    
    return (uint)dragedSeconds;
}

#pragma mark -- 重置播放器
- (void)resetPlay
{
    _hadEnd = NO;
    [_player seekToTime:CMTimeMake(0, 1)];
    [self playVideo];
}


#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _playerLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

#pragma mark - Custom Accessors
/**
 *  视频播放结束
 */
- (void)moviePlayDidEnd:(id)sender {

}

/**
 *  开始播放
 *
 *  @param url 用于播放的视频路径
 */
- (void)startPlayWith:(NSURL *)url
{
    [_player replaceCurrentItemWithPlayerItem:nil];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    
    _player = [AVPlayer playerWithPlayerItem:self.playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    _playerLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.layer addSublayer:_playerLayer];
}

#pragma mark - 缓冲
//卡顿时会走这里
- (void)bufferingSomeSecond
{
    self.state = YLPlayerState_Buffering;
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self pauseVideo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playVideo];
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        if (!self.playerItem.isPlaybackLikelyToKeepUp) {
            [self bufferingSomeSecond];
        }
    });
}

//计算缓冲进度
- (NSTimeInterval)availableDuration
{
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start);
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

#pragma mark - 重置播放器
- (void)resetPlayer{
    [_player pause];
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer = nil;
    self.player      = nil;
}

#pragma mark - Setter && Getter Methods
- (void)setState:(YLPlayerState)state {
    _state = state;
    if (_state == YLPlayerState_Buffering) {
        if (self.bufferingLoading) self.bufferingLoading(YES);
    }else {
        if (self.bufferingLoading) self.bufferingLoading(NO);
    }
}

- (float)sliderValue {
    if (_playerItem.duration.timescale <= 0 || _playerItem.duration.value <= 0) {
        return 0;
    }
    
    return CMTimeGetSeconds([_playerItem currentTime]) / (_playerItem.duration.value / _playerItem.duration.timescale);
}

- (uint)sliderSec {
    return CMTimeGetSeconds([_playerItem currentTime]);
}

- (uint)sliderTotal {
    float v = _playerItem.duration.timescale;
    if (v <= 0) {
        return 0;
    }
    return (uint)(_playerItem.duration.value / v);
}

- (void)setPlayUrl:(NSURL *)playUrl {
    _playUrl = playUrl;
    if (!_playUrl) {
        return;
    }
    [self startPlayWith:_playUrl];
}

-(void)setPlayerItem:(AVPlayerItem *)playerItem{
    if (_playerItem == playerItem){
        return;
    }
    if (_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:_playerItem];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
        //重置播放器
        [self resetPlayer];
    }
    _playerItem = playerItem;
    if (playerItem) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayDidEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:playerItem];
        [playerItem addObserver:self forKeyPath:@"status"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
        [playerItem addObserver:self
                     forKeyPath:@"loadedTimeRanges"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
        [playerItem addObserver:self
                     forKeyPath:@"playbackBufferEmpty"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
        [playerItem addObserver:self
                     forKeyPath:@"playbackLikelyToKeepUp"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    }
}

#pragma mark - KVO 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
            self.state = YLPlayerState_Playing;
            self.player.muted = self.mute;
        }else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
            self.state = YLPlayerState_Failed;
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        // 计算缓冲进度
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration             = self.playerItem.duration;
        CGFloat totalDuration       = CMTimeGetSeconds(duration);
        if (self.bufferCallback) self.bufferCallback(timeInterval/totalDuration);
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        // 当缓冲是空的时候
        if (self.playerItem.isPlaybackBufferEmpty) {
            [self bufferingSomeSecond];
        }
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        // 当缓冲好的时候
        if (self.playerItem.isPlaybackLikelyToKeepUp && self.state == YLPlayerState_Buffering){
            self.state = YLPlayerState_Playing;
        }
    }
}

@end
