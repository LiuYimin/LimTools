//
//  VideoCtrlView.m
//  LimToolsOC
//
//  Created by Liu on 17/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "VideoCtrlView.h"
#import "VideoCtrlBar.h"
#import "AILoadingView.h"
#import "VideoTopBar.h"

@interface VideoCtrlView ()

@property (nonatomic, strong) VideoCtrlBar  *ctrlBar;
@property (nonatomic, strong) VideoTopBar   *topBar;

@property (nonatomic, strong) UIImageView   *backCoverImv;
@property (nonatomic, strong) UIView        *coverView;
@property (nonatomic, strong) UIButton      *startPlayButt;

@property (nonatomic, strong) AILoadingView *activity;

@end

@implementation VideoCtrlView

#pragma mark -- Public
- (void)changeBufferValue:(float)percent;
{
    _ctrlBar.bufferProgress = percent;
}

- (void)changePlayPercent:(float)percent sececond:(uint)sec;
{
    _ctrlBar.playProgress = percent;
    _ctrlBar.playSec = sec;
}

- (void)configTotalPlayTime:(uint)total;
{
    _ctrlBar.totalTime = total;
}

- (void)showLoadingAnimate:(BOOL)show;
{
    _activity.hidden = !show;
    if (show) {
        [_activity starAnimation];
    }else {
        [_activity stopAnimation];
    }
}

#pragma mark -- Liftcycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initData];
        [self _initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _ctrlBar.frame = CGRectMake(0, self.bounds.size.height-45, self.bounds.size.width, 45);
    _activity.frame = CGRectMake(0, 0, 30, 30);
    _activity.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _backCoverImv.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _coverView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _startPlayButt.center = CGPointMake(CGRectGetMidX(_coverView.bounds), CGRectGetMidY(_coverView.bounds));
}

#pragma mark -- Private

- (void)_initData
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickScreen)];
    [self addGestureRecognizer:tap];
}

- (void)_initUI
{
    __weak VideoCtrlView *safeSelf = self;

    _topBar = [[VideoTopBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 64)];
    _topBar.title = _titleText;
    _topBar.backCall = ^{
        if (safeSelf.fullScreenCallback) safeSelf.fullScreenCallback();
    };
    [self addSubview:_topBar];
    _topBar.alpha = 0;
    
    _ctrlBar = [[[NSBundle mainBundle] loadNibNamed:@"VideoCtrlBar" owner:nil options:nil] lastObject];
    _ctrlBar.frame = CGRectMake(0, self.bounds.size.height-45, self.bounds.size.width, 45);
    _ctrlBar.progressBackgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.9];;
    _ctrlBar.progressBufferColor = [UIColor lightGrayColor];
    _ctrlBar.progressPlayFinishColor = [UIColor orangeColor];
    [self addSubview:_ctrlBar];
    
    {//控制栏的返回事件
        _ctrlBar.playOrPauseCallback = ^(BOOL play) {
            if (safeSelf.playOrPauseCallback) safeSelf.playOrPauseCallback(play);
        };
        _ctrlBar.fullScreenCallback = ^{
            
            if (safeSelf.fullScreenCallback) safeSelf.fullScreenCallback();
        };
        _ctrlBar.sliderBegin = ^{
            if (safeSelf.sliderBegin) safeSelf.sliderBegin();
        };
        _ctrlBar.sliderChanged = ^uint(float sliderValue) {
            if (safeSelf.sliderChanged) return safeSelf.sliderChanged(sliderValue);
            return 0;
        };
        _ctrlBar.sliderEnd = ^{
            if (safeSelf.sliderEnd) safeSelf.sliderEnd();
        };
    }
    
    _activity = [[AILoadingView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _activity.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _activity.hidden = YES;
    _activity.strokeColor = [UIColor redColor];
    [self addSubview:_activity];
    
    _backCoverImv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _backCoverImv.userInteractionEnabled = YES;
    [self addSubview:_backCoverImv];
    
    _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.4;
    [self addSubview:_coverView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
    [_coverView addGestureRecognizer:tap];
    
    _startPlayButt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startPlayButt setImage:[UIImage imageNamed:@"icon_course_play1"] forState:UIControlStateNormal];
    _startPlayButt.frame = CGRectMake(0, 0, 50, 50);
    _startPlayButt.center = CGPointMake(CGRectGetMidX(_coverView.bounds), CGRectGetMidY(_coverView.bounds));
    [_startPlayButt addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [_coverView addSubview:_startPlayButt];
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    _topBar.title = _titleText;
}

- (void)setCoverUrl:(NSString *)coverUrl {
    _coverUrl = coverUrl;
//    [_backCoverImv sd_setImageWithURL:[NSURL URLWithString:coverUrl]];
}

#pragma mark -- Action
- (void)onClickScreen
{
    _ctrlBar.showBar = !_ctrlBar.showBar;
    if (_isFullScreen) {
        _topBar.showBar = !_topBar.showBar;
    }
}

- (void)startAction
{
    [self showCoverView:NO];
    _ctrlBar.play = YES;
    if (self.playOrPauseCallback) self.playOrPauseCallback(YES);
}

- (void)showCoverView:(BOOL)show
{
    [UIView animateWithDuration:0.5 animations:^{
        _backCoverImv.alpha = show?1:0;
        _coverView.alpha = show?1:0;
    }];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
