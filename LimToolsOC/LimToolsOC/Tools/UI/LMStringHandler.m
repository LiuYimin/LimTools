//
//  LMStringHandler.m
//  LimToolsOC
//
//  Created by Liu on 2018/9/17.
//  Copyright © 2018 Liu. All rights reserved.
//

#import "LMStringHandler.h"

@implementation LMStringHandler
- (BOOL)compareString:(NSString *)txt1 compare:(NSString *)txt2 {
    BOOL ret = NO;
    NSInteger len1 = txt1.length;
    NSInteger len2 = txt2.length;
    NSInteger minLen = (len1>len2?len2:len1);
    
    for (int i=0; i<minLen; i++) {
        unichar c1 = [txt1 characterAtIndex:i];
        unichar c2 = [txt2 characterAtIndex:i];
        NSLog(@"%c, %c", c1, c2);
        NSLog(@"%d, %d", c1, c2);
        
        if (c1 > c2) {
            ret = YES;
            break;
        }else if (c1 < c2) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}

- (BOOL)judgementNum:(unichar)c
{
    if (c >= 48 && c <= 58) {
        return YES;
    }
    return NO;
}


@end
