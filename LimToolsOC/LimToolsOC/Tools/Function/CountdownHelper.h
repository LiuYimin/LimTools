//
//  CountdownHelper.h
//  LiMingApp
//
//  Created by Liu on 28/06/2017.
//  Copyright © 2017 lin dong. All rights reserved.
//

#import <Foundation/Foundation.h>

//倒计时
@interface CountdownHelper : NSObject

@property (nonatomic, copy) void(^callbackCurrentSecond)(NSUInteger sec);

+ (instancetype)createCountdowner:(NSUInteger)totalSecond;
- (void)countdownStart;
- (void)countdownPause;
- (void)countdownReset;

@end
