//
//  CALayer+Additions.h
//  LiMingApp
//
//  Created by Liu on 28/06/2017.
//  Copyright © 2017 lin dong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/QuartzCore.h>

@interface CALayer (Additions)
@property(nonatomic, strong) UIColor *borderColorFromUIColor;
- (void)setBorderColorFromUIColor:(UIColor *)color;
@end
