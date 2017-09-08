//
//  VideoCtrlBar.m
//  LimToolsOC
//
//  Created by Liu on 17/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "VideoCtrlBar.h"
#import "YLSlider.h"

@interface VideoCtrlBar ()

@property (weak, nonatomic) IBOutlet UIButton *pausePlayButt;
@property (weak, nonatomic) IBOutlet UILabel *playedTimeLab;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet YLSlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenButt;
@end

@implementation VideoCtrlBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initData];
        [self _initUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _initData];
    [self _initUI];
    self.showBar = NO;
}

- (void)_initData
{
    self.showBar = NO;
}

- (void)_initUI
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    // slider开始滑动事件
    [_slider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
    // slider滑动中事件
    [_slider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    // slider结束滑动事件
    [_slider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    //右边颜色
    _slider.maximumTrackTintColor = [UIColor clearColor];
}

#pragma mark -- Setter
- (void)setShowBar:(BOOL)showBar {
    _showBar = showBar;
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.1];
    self.alpha = _showBar?1:0;
    [UIView commitAnimations];
}

- (void)setBufferProgress:(float)bufferProgress {
    _bufferProgress = bufferProgress;
    _progress.progress = _bufferProgress;
}

- (void)setPlayProgress:(float)playProgress {
    _slider.value = playProgress;
}

- (void)setPlaySec:(uint)sec {
    _playedTimeLab.text = [self transTimeWith:sec];
}

- (void)setTotalTime:(uint)totalTime {
    _totalTimeLab.text = [self transTimeWith:totalTime];
}

- (void)setPlay:(BOOL)play {
    _play = play;
    [_pausePlayButt setImage:[UIImage imageNamed:_play?@"icon_course_pause":@"icon_course_play2"] forState:UIControlStateNormal];
}

#pragma mark -- 时间显示格式转换
- (NSString *)transTimeWith:(uint)sec
{
    int h = sec/3600;
    int m = (sec - h * 3600)/60;
    int s = sec - h * 3600 - m * 60;
    NSString *hstr = h!=0?[NSString stringWithFormat:@"%d:", h]:@"";
    NSString *mstr = [NSString stringWithFormat:@"%02d:", m];
    NSString *sstr = [NSString stringWithFormat:@"%02d", s];
    NSString *finishTimeStr = [NSString stringWithFormat:@"%@%@%@", hstr, mstr, sstr];
    return finishTimeStr;
}

#pragma mark -- Action
- (IBAction)onPlayPause:(id)sender {
    self.play = !_play;
    if (self.playOrPauseCallback) self.playOrPauseCallback(_play);
}
- (IBAction)onFull:(id)sender {
    if (self.fullScreenCallback) self.fullScreenCallback();
}

#pragma mark - 滑杆
//开始滑动
- (void)progressSliderTouchBegan:(YLSlider *)slider{
    if (self.sliderBegin) self.sliderBegin();
}
//滑动中
- (void)progressSliderValueChanged:(YLSlider *)slider{
    if (self.sliderChanged) {
        uint sec = self.sliderChanged(slider.value);
        self.playSec = sec;
    }
}
//滑动结束
- (void)progressSliderTouchEnded:(YLSlider *)slider{
    if (self.sliderEnd) self.sliderEnd();
}

#pragma mark -- 设置颜色
-(void)setProgressBackgroundColor:(UIColor *)progressBackgroundColor{
    _progressBackgroundColor = progressBackgroundColor;
    _progress.trackTintColor = progressBackgroundColor;
}
-(void)setProgressBufferColor:(UIColor *)progressBufferColor{
    _progressBufferColor        = progressBufferColor;
    _progress.progressTintColor = progressBufferColor;
}
-(void)setProgressPlayFinishColor:(UIColor *)progressPlayFinishColor{
    _progressPlayFinishColor      = progressPlayFinishColor;
    _slider.minimumTrackTintColor = _progressPlayFinishColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
