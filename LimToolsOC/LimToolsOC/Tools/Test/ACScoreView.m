//
//  ACScoreView.m
//  LimToolsOC
//
//  Created by Liu on 18/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "ACScoreView.h"
#import "ScoreView.h"

@interface ACScoreView ()
@property (weak, nonatomic) IBOutlet UIView *containerV;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet ScoreView *scoreV;
@property (weak, nonatomic) IBOutlet UIButton *submitButt;

@end

@implementation ACScoreView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _initUI];
}

- (void)_initUI
{
    _containerV.layer.cornerRadius = 3;
    _containerV.layer.shadowOffset = CGSizeMake(1, 1);
    _containerV.layer.shadowColor = [UIColor blackColor].CGColor;
    _containerV.layer.shadowRadius = 2;
    
    _scoreV.maxScore = 10;
    _scoreV.scoreCallBack = ^(float score) {
        [self scoreChange:score];
    };
}

- (void)scoreChange:(float)score
{
    NSString *scoreStr = [NSString stringWithFormat:@"%.1f分", score];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:scoreStr attributes:nil];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(scoreStr.length-1, 1)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:27] range:NSMakeRange(0, scoreStr.length-1)];
    _scoreLab.attributedText = attributeString;
}

- (IBAction)onDismiss:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)onSubmit:(id)sender {
}



@end
