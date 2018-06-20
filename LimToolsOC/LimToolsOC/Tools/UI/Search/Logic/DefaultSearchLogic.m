//
//  DefaultSearchLogic.m
//  LimToolsOC
//
//  Created by Liu on 17/04/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import "DefaultSearchLogic.h"

@implementation DefaultSearchLogic

- (void)search:(NSString *)searchKey {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.searchResult?self.searchResult(@[@"a",@"3",@"df",@"aa",@"d"]):nil;
    });
}

@end
