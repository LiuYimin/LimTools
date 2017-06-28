//
//  CALayer+Additions.m
//  LiMingApp
//
//  Created by Liu on 28/06/2017.
//  Copyright © 2017 lin dong. All rights reserved.
//

#import "CALayer+Additions.h"
#import <objc/runtime.h>

@implementation CALayer (Additions)
- (UIColor *)borderColorFromUIColor {
    
    return objc_getAssociatedObject(self, @selector(borderColorFromUIColor));
    
}

-(void)setBorderColorFromUIColor:(UIColor *)color

{
    
    objc_setAssociatedObject(self, @selector(borderColorFromUIColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setBorderColorFromUI:color];
    
}

- (void)setBorderColorFromUI:(UIColor *)color
{
    self.borderColor = color.CGColor;
    //    NSLog(@"%@", color);
    
}
@end
