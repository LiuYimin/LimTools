//
//  DefaultSearchUI.h
//  LimToolsOC
//
//  Created by Liu on 17/04/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultSearchUI : UIView
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) void(^returnBack)(NSString *key);
@end
