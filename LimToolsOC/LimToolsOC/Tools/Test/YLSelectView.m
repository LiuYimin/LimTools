//
//  YLSelectView.m
//  LimToolsOC
//
//  Created by Liu on 21/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "YLSelectView.h"
#import "YLSelectCell.h"
#define __kYLWindow           [UIApplication sharedApplication].delegate.window

@interface YLSelectView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tipContainerTBV;
@property (nonatomic, strong) UIButton    *coverButt;//遮幕

@property (nonatomic, strong) UIView        *supView;

@property (nonatomic, strong) NSArray     *contentArray;

@property (nonatomic, copy) YLSelectViewCallBack selectCallBack;

@end

static YLSelectView *selectV = nil;
@implementation YLSelectView
+ (instancetype)sharedYLSelectView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selectV = [[YLSelectView alloc] init];
    });
    return selectV;
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
    
}

- (void)_initUI
{
    CGFloat width = (270/375.0)*__kYLWindow.bounds.size.width;
    _tipContainerTBV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, 50) style:UITableViewStylePlain];
    _tipContainerTBV.delegate = self;
    _tipContainerTBV.dataSource = self;
    _tipContainerTBV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tipContainerTBV.center = __kYLWindow.center;
    
    _tipContainerTBV.layer.cornerRadius = 5;
    _tipContainerTBV.backgroundColor = [UIColor whiteColor];
    
    _coverButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _coverButt.backgroundColor = [UIColor blackColor];
    _coverButt.alpha = 0.3;
    [_coverButt addTarget:self action:@selector(clickOutAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickOutAction
{
    [_tipContainerTBV removeFromSuperview];
    _tipContainerTBV = nil;
    [_coverButt removeFromSuperview];
    _coverButt = nil;
}

#pragma mark -- Public
+ (void)showTipOnView:(UIView *)view contents:(NSArray *)contents callBack:(YLSelectViewCallBack)callback
{
#if DEBUG
    contents = @[@{@"title":@"完成任务",@"img":@""},@{@"title":@"推迟任务",@"img":@""},@{@"title":@"无法完成",@"img":@""}];
#endif
    [YLSelectView sharedYLSelectView];
    if (selectV.tipContainerTBV == nil) {
        [selectV _initUI];
    }
    selectV.supView = view;
    selectV.selectCallBack = callback;
    selectV.contentArray = contents;
    
    CGRect frame = selectV.tipContainerTBV.frame;
    frame.size.height = contents.count * 43;
    if (contents.count > 8) {
        frame.size.height = 8 * 43;
    }
    selectV.tipContainerTBV.frame = frame;
    
    selectV.coverButt.frame = view.bounds;
    [view addSubview:selectV.coverButt];
    [view addSubview:selectV.tipContainerTBV];
    selectV.tipContainerTBV.center = view.center;
    [view bringSubviewToFront:selectV.tipContainerTBV];
    
    [selectV.tipContainerTBV reloadData];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"YLSELECtVIEWCELLID";
    YLSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YLSelectCell" owner:nil options:nil] lastObject];
    }
    
    if (_contentArray.count > indexPath.row) {
        cell.contentDict = _contentArray[indexPath.row];
    }
    
    cell.isLast = ((_contentArray.count-1)==indexPath.row);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectCallBack) {
        self.selectCallBack(indexPath.row);
    }
    [self clickOutAction];
}


@end
