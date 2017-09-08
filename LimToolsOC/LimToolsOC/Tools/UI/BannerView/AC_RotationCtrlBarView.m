//
//  AC_RotationCtrlBarView.m
//  LimToolsOC
//
//  Created by Liu on 24/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "AC_RotationCtrlBarView.h"
#define ACRGB(r,g,b)          [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1].CGColor
#define ACRGBS(s)             ACRGB(s,s,s)


#define PointHeight 6
#define PointCurrentWidth 10
#define PointToPointGap 9
#define PointCurrentColor ACRGBS(255)
#define PointColor ACRGBS(228);

@interface ACPointLayer : CALayer
@property (nonatomic, assign) BOOL isCurrent;
@end

@implementation ACPointLayer
- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, PointHeight, PointHeight);
        self.cornerRadius = PointHeight/2.0;
        self.backgroundColor = PointColor;
    }
    return self;
}

- (void)setIsCurrent:(BOOL)isCurrent {
    _isCurrent = isCurrent;
    self.frame = _isCurrent?CGRectMake(0, 0, PointCurrentWidth, PointHeight):CGRectMake(0, 0, PointHeight, PointHeight);
    self.backgroundColor = _isCurrent?PointCurrentColor:PointColor;
}


@end

@interface AC_RotationCtrlBarView ()
@property (nonatomic, strong) NSMutableArray *points;
@end

@implementation AC_RotationCtrlBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initData];
        [self _initUI];
    }
    return self;
}

- (void)_initData
{
    _num = 3;
    _curr = 0;
    _points = [NSMutableArray array];
}

- (void)_initUI
{
    [_points removeAllObjects];
    for (int i = 0; i < _num; i++) {
        ACPointLayer *point = [[ACPointLayer alloc] init];
        point.isCurrent = NO;
        [_points addObject:point];
    }
}

- (void)updateUI
{
    {//清楚已经存在的Layer
        NSMutableArray *tmp = [NSMutableArray array];
        for (CALayer *layer in self.layer.sublayers) {
            if ([layer isKindOfClass:[ACPointLayer class]]) {
                [tmp addObject:layer];
            }
        }
        for (CALayer *layer in tmp) {
            [layer removeFromSuperlayer];
        }
    }
    
    CGFloat selW = self.bounds.size.width;
    CGFloat startCenterX = (selW-(PointCurrentWidth + (PointToPointGap+PointHeight)*(_points.count-1)))/2.f;
    CGFloat centY = self.bounds.size.height/2.f;
    for (int i = 0; i < _points.count; i++) {
        ACPointLayer *point = _points[i];
        if (_curr == i) {
            point.isCurrent = YES;
            startCenterX += PointCurrentWidth/2.f;
        }else {
            point.isCurrent = NO;
            startCenterX += PointHeight/2.f;
        }
        
        CGPoint cent = CGPointMake(startCenterX, centY);
        CGFloat width = point.frame.size.width;
        point.frame = CGRectMake(cent.x-width/2.0, cent.y-PointHeight/2.0, width, PointHeight);
        [self.layer addSublayer:point];
        
        startCenterX += PointToPointGap + width/2.0;
    }
}

- (void)setNum:(NSUInteger)num {
    _num = num;
    [self _initUI];
    [self updateUI];
}

- (void)setCurr:(NSUInteger)curr {
    _curr = curr;
    if (_curr > _points.count) {
        _curr = _points.count-1;
    }
    
    [self updateUI];
}


@end
