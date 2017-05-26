//
//  RotationImageView.m
//  PictureCircle
//
//  Created by Liu on 26/05/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "RotationImageView.h"
#import "RotationCtrlBarView.h"
#import <objc/runtime.h>

static char * imageViewNumKey;

@interface RotationImageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray        *imgsArray;
@property (nonatomic, strong) UIScrollView          *contentView;
@property (nonatomic, strong) RotationCtrlBarView   *ctrlBar;

@end

@implementation RotationImageView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imgsArray = [NSMutableArray array];
        _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentView.pagingEnabled = YES;
        _contentView.delegate = self;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentView];
        
        _ctrlBar = [[RotationCtrlBarView alloc] initWithFrame:CGRectMake(self.bounds.size.width-80, self.bounds.size.height-30, 70, 30)];
        [self addSubview:_ctrlBar];
    }
    return self;
}

#pragma mark -- UpdateUI
- (void)updateImages {
    for (int i = 0; i < _imgsArray.count; i++) {
        UIImage *img = [UIImage imageNamed:_imgsArray[i]];
        UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        imv.image = img;
        imv.userInteractionEnabled = YES;
        [_contentView addSubview:imv];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imv addGestureRecognizer:tapGes];
        
        objc_setAssociatedObject(imv, imageViewNumKey, @(i), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    _contentView.contentSize = CGSizeMake(_imgsArray.count * self.bounds.size.width, self.bounds.size.height);
}

//循环滚动开启时,添加首尾图片
- (void)addHeadFooterImages {
    if (_imgsArray.count <= 1) {
        return;
    }
    
    UIImageView *headImv = [[UIImageView alloc] initWithFrame:CGRectMake(-self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    headImv.image = [UIImage imageNamed:_imgsArray.lastObject];
    [_contentView addSubview:headImv];
    
    UIImageView *footImv = [[UIImageView alloc] initWithFrame:CGRectMake(_imgsArray.count*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    footImv.image = [UIImage imageNamed:_imgsArray.firstObject];
    [_contentView addSubview:footImv];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [headImv addGestureRecognizer:tapGes];
    objc_setAssociatedObject(headImv, imageViewNumKey, @(_imgsArray.count-1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [footImv addGestureRecognizer:tapGes1];
    objc_setAssociatedObject(footImv, imageViewNumKey, @(0), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    _contentView.contentInset = UIEdgeInsetsMake(0, self.bounds.size.width, 0, self.bounds.size.width);
}

- (void)removeAllImages {
    for (UIView *imv in _contentView.subviews) {
        if ([imv isKindOfClass:[UIImageView class]]) {
            [imv removeFromSuperview];
        }
    }
}

#pragma mark -- Public
- (void)configImgs:(NSArray<NSString *> *)imgs {
    [_imgsArray removeAllObjects];
    [_imgsArray addObjectsFromArray:imgs];
    [self removeAllImages];
    
    [self updateImages];
    
    if (_cycleScroll) {
        [self addHeadFooterImages];
    }
    
    _ctrlBar.numOfPoints = imgs.count;
    _ctrlBar.currentNum = 1;
}

- (void)setCycleScroll:(BOOL)cycleScroll {
    _cycleScroll = cycleScroll;
    [self removeAllImages];
    [self updateImages];

    if (_cycleScroll) {
        [self addHeadFooterImages];
    }else {
        _contentView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark -- Tap
- (void)tapAction:(UITapGestureRecognizer *)ges {
    NSNumber *index = objc_getAssociatedObject(ges.self.view, imageViewNumKey);
    if (self.tapCallBack) {
        self.tapCallBack(index.integerValue);
    }
}


#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x/self.bounds.size.width;

    if (!_cycleScroll) {
        
    }else {
        if (index < 0) {
            scrollView.contentOffset = CGPointMake((_imgsArray.count-1)*self.bounds.size.width, 0);
        }
        if (index == _imgsArray.count) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
    
    
    //设置 CtrlBar 的内容
    if (index < 0) {
        index = (int)_imgsArray.count-1;
    }else if (index >= _imgsArray.count) {
        index = 0;
    }
    _ctrlBar.currentNum = index+1;
}


@end
