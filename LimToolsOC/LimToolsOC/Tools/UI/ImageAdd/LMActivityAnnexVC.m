//
//  LMActivityAnnexVC.m
//  ArtWorkCloud
//
//  Created by Liu on 22/08/2017.
//  Copyright © 2017 rvision. All rights reserved.
//

#import "LMActivityAnnexVC.h"
#import "UIImageView+WebCache.h"

#define BASETAG 1098

@interface LMActivityAnnexVC ()<UIScrollViewDelegate>
{
    NSInteger _currentIndex;
}
@property (nonatomic, strong) NSMutableArray *contentArray;

@property (nonatomic, strong) UIScrollView  *containerSv;
@property (nonatomic, strong) UIPageControl *pgCtrl;
@property (nonatomic, strong) UIButton      *deleteButt;

@end

@implementation LMActivityAnnexVC

#pragma mark -- Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self _initData];
    [self _initUI];
    [self addDeleteButt];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Custom
- (void)_initData
{
    _contentArray = [NSMutableArray arrayWithArray:_imgArray];
    _currentIndex = _index;
}

- (void)_initUI
{
    _containerSv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-40)];
    [self.view addSubview:_containerSv];
    
    _containerSv.pagingEnabled = YES;
    _containerSv.delegate = self;
    _containerSv.showsVerticalScrollIndicator = NO;
    _containerSv.showsHorizontalScrollIndicator = NO;
    
    _pgCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, __kHeight-22, __kWidth, 22)];
    _pgCtrl.pageIndicatorTintColor = RGBA(255, 255, 255, 0.5);
    _pgCtrl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pgCtrl.currentPage = 0;
    [self.view addSubview:_pgCtrl];
    
    [self updateContentImages];
}

- (void)updateContentImages
{
    for (UIView *v in _containerSv.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    
    for (int i = 0; i < _contentArray.count; i++) {
        LMImage *img = _contentArray[i];
        UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(i * __kWidth, 0, __kWidth, _containerSv.bounds.size.height)];
        imv.contentMode = UIViewContentModeScaleAspectFit;
        imv.tag = BASETAG + i;
        imv.image = img.originalImage;
        if (img.originalImage) {
            imv.image = img.originalImage;
        }else if (img.netUrl){
            [imv sd_setImageWithURL:[NSURL URLWithString:img.netUrl]];
        }
        
        if (self.singleTapClose) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
            [imv addGestureRecognizer:tap];
            imv.userInteractionEnabled = YES;
        }
        
        [_containerSv addSubview:imv];
    }
    _containerSv.contentSize = CGSizeMake(__kWidth * _contentArray.count, _containerSv.bounds.size.height);
    
    _pgCtrl.numberOfPages = _contentArray.count;
    _pgCtrl.currentPage = _index;
    _containerSv.contentOffset = CGPointMake(__kWidth * _index, 0);
}

- (void)addDeleteButt
{
    _deleteButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButt.frame = CGRectMake(0, 0, 50, 44);
    _deleteButt.titleLabel.font = [UIFont systemFontOfSize:13];
    [_deleteButt setTitleColor:RGBS(255) forState:UIControlStateNormal];
    [_deleteButt setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButt addTarget:self action:@selector(onDelete) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:_deleteButt];
    
    //挤压按钮,向右靠拢
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -20;
    
    self.navigationItem.rightBarButtonItems = @[space, favoriteItem];
}


#pragma mark -- Action
- (void)onDelete
{
    if (self.deleteImageCallBack) self.deleteImageCallBack(_contentArray[_currentIndex]);
    if (_currentIndex < _contentArray.count) {
        [_contentArray removeObjectAtIndex:_currentIndex];
    }
    if (_currentIndex==0) {
        _index = 0;
    }else {
        _index = _currentIndex-1;
    }
    [self updateContentImages];
    _currentIndex = _containerSv.contentOffset.x/__kWidth;
    _pgCtrl.currentPage = _currentIndex;
    
    if (_contentArray.count <= 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)onTap:(UIGestureRecognizer *)ges
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentIndex = scrollView.contentOffset.x/__kWidth;
    _pgCtrl.currentPage = _currentIndex;
}


@end
