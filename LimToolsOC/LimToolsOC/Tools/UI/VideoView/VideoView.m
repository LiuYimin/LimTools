//
//  VideoContainer.m
//  LimToolsOC
//
//  Created by Liu on 17/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "VideoView.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoPlayerView.h"
#import "VideoCtrlView.h"

/**UIScreen width*/
#define  CLscreenWidth   [UIScreen mainScreen].bounds.size.width
/**UIScreen height*/
#define  CLscreenHeight  [UIScreen mainScreen].bounds.size.height

@interface VideoView ()
{
    NSTimer *_sliderTimer;
    CGRect   _customFarme;
    BOOL     _isFullScreen;
}

@property (nonatomic, weak)   UIView          *fatherView;

@property (nonatomic, strong) VideoPlayerView *playerV;
@property (nonatomic, strong) VideoCtrlView   *ctrlV;
@end

@implementation VideoView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _initUI];
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _playerV.frame = self.bounds;
    _ctrlV.frame = self.bounds;
}

- (void)_initUI
{
    _playerV = [[VideoPlayerView alloc] initWithFrame:self.bounds];
    [self addSubview:_playerV];
    
    _ctrlV = [[VideoCtrlView alloc] initWithFrame:self.bounds];
    [self addSubview:_ctrlV];
    
    __weak VideoView *safeSelf = self;
    
    {//播放View 方法回调
        _playerV.bufferCallback = ^(float progressValue) {
            [safeSelf.ctrlV changeBufferValue:progressValue];
        };
        _playerV.bufferingLoading = ^(BOOL buffer) {
            [safeSelf.ctrlV showLoadingAnimate:buffer];
        };
    }
    
    {//控制View 方法回调
        _ctrlV.playOrPauseCallback = ^(BOOL play) {
            if (play) {
                [safeSelf startSliderTimer];
                [safeSelf.playerV playVideo];
            }else {
                [safeSelf pauseSliderTimer];
                [safeSelf.playerV pauseVideo];
            }
        };
        _ctrlV.fullScreenCallback = ^{
            [safeSelf fullScreenAction];
        };
        _ctrlV.sliderBegin = ^{
            [safeSelf.playerV pauseVideo];
            [safeSelf pauseSliderTimer];
        };
        _ctrlV.sliderChanged = ^uint(float sliderValue) {
            uint sec = [safeSelf.playerV moveToTimeWithPercent:sliderValue];
            return sec;
        };
        _ctrlV.sliderEnd = ^{
            [safeSelf.playerV playVideo];
            [safeSelf startSliderTimer];
        };
    }
}

- (void)setPlayUrl:(NSURL *)playUrl {
    _playUrl = playUrl;
    _playerV.playUrl = _playUrl;
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    _ctrlV.titleText = _titleText;
}

- (void)setCoverUrl:(NSString *)coverUrl {
    _coverUrl = coverUrl;
    _ctrlV.coverUrl = _coverUrl;
}

- (void)startSliderTimer
{
    if (_sliderTimer) {
        [_sliderTimer setFireDate:[NSDate date]];
        return;
    }
    _sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [_ctrlV changePlayPercent:_playerV.sliderValue sececond:_playerV.sliderSec];
        [_ctrlV configTotalPlayTime:_playerV.sliderTotal];
    }];
}

- (void)pauseSliderTimer
{
    [_sliderTimer setFireDate:[NSDate distantFuture]];
}

- (void)fullScreenAction
{
    if (!_isFullScreen) {
        [self fullScreenWithDirection:UIInterfaceOrientationLandscapeLeft];
    }else {
        [self originalscreen];
    }
    _ctrlV.isFullScreen = _isFullScreen;
}





#pragma mark -- Somethong Other
#pragma mark - 全屏
- (void)fullScreenWithDirection:(UIInterfaceOrientation)direction{
    //记录播放器父类
    _fatherView   = self.superview;
    //记录原始大小
    _customFarme  = self.frame;
    _isFullScreen = YES;
    
    //添加到Window上
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    if (_isLandscape){
//        //手动点击需要旋转方向
//        if (_isUserTapMaxButton) {
//            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
//        }
        if (keyWindow.frame.size.width < keyWindow.frame.size.height) {
            self.frame = CGRectMake(0, 0, CLscreenHeight, CLscreenWidth);
        }else{
            self.frame = CGRectMake(0, 0, CLscreenWidth, CLscreenHeight);
        }
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        //播放器所在控制器不支持旋转，采用旋转view的方式实现
        if (direction == UIInterfaceOrientationLandscapeLeft){
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeRotation(M_PI / 2);
            }];
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
        }else if (direction == UIInterfaceOrientationLandscapeRight) {
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeRotation( - M_PI / 2);
            }];
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:NO];
        }
#pragma clang diagnostic pop
        self.frame = CGRectMake(0, 0, CLscreenHeight, CLscreenWidth);
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
#pragma mark - 原始大小
- (void)originalscreen{
    _isFullScreen = NO;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
#pragma clang diagnostic pop
    if (_isLandscape) {
        //还原为竖屏
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    }else{
        //还原
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformMakeRotation(0);
        }];
    }
    self.frame = _customFarme;
    //还原到原有父类上
    [_fatherView addSubview:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
