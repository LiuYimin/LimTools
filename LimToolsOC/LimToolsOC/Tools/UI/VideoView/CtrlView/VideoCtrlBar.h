//
//  VideoCtrlBar.h
//  LimToolsOC
//
//  Created by Liu on 17/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCtrlBar : UIView

@property (nonatomic, assign) BOOL    play;

@property (nonatomic, assign) BOOL showBar;

/**进度条背景颜色*/
@property (nonatomic,strong) UIColor *progressBackgroundColor;
/**缓冲条缓冲进度颜色*/
@property (nonatomic,strong) UIColor *progressBufferColor;
/**进度条播放完成颜色*/
@property (nonatomic,strong) UIColor *progressPlayFinishColor;
//缓冲进度
@property (nonatomic, assign) float   bufferProgress;
//播放进度
@property (nonatomic, assign) float   playProgress;
//播放时间
@property (nonatomic, assign) uint    playSec;
//总播放时间
@property (nonatomic, assign) uint    totalTime;

@property (nonatomic, copy) void(^sliderBegin)();
@property (nonatomic, copy) uint(^sliderChanged)(float sliderValue);
@property (nonatomic, copy) void(^sliderEnd)();

@property (nonatomic, copy) void(^playOrPauseCallback)(BOOL play);
@property (nonatomic, copy) void(^fullScreenCallback)();

@end
