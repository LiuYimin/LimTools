//
//  ProgressCircle.m
//  Unilever
//
//  Created by Liu on 19/10/2017.
//  Copyright © 2017 lin dong. All rights reserved.
//

#import "ProgressCircle.h"

@interface ProgressCircle()
@property (nonatomic, assign) CGFloat sizeWidth;
@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, assign) float value;
@property (nonatomic, assign) float lineWidth;
@end
@implementation ProgressCircle
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
    self.lineWidth = 2;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 20, 20);
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawCurve:UIGraphicsGetCurrentContext()];
}

- (void)drawCurve:(CGContextRef)context {
    CGFloat radius = _sizeWidth/2.f - 5;
    
    CGContextSetLineCap(context, kCGLineCapButt);
    
    //画背景圆
    CGContextSetRGBStrokeColor(context,0xE6/255.0,0xE6/255.0,0xE6/255.0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, _lineWidth);//线的宽度
    CGContextAddArc(context, _sizeWidth/2.f, _sizeWidth/2.f, radius, 0, 2 * M_PI, 0);
    [[UIColor clearColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);

    CGFloat red, green, blue, a;
    [self.themeColor getRed:&red green:&green blue:&blue alpha:&a];
    CGContextSetRGBStrokeColor(context, red, green, blue, a);//画笔线的颜色
    CGContextSetLineWidth(context, _lineWidth);//线的宽度
    CGContextAddArc(context, _sizeWidth/2.f, _sizeWidth/2.f, radius, 0, 2 * M_PI * _value, 1);
    [[UIColor clearColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
}

- (void)setValue:(float)value {
    _value = value;
    [self setNeedsDisplay];
}

+ (ProgressCircle *)createProgressBarWithPercent:(float)percent themeColor:(UIColor *)color lineWidth:(CGFloat)lineWidth size:(CGFloat)width;
{
    ProgressCircle *p = [[ProgressCircle alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    p.sizeWidth = width;
    p.themeColor = color;
    p.lineWidth = lineWidth;
    p.value = percent;

    return p;
}


@end
