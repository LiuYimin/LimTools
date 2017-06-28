//
//  YLSexTip.m
//  LimToolsOC
//
//  Created by Liu on 21/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "YLSexTip.h"
#define __kYLWindow           [UIApplication sharedApplication].delegate.window

@interface YLSexTip ()

@property (nonatomic, strong) UIView *contentV;

@property (nonatomic, strong) UIButton *maleButt;
@property (nonatomic, strong) UIButton *femaleButt;
@property (nonatomic, strong) UIButton *cancelButt;
@property (nonatomic, strong) UIButton *coverButt;//遮幕

@property (nonatomic, copy) YLSexTipCallBack callback;

@end

static YLSexTip *sexTip = nil;
@implementation YLSexTip
+ (instancetype)sharedYLSexTip
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sexTip = [[YLSexTip alloc] init];
    });
    return sexTip;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)_initUI
{
    _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, __kYLWindow.bounds.size.height, __kYLWindow.bounds.size.width, 140)];
    _contentV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    _maleButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _femaleButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat bHeight = 45;
    CGFloat bWidth = __kYLWindow.bounds.size.width;
    _maleButt.frame = CGRectMake(0, 0, bWidth, bHeight);
    _femaleButt.frame = CGRectMake(0, bHeight+1, bWidth, bHeight);
    _cancelButt.frame = CGRectMake(0, 140-bHeight, bWidth, bHeight);
    
    _maleButt.titleLabel.font = [UIFont systemFontOfSize:15];
    _femaleButt.titleLabel.font = [UIFont systemFontOfSize:15];
    _cancelButt.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [_maleButt setTitle:@"男" forState:UIControlStateNormal];
    [_femaleButt setTitle:@"女" forState:UIControlStateNormal];
    [_cancelButt setTitle:@"取消" forState:UIControlStateNormal];
    
    [_maleButt setTitleColor:[UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1] forState:UIControlStateNormal];
    [_femaleButt setTitleColor:[UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1] forState:UIControlStateNormal];
    [_cancelButt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _maleButt.backgroundColor = [UIColor whiteColor];
    _femaleButt.backgroundColor = [UIColor whiteColor];
    _cancelButt.backgroundColor = [UIColor whiteColor];
    
    [_maleButt addTarget:self action:@selector(maleAction) forControlEvents:UIControlEventTouchUpInside];
    [_femaleButt addTarget:self action:@selector(femaleAction) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButt addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_contentV addSubview:_maleButt];
    [_contentV addSubview:_femaleButt];
    [_contentV addSubview:_cancelButt];
    
    _coverButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _coverButt.backgroundColor = [UIColor blackColor];
    _coverButt.alpha = 0.3;
    [_coverButt addTarget:self action:@selector(clickOutAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- Action
- (void)maleAction
{
    if (self.callback) self.callback(YES);
    [YLSexTip hiddenTimeView];
}

- (void)femaleAction
{
    if (self.callback) self.callback(NO);
    [YLSexTip hiddenTimeView];
}

- (void)cancelAction
{
    [YLSexTip hiddenTimeView];
}

- (void)clickOutAction
{
    [YLSexTip hiddenTimeView];
}

#pragma mark -- Public
+ (void)showSexTipcallBack:(YLSexTipCallBack)callback;
{
    [YLSexTip sharedYLSexTip];
    if (sexTip.contentV == nil) {
        [sexTip _initUI];
    }
    
    sexTip.callback = callback;
    
    sexTip.coverButt.frame = __kYLWindow.bounds;
    [__kYLWindow addSubview:sexTip.coverButt];
    
    [__kYLWindow addSubview:sexTip.contentV];
    [__kYLWindow bringSubviewToFront:sexTip.contentV];
    
    [UIView animateWithDuration:0.5 animations:^{
        sexTip.contentV.frame = CGRectMake(0, __kYLWindow.bounds.size.height - 140, __kYLWindow.bounds.size.width, 140);
    }];
}

+ (void)hiddenTimeView
{
    [UIView animateWithDuration:0.5 animations:^{
        sexTip.contentV.frame = CGRectMake(0, __kYLWindow.bounds.size.height, __kYLWindow.bounds.size.width, 140);
    } completion:^(BOOL finished) {
        [sexTip.contentV removeFromSuperview];
        sexTip.contentV = nil;
        [sexTip.coverButt removeFromSuperview];
        sexTip.coverButt = nil;
    }];
}





@end
