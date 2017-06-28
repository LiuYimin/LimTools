//
//  YLSelectTimeView.h
//  LimToolsOC
//
//  Created by Liu on 21/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^YLSelectTimeViewCallBack)(BOOL cer, NSInteger time);

@interface YLSelectTimeView : NSObject

+ (void)showTimeViewCallBack:(YLSelectTimeViewCallBack)callBack;

@end
