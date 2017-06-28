//
//  ScoreView.m
//  LimToolsOC
//
//  Created by Liu on 22/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "ScoreView.h"

@interface ScoreView ()
{
    CGFloat  _starWidth;
}
@property (nonatomic, strong) UIImageView *grayImv;
@property (nonatomic, strong) UIView      *starContainerV;
@property (nonatomic, strong) UIImageView *starImv;
@end

@implementation ScoreView

+ (instancetype)scoreViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
        [self addGes];
    }
    return self;
}

- (void)_initUI
{
    _grayImv = [[UIImageView alloc] initWithFrame:self.bounds];
    _grayImv.image = [UIImage imageNamed:@"五星_gray"];
    
    _starContainerV = [[UIView alloc] initWithFrame:self.bounds];
    _starContainerV.clipsToBounds = YES;
    _starImv = [[UIImageView alloc] initWithFrame:_starContainerV.bounds];
    _starImv.image = [UIImage imageNamed:@"五星"];
    _starWidth = CGRectGetWidth(_starImv.frame)/5.0;
    
    [_starContainerV addSubview:_starImv];
    [self addSubview:_grayImv];
    [self addSubview:_starContainerV];
}

- (void)addGes
{
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:ges];
}


- (void)setScore:(float)score
{
    _score = score;
    if (_score < 0) {
        _score = 0;
    }
    if (_score > 5) {
        _score = 5;
    }
    
    [self changeUIWithScore:score/5.0];
}


- (void)changeUIWithScore:(float)rate
{
    CGRect frame = _starContainerV.frame;
    frame.size.width = _grayImv.frame.size.width * rate;
    _starContainerV.frame = frame;
}

- (void)tapAction:(UITapGestureRecognizer *)ges
{
    CGPoint lp = [ges locationInView:self];
    float scrore = lp.x/_starWidth;
    self.score = scrore;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
