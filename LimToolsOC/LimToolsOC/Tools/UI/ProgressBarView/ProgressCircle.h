//
//  ProgressCircle.h
//  Unilever
//
//  Created by Liu on 19/10/2017.
//  Copyright © 2017 lin dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressCircle : UIView
+ (ProgressCircle *)createProgressBarWithPercent:(float)percent themeColor:(UIColor *)color lineWidth:(CGFloat)lineWidth size:(CGFloat)width;
@end
