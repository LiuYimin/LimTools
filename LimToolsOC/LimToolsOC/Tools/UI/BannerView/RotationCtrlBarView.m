//
//  RotationCtrlBarView.m
//  PictureCircle
//
//  Created by Liu on 26/05/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "RotationCtrlBarView.h"

@interface RotationCtrlBarView ()

@property (nonatomic, strong) UILabel *textLab;

@end

@implementation RotationCtrlBarView

- (instancetype)init {
    return [super initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _numOfPoints = 0;
        _textLab = [[UILabel alloc] initWithFrame:self.bounds];
        _textLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:_textLab];
    }
    return self;
}

#pragma mark -- Update UI
- (void)updateUI {
    
}


#pragma mark -- Public
- (void)setNumOfPoints:(NSUInteger)numOfPoints {
    _numOfPoints = numOfPoints;
    _textLab.text = [NSString stringWithFormat:@"1/%lu", (unsigned long)_numOfPoints];
}

- (void)setCurrentNum:(NSUInteger)currentNum {
    _currentNum = currentNum;
    _textLab.text = [NSString stringWithFormat:@"%lu/%lu", (unsigned long)_currentNum, (unsigned long)_numOfPoints];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
