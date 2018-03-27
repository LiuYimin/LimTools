//
//  LTDatePicker.m
//  LimToolsOC
//
//  Created by Liu on 30/01/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import "LTDatePicker.h"
#define __kYLWindow           [UIApplication sharedApplication].delegate.window

const CGFloat containerHeight = 224;
const CGFloat titleContainerHeight = 40;
const NSInteger minYear = 1970;
const NSInteger maxYear = 2017;

static LTDatePicker *datePicker = nil;
@interface LTDatePicker()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIView *coverView;//背景透明层
@property (nonatomic, strong) UIView *containerView;//容器View
@property (nonatomic, strong) UIView *titleContainerView;//头部容器
@property (nonatomic, strong) UIPickerView *datePicker;//日期选择器
@property (nonatomic, strong) UIButton *cancelBtn;//取消按钮
@property (nonatomic, strong) UIButton *ensureBtn;//确定按钮
@property (nonatomic, strong) UILabel *titleLab;//标题

@property (nonatomic, strong) NSMutableArray *years;
@property (nonatomic, strong) NSMutableArray *months;
@property (nonatomic, strong) NSMutableArray *hours;
@property (nonatomic, strong) NSMutableArray *minutes;
@property (nonatomic, assign) NSInteger yearIndex;
@property (nonatomic, assign) NSInteger monthIndex;
@property (nonatomic, assign) NSInteger dayIndex;
@property (nonatomic, assign) NSInteger hourIndex;
@property (nonatomic, assign) NSInteger minuteIndex;
@end
@implementation LTDatePicker
+ (void)showCallBack:(void(^)(NSDate *date))selectedCallBack;
{
    [LTDatePicker defaultDatePicker];
    [__kYLWindow addSubview:datePicker.coverView];
    [__kYLWindow addSubview:datePicker.containerView];
    [UIView animateWithDuration:0.3 animations:^{
        datePicker.containerView.frame = CGRectMake(0, __kYLWindow.bounds.size.height-containerHeight, __kYLWindow.bounds.size.width, containerHeight);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (id sub in datePicker.datePicker.subviews) {
            NSLog(@"");
        }
    });
}

+ (instancetype)defaultDatePicker
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        datePicker = [[LTDatePicker alloc] init];
    });
    return datePicker;
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
    _years = [NSMutableArray array];
    _months = [NSMutableArray array];
    _hours = [NSMutableArray array];
    _minutes = [NSMutableArray array];
    
    for (int i = 0; i < 60; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d", i];
        if (i < 12) {
            [_months addObject:num];
        }
        if (i < 24) {
            [_hours addObject:num];
        }
        [_minutes addObject:num];
    }
    for (int i = minYear; i <= maxYear; i++) {
        NSString *num = [NSString stringWithFormat:@"%04d", i];
        [_years addObject:num];
    }
}

- (void)_initUI
{
    {
        _coverView = [UIView new];
        _coverView.frame = __kYLWindow.bounds;
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.0;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCancel)];
        [_coverView addGestureRecognizer:ges];
    }
    
    {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, 0, 100, titleContainerHeight);
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn setTitleColor:[UIColor colorWithRed:254.0/255.0 green:138.0/255.0 blue:32.0/255.0 alpha:1] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        _ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ensureBtn.frame = CGRectMake(__kYLWindow.bounds.size.width-100, 0, 100, titleContainerHeight);
        _ensureBtn.backgroundColor = [UIColor clearColor];
        [_ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _ensureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_ensureBtn setTitleColor:[UIColor colorWithRed:254.0/255.0 green:138.0/255.0 blue:32.0/255.0 alpha:1] forState:UIControlStateNormal];
        [_ensureBtn addTarget:self action:@selector(onEnsure) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.text = @"请选择预约时间";
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _titleLab.frame = CGRectMake(CGRectGetMaxX(_cancelBtn.frame), 0, __kYLWindow.bounds.size.width-2*100, titleContainerHeight);
    }
    
    {
        _titleContainerView = [UIView new];
        _titleContainerView.frame = CGRectMake(0, 0, __kYLWindow.bounds.size.width, titleContainerHeight);
        _titleContainerView.backgroundColor = [UIColor clearColor];
        [_titleContainerView addSubview:_cancelBtn];
        [_titleContainerView addSubview:_ensureBtn];
        [_titleContainerView addSubview:_titleLab];
    }
    
    {
        _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, titleContainerHeight+20, __kYLWindow.bounds.size.width, containerHeight-titleContainerHeight-40)];
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
    }

    {
        _containerView = [UIView new];
        _containerView.frame = CGRectMake(0, __kYLWindow.bounds.size.height, __kYLWindow.bounds.size.width, containerHeight);
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.clipsToBounds = YES;
        [_containerView addSubview:_datePicker];
        [_containerView addSubview:_titleContainerView];
    }
}

#pragma mark -- Action
- (void)onCancel
{
    
}

- (void)onEnsure
{
    
}

#pragma mark -- Tool
- (NSInteger)monthDaysWith:(NSInteger)year month:(NSInteger)month
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%4ld-%2ld", (long)year, (long)(month+1)]];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay  //NSDayCalendarUnit - ios 8
                                   inUnit: NSCalendarUnitMonth //NSMonthCalendarUnit - ios 8
                                  forDate:date];
    return range.length;
}

- (NSArray *)getNumberOfRowsInComponent
{
    NSInteger yearNum = _years.count;
    NSInteger monthNum = _months.count;
    NSInteger dayNum = [self monthDaysWith:[_years[_yearIndex] integerValue] month:[_months[_monthIndex] integerValue]];
    NSInteger hourNum = _hours.count;
    NSInteger minuteNUm = _minutes.count;
    return @[@(yearNum),@(monthNum),@(dayNum),@(hourNum),@(minuteNUm)];
}

- (NSArray *)getTitleOfRowInComponent
{
    NSString *year = _years[_yearIndex];
    NSString *month = _months[_monthIndex];
    NSString *day = [NSString stringWithFormat:@"%2ld", _dayIndex];
    NSString *hour = _hours[_hourIndex];
    NSString *minute = _minutes[_minuteIndex];
    return @[year,month,day,hour,minute];
}

#pragma mark -- UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return __kYLWindow.bounds.size.width/5.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    NSString *title = @"";
    if (component==0) {
        title = [NSString stringWithFormat:@"%@年", _years[row]];
    }else if (component == 1) {
        title = [NSString stringWithFormat:@"%@月", _months[row]];
    }else if (component == 2) {
        title = [NSString stringWithFormat:@"%02ld日", row+1];
    }else if (component == 3) {
        title = [NSString stringWithFormat:@"%@时", _hours[row]];
    }else {
        title = [NSString stringWithFormat:@"%@分", _minutes[row]];
    }
    label.text = title;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component==0) {
        _yearIndex = row;
    }else if (component == 1) {
        _monthIndex = row;
    }else if (component == 2) {
        _dayIndex = row;
    }else if (component == 3) {
        _hourIndex = row;
    }else {
        _minuteIndex = row;
    }
}

#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

@end
