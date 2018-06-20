//
//  DefaultSearcher.m
//  LimToolsOC
//
//  Created by Liu on 17/04/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import "DefaultSearcher.h"
#import "DefaultSearchUI.h"
#import "DefaultSearchLogic.h"

@interface DefaultSearcher()
@property (nonatomic, strong) DefaultSearchUI *ui;
@property (nonatomic, strong) DefaultSearchLogic *logic;
@end
@implementation DefaultSearcher
- (instancetype)init {
    self = [super init];
    if (self) {
        
        __weak DefaultSearcher *safeSelf = self;
        self.ui.returnBack = ^(NSString *key) {
            [safeSelf.logic search:key];
        };
        self.logic.searchResult = ^(id obj) {
            
        };
    }
    return self;
}


- (void)setFrame:(CGRect)frame {
    _frame = frame;
    self.ui.frame = frame;
}


#pragma mark -- Getter && Setter
- (DefaultSearchUI *)ui {
    if (!_ui) {
        _ui = [DefaultSearchUI new];
        _ui.placeholder = @"Search Sth";
    }
    return _ui;
}

- (DefaultSearchLogic *)logic {
    if (!_logic) {
        _logic = [DefaultSearchLogic new];
    }
    return  _logic;
}


@end
