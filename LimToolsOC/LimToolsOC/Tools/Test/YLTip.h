//
//  YLTip.h
//  LimToolsOC
//
//  Created by Liu on 20/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^YLTipCallBack)(BOOL cer);

@interface YLTip : NSObject

+ (void)showTipOnWindowTitle:(NSString *)titleMessage image:(NSString *)imageName callBack:(YLTipCallBack)callback;

+ (void)showTipOnView:(UIView *)view Title:(NSString *)titleMessage image:(NSString *)imageName callBack:(YLTipCallBack)callback;

@end
