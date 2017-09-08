//
//  VideoTopBar.m
//  ArtWorkCloud
//
//  Created by Liu on 18/08/2017.
//  Copyright © 2017 rvision. All rights reserved.
//

#import "VideoTopBar.h"

@interface VideoTopBar ()

@property (nonatomic, strong) UIButton *backButt;
@property (nonatomic, strong) UILabel  *titleLab;

@end

@implementation VideoTopBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)_initUI
{
    self.backgroundColor = [UIColor blackColor];
    _backButt = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButt.frame = CGRectMake(0, 20, 44, 44);
    [_backButt addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButt];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.frame = CGRectMake(CGRectGetMaxX(_backButt.frame)+3, 34, [UIScreen mainScreen].bounds.size.height, 16);
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textColor = [UIColor whiteColor];
}

- (void)onBack
{
    if (self.backCall) self.backCall();
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLab.text = _title;
}

- (void)setShowBar:(BOOL)showBar {
    _showBar = showBar;
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.1];
    self.alpha = _showBar?1:0;
    [UIView commitAnimations];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
