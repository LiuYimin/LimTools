//
//  YLSelectTimeView.m
//  LimToolsOC
//
//  Created by Liu on 21/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "YLSelectTimeView.h"
#define __kYLWindow           [UIApplication sharedApplication].delegate.window

@interface YLSelectTimeView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *contentV;

//子控件
@property (nonatomic, strong) UIButton *cancelButt;
@property (nonatomic, strong) UIButton *certainButt;
@property (nonatomic, strong) UIPickerView *datePicker;

@property (nonatomic, strong) UIView  *topL;
@property (nonatomic, strong) UIView  *bottomL;


@property (nonatomic, strong) NSArray  *timeArray;

@property (nonatomic, copy) YLSelectTimeViewCallBack callBack;

@end

static YLSelectTimeView *selectTime = nil;
@implementation YLSelectTimeView
+ (instancetype)sharedYLSelectTimeView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selectTime = [[YLSelectTimeView alloc] init];
    });
    return selectTime;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _initData];
        [self _initUI];
    }
    return self;
}

- (void)_initData
{
    _timeArray = @[@5,@10,@15,@20,@25];
}

- (void)_initUI
{
    _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, __kYLWindow.bounds.size.height, __kYLWindow.bounds.size.width, 210)];
    _contentV.backgroundColor = [UIColor whiteColor];
    
    _cancelButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButt.frame = CGRectMake(10, 8, 40, 25);
    [_cancelButt setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButt setTitleColor:[UIColor colorWithRed:49/255.0 green:188/255.0 blue:206/255.0 alpha:1] forState:UIControlStateNormal];
    _certainButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _certainButt.frame = CGRectMake(__kYLWindow.bounds.size.width-40-10, 8, 40, 25);
    [_certainButt setTitle:@"确定" forState:UIControlStateNormal];
    [_certainButt setTitleColor:[UIColor colorWithRed:49/255.0 green:188/255.0 blue:206/255.0 alpha:1] forState:UIControlStateNormal];
    [_cancelButt addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_certainButt addTarget:self action:@selector(ensureAction) forControlEvents:UIControlEventTouchUpInside];
    
    _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cancelButt.frame)+10, __kYLWindow.bounds.size.width, 160)];
    _datePicker.delegate = self;
    _datePicker.dataSource = self;
    
    [_contentV addSubview:_cancelButt];
    [_contentV addSubview:_certainButt];
    [_contentV addSubview:_datePicker];
    
    _topL = [[UIView alloc] init];
    _bottomL = [[UIView alloc] init];
    _topL.frame = CGRectMake(0, 0, __kYLWindow.bounds.size.width, 1);
    _bottomL.frame = CGRectMake(0, 0, __kYLWindow.bounds.size.width, 1);
    CGPoint cenP = _datePicker.center;
    cenP.y -= 22;
    _topL.center = cenP;
    cenP.y += 44;
    _bottomL.center = cenP;
    _topL.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    _bottomL.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    
    [_contentV addSubview:_topL];
    [_contentV addSubview:_bottomL];
}

#pragma mark -- Action
- (void)cancelAction
{
    if (self.callBack) {
        self.callBack(NO, 0);
    }
    [YLSelectTimeView hiddenTimeView];
}

- (void)ensureAction
{
    NSInteger index = [_datePicker selectedRowInComponent:0];
    NSInteger time = [_timeArray[index] integerValue];
    if (self.callBack) {
        self.callBack(YES, time);
    }
    [YLSelectTimeView hiddenTimeView];
}

#pragma mark -- Public
+ (void)showTimeViewCallBack:(YLSelectTimeViewCallBack)callBack
{
    [YLSelectTimeView sharedYLSelectTimeView];
    if (selectTime.contentV == nil) {
        [selectTime _initUI];
    }
    
    selectTime.callBack = callBack;
    
    [__kYLWindow addSubview:selectTime.contentV];
    [__kYLWindow bringSubviewToFront:selectTime.contentV];
    
    [UIView animateWithDuration:0.5 animations:^{
        selectTime.contentV.frame = CGRectMake(0, __kYLWindow.bounds.size.height - 210, __kYLWindow.bounds.size.width, 210);
    }];
}

+ (void)hiddenTimeView
{
    [UIView animateWithDuration:0.5 animations:^{
        selectTime.contentV.frame = CGRectMake(0, __kYLWindow.bounds.size.height, __kYLWindow.bounds.size.width, 210);
    } completion:^(BOOL finished) {
        [selectTime.contentV removeFromSuperview];
        selectTime.contentV = nil;
    }];
}

#pragma mark -- UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _timeArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d分钟", [_timeArray[row] intValue]];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}



@end
