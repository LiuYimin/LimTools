//
//  ProgressBar.m
//  Unilever
//
//  Created by Liu on 05/09/2017.
//  Copyright © 2017 lin dong. All rights reserved.
//

#import "ProgressBar.h"

@interface ProgressBar ()
@property (nonatomic, assign) CGFloat sizeWidth;
@property (nonatomic, assign) float value;
@property (nonatomic, strong) UIColor *themeColor;
@end

@implementation ProgressBar
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)_initUI
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 20, 20);
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSizeWidth:(CGFloat)sizeWidth {
    _sizeWidth = sizeWidth;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _sizeWidth, _sizeWidth);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawCurve:UIGraphicsGetCurrentContext()];
}

- (void)drawCurve:(CGContextRef)context {
    CGFloat radius = _sizeWidth/2.f - 2;
    
    //以10为半径围绕圆心画指定角度扇形
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextMoveToPoint(context, _sizeWidth/2.f, _sizeWidth/2.f);
    CGContextAddArc(context, _sizeWidth/2.f, _sizeWidth/2.f, radius, -0.5 * M_PI, (2 * _value - 0.5) * M_PI, 0);//
    [self.themeColor setFill];
    CGContextDrawPath(context, kCGPathFill);
    
    //画圆
    const CGFloat *com = CGColorGetComponents(self.themeColor.CGColor);
    float red = com[0];
    float green = com[1];
    float blue = com[2];

    CGContextSetRGBStrokeColor(context,red,green,blue,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 1.7);//线的宽度
    CGContextAddArc(context, _sizeWidth/2.f, _sizeWidth/2.f, radius, 0, 2 * M_PI, 0);
    [[UIColor clearColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)setValue:(float)value {
    _value = value;
    [self setNeedsDisplay];
}


+ (ProgressBar *)createProgressBarWithPercent:(float)percent themeColor:(UIColor *)color size:(CGFloat)width;
{
    ProgressBar *p = [[ProgressBar alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    p.sizeWidth = width;
    p.themeColor = color;
    p.value = percent;
    return p;
}
@end
