//
//  YLSelectView.h
//  LimToolsOC
//
//  Created by Liu on 21/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^YLSelectViewCallBack)(NSInteger index);

@interface YLSelectView : NSObject

+ (void)showTipOnView:(UIView *)view contents:(NSArray *)contents callBack:(YLSelectViewCallBack)callback;

@end
