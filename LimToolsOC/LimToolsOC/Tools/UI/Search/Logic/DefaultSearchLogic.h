//
//  DefaultSearchLogic.h
//  LimToolsOC
//
//  Created by Liu on 17/04/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchProtocol.h"

@interface DefaultSearchLogic : NSObject<SearchProtocol>
@property (nonatomic, copy) void(^searchResult)(id obj);
@end
