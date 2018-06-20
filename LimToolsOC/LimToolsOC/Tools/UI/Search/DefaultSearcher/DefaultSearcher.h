//
//  DefaultSearcher.h
//  LimToolsOC
//
//  Created by Liu on 17/04/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DefaultSearcher : NSObject
@property (nonatomic, copy) void(^searchResult)(id obj);
@property (nonatomic, assign) CGRect frame;
@end
