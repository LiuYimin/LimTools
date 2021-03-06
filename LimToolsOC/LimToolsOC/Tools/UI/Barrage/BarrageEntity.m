//
//  BarrageEntity.m
//  LimToolsOC
//
//  Created by Liu on 29/01/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import "BarrageEntity.h"
#import "BarrageLayer.h"

@interface BarrageEntity()<CAAnimationDelegate>
@property (nonatomic, strong) BarrageLayer *textLayer;
@property (nonatomic, assign) BarrageEntityState state;
@property (nonatomic, copy) void (^endOverCallback)(BarrageEntityState);
@end
@implementation BarrageEntity
- (instancetype)init {
    self = [super init];
    if (self) {
        _textLayer = [BarrageLayer layer];
        _textLayer.foregroundColor = [UIColor redColor].CGColor;
        _textLayer.fontSize = 15;
    }
    return self;
}

#pragma mark -- Tool
- (CGFloat)calculateTextLength:(NSString *)string
{
    CGFloat length = 0;
    CGSize size = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 25) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    length = size.width+10;
    return length;
}

#pragma mark -- Public
- (void)startDriftOver:(void (^)(BarrageEntityState))endOverCallback
{
    _endOverCallback = endOverCallback;
    if (!_fatherLayer) {
        self.state = BarrageEntityState_Out;
        if (endOverCallback) endOverCallback(self.state);
        [self stop];
        return;
    }
    [_fatherLayer addSublayer:_textLayer];
    CGFloat maxZPosition = 0;
    for (CALayer *sub in _fatherLayer.sublayers) {
        maxZPosition = maxZPosition>sub.zPosition?maxZPosition:sub.zPosition;
    }
    _textLayer.zPosition = maxZPosition+1;
    
    CGFloat duration = ((_fatherLayer.bounds.size.width+_textLayer.bounds.size.width)/_textLayer.bounds.size.width)*1.5;
    if (duration > 5) {
        duration = 5;
    }
    CGFloat enterDuration = (_textLayer.bounds.size.width/_fatherLayer.bounds.size.width)*duration;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = BarrageEntityState_Enter;
        if (endOverCallback) endOverCallback(self.state);
    });
    
    CGPoint position = _textLayer.position;
    position.x = -_textLayer.bounds.size.width/2.f;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position";
    animation.toValue = [NSValue valueWithCGPoint:position];
    animation.duration = duration;
    animation.delegate = self;
    [_textLayer addAnimation:animation forKey:nil];
}

- (void)stop
{
    [_textLayer removeFromSuperlayer];
}

- (void)pause
{
    CFTimeInterval pausedTime = [_textLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    _textLayer.timeOffset = pausedTime;
    _textLayer.speed = 0.0;
}

- (void)configTextAttributes:(NSDictionary *)dict
{
    if ([dict.allKeys containsObject:NSFontAttributeName]) {
        UIFont *font = dict[NSFontAttributeName];
        _textLayer.font = (__bridge CFTypeRef _Nullable)(font.fontName);
        _textLayer.fontSize = font.pointSize;
    }
    if ([dict.allKeys containsObject:NSForegroundColorAttributeName]) {
        UIColor *color = dict[NSForegroundColorAttributeName];
        _textLayer.foregroundColor = color.CGColor;
    }
}

- (void)setFatherLayer:(CALayer *)fatherLayer {
    _fatherLayer = fatherLayer;
    if (_contentString) {
        _textLayer.frame = CGRectMake(_fatherLayer.bounds.size.width, _centerY, [self calculateTextLength:_contentString], 25);
    }
}

- (void)setCenterY:(CGFloat)centerY {
    _centerY = centerY;
    if (_fatherLayer && _contentString) {
        _textLayer.frame = CGRectMake(_fatherLayer.bounds.size.width, _centerY-7.5, [self calculateTextLength:_contentString], 25);
    }
}

- (void)setContentString:(NSString *)contentString {
    _contentString = contentString;
    _textLayer.string = _contentString;
    if (_fatherLayer) {
        _textLayer.frame = CGRectMake(_fatherLayer.bounds.size.width, _centerY, [self calculateTextLength:_contentString], 25);
    }
}

#pragma mark -- CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.state = BarrageEntityState_Out;
    if (self.endOverCallback) self.endOverCallback(self.state);
    [self stop];
}
@end
