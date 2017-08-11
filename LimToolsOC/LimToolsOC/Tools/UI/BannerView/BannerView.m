//
//  BannerView.m
//  LimToolsOC
//
//  Created by Liu on 11/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "BannerView.h"
#import "RotationImageView.h"
#import "RotationCtrlBarView.h"

@interface BannerView ()

@property (nonatomic, strong) RotationImageView     *rIv;
@property (nonatomic, strong) RotationCtrlBarView   *rcbv;

@end

@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)_initUI {
    _rIv = [[RotationImageView alloc] initWithFrame:self.bounds];
    _rcbv = [[RotationCtrlBarView alloc] initWithFrame:CGRectMake(self.bounds.size.width-80, self.bounds.size.height-50, 70, 50)];
    [self addSubview:_rIv];
    [self addSubview:_rcbv];
    
    __weak RotationCtrlBarView *safeRCBV = _rcbv;
    _rIv.scrollToIndex = ^(NSUInteger index) {
        safeRCBV.currentNum = index+1;
    };
    __weak BannerView *safeSelf = self;
    _rIv.tapCallBack = ^(NSUInteger index) {
        if (safeSelf.tapCallBack) safeSelf.tapCallBack(index);
    };
}

#pragma mark -- Setter
- (void)setImages:(NSArray<NSString *> *)images {
    _images = images;
    [_rIv configImgs:_images];
    _rcbv.numOfPoints = _images.count;
}

- (void)setCycleScroll:(BOOL)cycleScroll {
    _cycleScroll = cycleScroll;
    _rIv.cycleScroll = _cycleScroll;
}

- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    _rIv.autoScroll = _autoScroll;
}

- (void)setDuration:(float)duration {
    _duration = duration;
    _rIv.duration = _duration;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
