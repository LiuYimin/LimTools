//
//  ProgressBar.h
//  Unilever
//
//  Created by Liu on 05/09/2017.
//  Copyright © 2017 lin dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressBar : UIView
+ (ProgressBar *)createProgressBarWithPercent:(float)percent themeColor:(UIColor *)color size:(CGFloat)width;
@end
