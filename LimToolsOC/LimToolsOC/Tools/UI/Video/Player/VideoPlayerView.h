//
//  VideoPlayerView.h
//  PlayerVideoDemo
//
//  Created by LiuYimin on 16/4/5.
//  Copyright © 2016年 LiuYimin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerView : UIView
/** 静音（默认为NO）*/
@property (nonatomic, assign) BOOL           mute;
@property (nonatomic, strong) NSURL         *playUrl;
@property (nonatomic, assign) float          sliderValue;
@property (nonatomic, assign) uint           sliderSec;
@property (nonatomic, assign) uint           sliderTotal;

//将缓存进度报出去
@property (nonatomic, copy) void(^bufferCallback)(float progressValue);
@property (nonatomic, copy) void(^bufferingLoading)(BOOL buffer);

- (void)playVideo;
- (void)pauseVideo;
//计算百分之多少时,对应的时间是多少,并将player设定到该时间
- (uint)moveToTimeWithPercent:(float)proportion;

@end
