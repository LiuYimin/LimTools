//
//  RotationImageView.m
//  PictureCircle
//
//  Created by Liu on 26/05/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "RotationImageView.h"
#import <objc/runtime.h>

static char * imageViewNumKey;

@interface RotationImageView ()<UIScrollViewDelegate>
{
    NSTimer     *_timer;
    NSInteger    _currentIndex;
}

@property (nonatomic, strong) NSMutableArray        *imgsArray;
@property (nonatomic, strong) UIScrollView          *contentView;

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
        _duration = 4;
        [self addSubview:_contentView];
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

- (void)_initAutoScrollTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.duration repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (!_cycleScroll && _currentIndex == _imgsArray.count-1) {//如果不是循环滚动,那么滚动到末尾,就该滚到第一张啦,而且是逆向
            _currentIndex = -1;
        }
        [UIView animateWithDuration:0.25 animations:^{
            _contentView.contentOffset = CGPointMake((_currentIndex+1)*_contentView.bounds.size.width, 0);
        } completion:^(BOOL finished) {
            if (_currentIndex < 0) {
                _currentIndex = _imgsArray.count-1;
                _contentView.contentOffset = CGPointMake((_imgsArray.count-1)*self.bounds.size.width, 0);
            }else if (_currentIndex >= _imgsArray.count) {
                _currentIndex = 0;
                _contentView.contentOffset = CGPointMake(0, 0);
            }
        }];
    }];
}

- (void)removeTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
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
    
    if (_autoScroll) {
        [self _initAutoScrollTimer];
    }
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

- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    if (_autoScroll) {
        [self _initAutoScrollTimer];
    }else {
        [self removeTimer];
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

    if (_cycleScroll && !_autoScroll) {
        if (index < 0) {
            scrollView.contentOffset = CGPointMake((_imgsArray.count-1)*self.bounds.size.width, 0);
        }
        if (index == _imgsArray.count) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
    
    _currentIndex = index;
    
    //设置 CtrlBar 的内容
    if (index < 0) {
        index = (int)_imgsArray.count-1;
    }else if (index >= _imgsArray.count) {
        index = 0;
    }
    if (self.scrollToIndex) {self.scrollToIndex(index);}
    
    if (!_autoScroll) {
        _currentIndex = index;
    }
}


@end
