//
//  VideoCtrlView.h
//  LimToolsOC
//
//  Created by Liu on 17/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCtrlView : UIView
@property (nonatomic, assign) BOOL isFullScreen;//是否是全屏,如果是全屏的话,topBar会显示
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *coverUrl;

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
