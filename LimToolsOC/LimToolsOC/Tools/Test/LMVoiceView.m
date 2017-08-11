//
//  LMVoiceView.m
//  LimToolsOC
//
//  Created by Liu on 20/07/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "LMVoiceView.h"

#define LMBackgroundImgName @"app_icon_mir"

@interface TY2View : UIView

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, assign) float value;

@end

@interface LMVoiceView ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) TY2View     *ty2View;
@end

@implementation LMVoiceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self _initUI];
    }
    return self;
}

- (void)_initUI
{
    _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backImageView.image = [UIImage imageNamed:LMBackgroundImgName];
    [self addSubview:_backImageView];
    
    _ty2View = [[TY2View alloc] initWithFrame:CGRectMake(0, 19.5, 16, 27)];
    [self addSubview:_ty2View];
    _ty2View.center = CGPointMake(self.bounds.size.width/2.f, _ty2View.center.y);
    _ty2View.value = 0.7;
}

@end

@implementation TY2View

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.width/2;
        self.backgroundColor = [UIColor greenColor];
        self.clipsToBounds = YES;
        
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_coverView];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _coverView.backgroundColor = self.superview.backgroundColor;
}

- (void)setValue:(float)value {
    _value = value;
    if (_value > 1) {
        _value = 1;
    }
    if (_value < 0) {
        _value = 0;
    }
    CGRect coverFrame = _coverView.frame;
    coverFrame.size.height = self.bounds.size.height * (1-_value);
    _coverView.frame = coverFrame;
}

@end
