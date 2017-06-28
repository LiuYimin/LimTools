//
//  YLTip.m
//  LimToolsOC
//
//  Created by Liu on 20/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "YLTip.h"
#define __kYLWindow           [UIApplication sharedApplication].delegate.window

static YLTip *tip = nil;
@interface YLTip ()

@property (nonatomic, strong) UIView *tipWindow;

//子控件
@property (nonatomic, strong) UIImageView   *titleImv;
@property (nonatomic, strong) UILabel       *messageLab;
@property (nonatomic, strong) UIButton      *denyButt;
@property (nonatomic, strong) UIButton      *certainButt;

//外界控件
@property (nonatomic, strong) UIView        *supView;
@property (nonatomic, copy)   NSString      *title;
@property (nonatomic, copy)   NSString      *titleImvStr;

//回调
@property (nonatomic, copy)   YLTipCallBack callBack;

@end

@implementation YLTip

+ (instancetype)sharedYLTip
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tip = [[YLTip alloc] init];
    });
    return tip;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _initUI];
    }
    return self;
}

//272:375  202:272
- (void)_initUI
{
    CGFloat wRate = 272/375.0; //宽随屏幕宽度定
    CGFloat whRate = 202/272.0; //高随宽度定
    
    CGFloat width = __kYLWindow.bounds.size.width * wRate;
    CGFloat height = width * whRate;
    
    CGFloat hRate = height/202.0;
    
    
    _tipWindow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _tipWindow.center = __kYLWindow.center;
    _tipWindow.backgroundColor = [UIColor whiteColor];
    _tipWindow.layer.cornerRadius = 4;
    
    
    _titleImv = [[UIImageView alloc] init];
    _messageLab = [[UILabel alloc] init];
    _denyButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _certainButt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _titleImv.frame = CGRectMake(0, 18*hRate, 50*hRate, 50*hRate);
    _titleImv.center = CGPointMake(_tipWindow.bounds.size.width/2.0, _titleImv.center.y);
    _messageLab.frame = CGRectMake(0, CGRectGetMaxY(_titleImv.frame)+20*hRate, _tipWindow.bounds.size.width, 40*hRate);
    _denyButt.frame = CGRectMake(20, CGRectGetMaxY(_messageLab.frame)+15*hRate, 110*hRate, 40*hRate);
    _certainButt.frame = CGRectMake(_tipWindow.bounds.size.width - 110*hRate - 20*hRate, _denyButt.frame.origin.y, 110*hRate, 40*hRate);
    
    
    _titleImv.contentMode = UIViewContentModeScaleAspectFit;
    _messageLab.numberOfLines = 0;
    _messageLab.font = [UIFont systemFontOfSize:14];
    _messageLab.textAlignment = NSTextAlignmentCenter;
    [_denyButt setTitle:@"否" forState:UIControlStateNormal];
    [_denyButt setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    _denyButt.layer.cornerRadius = _denyButt.bounds.size.height/2.f;
    _denyButt.layer.borderWidth = 1;
    _denyButt.layer.borderColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1].CGColor;
    [_certainButt setTitle:@"是" forState:UIControlStateNormal];
    _certainButt.layer.cornerRadius = _certainButt.bounds.size.height/2.f;
    _certainButt.backgroundColor = [UIColor colorWithRed:49/255.0 green:188/255.0 blue:206/255.0 alpha:1];
    [_certainButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_denyButt addTarget:self action:@selector(denyAction) forControlEvents:UIControlEventTouchUpInside];
    [_certainButt addTarget:self action:@selector(certainAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_tipWindow addSubview:_titleImv];
    [_tipWindow addSubview:_messageLab];
    [_tipWindow addSubview:_denyButt];
    [_tipWindow addSubview:_certainButt];
}

#pragma mark -- Setting
- (void)setTitle:(NSString *)title {
    _title = title;
    _messageLab.text = _title;
}

- (void)setTitleImvStr:(NSString *)titleImvStr {
    _titleImvStr = titleImvStr;
    UIImage *img = [UIImage imageNamed:_titleImvStr];
    if (img != nil) {
        _titleImv.image = img;
    }else {
        //default
    }
}

#pragma mark -- Action
- (void)denyAction
{
    if (self.callBack) {
        self.callBack(NO);
    }
    [self.tipWindow removeFromSuperview];
    self.tipWindow = nil;
}

- (void)certainAction
{
    if (self.callBack) {
        self.callBack(YES);
    }
    [self.tipWindow removeFromSuperview];
    self.tipWindow = nil;
}


#pragma mark -- Public
+ (void)showTipOnWindowTitle:(NSString *)titleMessage image:(NSString *)imageName callBack:(YLTipCallBack)callback
{
    [self showTipOnView:__kYLWindow Title:titleMessage image:imageName callBack:callback];
}

+ (void)showTipOnView:(UIView *)view Title:(NSString *)titleMessage image:(NSString *)imageName callBack:(YLTipCallBack)callback
{
    [YLTip sharedYLTip];
    if (tip.tipWindow == nil) {
        [tip _initUI];
    }
    
    tip.supView = view;
    tip.title = titleMessage;
    tip.titleImvStr = imageName;
    tip.callBack = callback;
    
    
    [tip.supView addSubview:tip.tipWindow];
    tip.tipWindow.center = tip.supView.center;
    [tip.supView bringSubviewToFront:tip.tipWindow];
}

@end
