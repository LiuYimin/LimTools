//
//  YLImageSelectTip.m
//  LimToolsOC
//
//  Created by Liu on 29/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "YLImageSelectTip.h"
#define __kYLWindow           [UIApplication sharedApplication].delegate.window
#define __YLTotolImageHeight  192

@interface YLImageSelectTip ()

@property (nonatomic, strong) UIView *contentV;

@property (nonatomic, strong) UIButton *cameraButt;
@property (nonatomic, strong) UIButton *pictureButt;
@property (nonatomic, strong) UIButton *deleteButt;
@property (nonatomic, strong) UIButton *cancelButt;
@property (nonatomic, strong) UIButton *coverButt;//遮幕

@property (nonatomic, copy) YLImageSelectTipCallBack callback;

@end

static YLImageSelectTip *imgTip = nil;
@implementation YLImageSelectTip
+ (instancetype)sharedYLSexTip
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imgTip = [[YLImageSelectTip alloc] init];
    });
    return imgTip;
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
    CGFloat totalHeight = __YLTotolImageHeight;
    _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, __kYLWindow.bounds.size.height, __kYLWindow.bounds.size.width, totalHeight)];
    _contentV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    _cameraButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _pictureButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat bHeight = 45;
    CGFloat bWidth = __kYLWindow.bounds.size.width;
    _cameraButt.frame = CGRectMake(0, 0, bWidth, bHeight);
    _pictureButt.frame = CGRectMake(0, bHeight+1, bWidth, bHeight);
    _deleteButt.frame = CGRectMake(0, bHeight*2+2, bWidth, bHeight);
    _cancelButt.frame = CGRectMake(0, totalHeight-bHeight, bWidth, bHeight);
    
    _cameraButt.titleLabel.font = [UIFont systemFontOfSize:15];
    _pictureButt.titleLabel.font = [UIFont systemFontOfSize:15];
    _deleteButt.titleLabel.font = [UIFont systemFontOfSize:15];
    _cancelButt.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [_cameraButt setTitle:@"拍照" forState:UIControlStateNormal];
    [_pictureButt setTitle:@"从手机相册选择" forState:UIControlStateNormal];
    [_deleteButt setTitle:@"删除" forState:UIControlStateNormal];
    [_cancelButt setTitle:@"取消" forState:UIControlStateNormal];
    
    [_cameraButt setTitleColor:[UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1] forState:UIControlStateNormal];
    [_pictureButt setTitleColor:[UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1] forState:UIControlStateNormal];
    [_deleteButt setTitleColor:[UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1] forState:UIControlStateNormal];
    [_cancelButt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _cameraButt.backgroundColor = [UIColor whiteColor];
    _pictureButt.backgroundColor = [UIColor whiteColor];
    _deleteButt.backgroundColor = [UIColor whiteColor];
    _cancelButt.backgroundColor = [UIColor whiteColor];
    
    [_cameraButt addTarget:self action:@selector(cameraAction) forControlEvents:UIControlEventTouchUpInside];
    [_pictureButt addTarget:self action:@selector(pictureAction) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButt addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButt addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_contentV addSubview:_cameraButt];
    [_contentV addSubview:_pictureButt];
    [_contentV addSubview:_deleteButt];
    [_contentV addSubview:_cancelButt];
    
    _coverButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _coverButt.backgroundColor = [UIColor blackColor];
    _coverButt.alpha = 0.3;
    [_coverButt addTarget:self action:@selector(clickOutAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- Action
- (void)cameraAction
{
    if (self.callback) self.callback(0);
    [YLImageSelectTip hiddenTimeView];
}

- (void)pictureAction
{
    if (self.callback) self.callback(1);
    [YLImageSelectTip hiddenTimeView];
}

- (void)deleteAction
{
    if (self.callback) self.callback(2);
    [YLImageSelectTip hiddenTimeView];
}

- (void)cancelAction
{
    [YLImageSelectTip hiddenTimeView];
}

- (void)clickOutAction
{
    [YLImageSelectTip hiddenTimeView];
}

#pragma mark -- Public
+ (void)showImageSelectCallBack:(YLImageSelectTipCallBack)callback;
{
    [YLImageSelectTip sharedYLSexTip];
    if (imgTip.contentV == nil) {
        [imgTip _initUI];
    }
    
    imgTip.callback = callback;
    
    imgTip.coverButt.frame = __kYLWindow.bounds;
    [__kYLWindow addSubview:imgTip.coverButt];
    
    [__kYLWindow addSubview:imgTip.contentV];
    [__kYLWindow bringSubviewToFront:imgTip.contentV];
    
    [UIView animateWithDuration:0.5 animations:^{
        imgTip.contentV.frame = CGRectMake(0, __kYLWindow.bounds.size.height - __YLTotolImageHeight, __kYLWindow.bounds.size.width, __YLTotolImageHeight);
    }];
}

+ (void)hiddenTimeView
{
    [UIView animateWithDuration:0.5 animations:^{
        imgTip.contentV.frame = CGRectMake(0, __kYLWindow.bounds.size.height, __kYLWindow.bounds.size.width, __YLTotolImageHeight);
    } completion:^(BOOL finished) {
        [imgTip.contentV removeFromSuperview];
        imgTip.contentV = nil;
        [imgTip.coverButt removeFromSuperview];
        imgTip.coverButt = nil;
    }];
}
@end
