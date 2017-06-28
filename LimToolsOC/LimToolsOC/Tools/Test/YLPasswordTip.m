//
//  YLPasswordTip.m
//  LimToolsOC
//
//  Created by Liu on 21/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "YLPasswordTip.h"
#define __kYLWindow           [UIApplication sharedApplication].delegate.window

@interface YLPasswordTip ()

@property (nonatomic, strong) UIView *tipWindow;

//子控件
@property (nonatomic, strong) UILabel       *titleLab;
@property (nonatomic, strong) UILabel       *messageLab;
@property (nonatomic, strong) UITextField   *inputPsdTxtf;
@property (nonatomic, strong) UIButton      *denyButt;
@property (nonatomic, strong) UIButton      *certainButt;

@property (nonatomic, strong) UIView        *supView;
@property (nonatomic, copy)   NSString      *title;
@property (nonatomic, copy) YLPasswordTipCallBack callBack;

@end
static YLPasswordTip *psdTip = nil;
@implementation YLPasswordTip

+ (instancetype)sharedYLTip
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        psdTip = [[YLPasswordTip alloc] init];
    });
    return psdTip;
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
    CGFloat wRate = 272/375.0; //宽随屏幕宽度定
    CGFloat whRate = 202/272.0; //高随宽度定
    
    CGFloat width = __kYLWindow.bounds.size.width * wRate;
    CGFloat height = width * whRate;
    
    CGFloat hRate = height/202.0;
    
    
    _tipWindow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _tipWindow.center = __kYLWindow.center;
    _tipWindow.backgroundColor = [UIColor whiteColor];
    _tipWindow.layer.cornerRadius = 4;
    
    _titleLab = [[UILabel alloc] init];
    _messageLab = [[UILabel alloc] init];
    _inputPsdTxtf = [[UITextField alloc] init];
    _denyButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _certainButt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _titleLab.frame = CGRectMake(0, 8, width, 23*hRate);
    _messageLab.frame = CGRectMake(15, CGRectGetMaxY(_titleLab.frame)+8*hRate, width-30, 36*hRate);
    _inputPsdTxtf.frame = CGRectMake(14, CGRectGetMaxY(_messageLab.frame)+15, width-28, 23*hRate);
    _denyButt.frame = CGRectMake(20, CGRectGetMaxY(_inputPsdTxtf.frame)+15*hRate, 110*hRate, 40*hRate);
    _certainButt.frame = CGRectMake(_tipWindow.bounds.size.width - 110*hRate - 20*hRate, _denyButt.frame.origin.y, 110*hRate, 40*hRate);
    
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.text = @"验证原密码";
    
    _messageLab.textAlignment = NSTextAlignmentCenter;
    _messageLab.font = [UIFont systemFontOfSize:13];
    _messageLab.numberOfLines = 0;
    
    _inputPsdTxtf.layer.borderColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1].CGColor;
    _inputPsdTxtf.layer.borderWidth = 1;
    
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
    
    
    [_tipWindow addSubview:_titleLab];
    [_tipWindow addSubview:_messageLab];
    [_tipWindow addSubview:_inputPsdTxtf];
    [_tipWindow addSubview:_denyButt];
    [_tipWindow addSubview:_certainButt];
}

#pragma mark -- Action
- (void)denyAction
{
    if (self.callBack) {
        self.callBack(NO, nil);
    }
    [self.tipWindow removeFromSuperview];
    self.tipWindow = nil;
}

- (void)certainAction
{
    if (self.callBack) {
        self.callBack(YES, _inputPsdTxtf.text);
    }
    [self.tipWindow removeFromSuperview];
    self.tipWindow = nil;
}

#pragma mark -- Setter

- (void)setTitle:(NSString *)title {
    _title = title;
    _messageLab.text = _title;
}


#pragma mark -- Public
+ (void)showTipOnWindowTitle:(NSString *)titleMessage callBack:(YLPasswordTipCallBack)callback
{
    [self showTipOnView:__kYLWindow Title:titleMessage callBack:callback];
}

+ (void)showTipOnView:(UIView *)view Title:(NSString *)titleMessage callBack:(YLPasswordTipCallBack)callback
{
    [YLPasswordTip sharedYLTip];
    if (psdTip.tipWindow == nil) {
        [psdTip _initUI];
    }
    
    psdTip.supView = view;
    psdTip.title = titleMessage;
    psdTip.callBack = callback;
    
    
    [psdTip.supView addSubview:psdTip.tipWindow];
    psdTip.tipWindow.center = psdTip.supView.center;
    [psdTip.supView bringSubviewToFront:psdTip.tipWindow];
}



@end
