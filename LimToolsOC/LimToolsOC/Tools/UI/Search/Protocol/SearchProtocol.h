//
//  SearchProtocol.h
//  LimToolsOC
//
//  Created by Liu on 17/04/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchProtocol <NSObject>

@required
- (void)search:(NSString *)searchKey;

@end
