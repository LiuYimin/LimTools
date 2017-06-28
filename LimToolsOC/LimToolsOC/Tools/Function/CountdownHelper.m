//
//  CountdownHelper.m
//  LiMingApp
//
//  Created by Liu on 28/06/2017.
//  Copyright © 2017 lin dong. All rights reserved.
//

#import "CountdownHelper.h"

@interface CountdownHelper ()

@property (nonatomic, strong) NSTimer      *timer;
@property (nonatomic, assign) NSUInteger    totalSecond;
@property (nonatomic, assign) NSUInteger    currentSecond;

@end

@implementation CountdownHelper

- (instancetype)init {
    self = [super init];
    if (self) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countAction) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
        
    }
    return self;
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark -- Custom
- (void)countAction
{
    _currentSecond--;
    if (_currentSecond <= 0) {
        _currentSecond = 0;
        [self countdownPause];
    }
    
    if (self.callbackCurrentSecond) {
        self.callbackCurrentSecond(_currentSecond);
    }
}


#pragma mark -- Public
+ (instancetype)createCountdowner:(NSUInteger)totalSecond;
{
    CountdownHelper *cdhelper = [[CountdownHelper alloc] init];
    cdhelper.totalSecond = totalSecond;
    cdhelper.currentSecond = totalSecond;
    
    return cdhelper;
}
- (void)countdownStart;
{
    [_timer setFireDate:[NSDate date]];
}
- (void)countdownPause;
{
    [_timer setFireDate:[NSDate distantFuture]];
}
- (void)countdownReset;
{
    _currentSecond = _totalSecond;
}

@end
