//
//  ScoreView.h
//  LimToolsOC
//
//  Created by Liu on 22/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreView : UIView

+ (instancetype)scoreViewWithFrame:(CGRect)frame;

@property (nonatomic, assign) float  maxScore;

@property (nonatomic, assign) float  score;//0 ~ 5

@property (nonatomic, copy) void(^scoreCallBack)(float score);

@end
