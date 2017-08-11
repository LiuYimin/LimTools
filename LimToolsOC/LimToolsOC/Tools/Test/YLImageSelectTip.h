//
//  YLImageSelectTip.h
//  LimToolsOC
//
//  Created by Liu on 29/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^YLImageSelectTipCallBack)(NSUInteger index);

@interface YLImageSelectTip : NSObject
+ (void)showImageSelectCallBack:(YLImageSelectTipCallBack)callback;
@end
