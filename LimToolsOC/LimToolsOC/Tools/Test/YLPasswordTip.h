//
//  YLPasswordTip.h
//  LimToolsOC
//
//  Created by Liu on 21/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^YLPasswordTipCallBack)(BOOL cer, NSString *psd);

@interface YLPasswordTip : NSObject

+ (void)showTipOnWindowTitle:(NSString *)titleMessage callBack:(YLPasswordTipCallBack)callback;

+ (void)showTipOnView:(UIView *)view Title:(NSString *)titleMessage callBack:(YLPasswordTipCallBack)callback;

@end
