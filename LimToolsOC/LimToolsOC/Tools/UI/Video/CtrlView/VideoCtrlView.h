//
//  VideoCtrlView.h
//  LimToolsOC
//
//  Created by Liu on 17/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCtrlView : UIView
@property (nonatomic, copy) void(^sliderBegin)();
@property (nonatomic, copy) uint(^sliderChanged)(float sliderValue);
@property (nonatomic, copy) void(^sliderEnd)();

@property (nonatomic, copy) void(^playOrPauseCallback)(BOOL play);
@property (nonatomic, copy) void(^fullScreenCallback)();

- (void)changeBufferValue:(float)percent;
- (void)changePlayPercent:(float)percent sececond:(uint)sec;
- (void)configTotalPlayTime:(uint)total;
- (void)showLoadingAnimate:(BOOL)show;
@end
