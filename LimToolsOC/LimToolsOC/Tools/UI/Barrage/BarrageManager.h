//
//  BarrageManager.h
//  LimToolsOC
//
//  Created by Liu on 29/01/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BarrageManager : NSObject
/**初始化控制类*/
+ (instancetype)createBarrageManager;
/**初始化容器*/
- (void)configContainerView:(UIView *)containerView;
/**初始化弹幕内容*/
- (void)configBarrages:(NSArray <NSString *> *)defaultBarrages;
/**动态添加弹幕内容*/
- (void)addBarrage:(NSString *)newBarrage;
/**开启弹幕*/
- (void)startBarrage;
/**关闭弹幕*/
- (void)stopBarrage;
///**暂停弹幕*/
//- (void)pauseBarrage;
/**设置弹幕文字属性*/
- (void)configTextAttributes:(NSDictionary *)dict;
@end
