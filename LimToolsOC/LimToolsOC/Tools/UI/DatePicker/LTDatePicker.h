//
//  LTDatePicker.h
//  LimToolsOC
//
//  Created by Liu on 30/01/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTDatePicker : NSObject
+ (void)showCallBack:(void(^)(NSDate *date))selectedCallBack;
@end
