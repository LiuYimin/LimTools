//
//  DefaultSearchUI.m
//  LimToolsOC
//
//  Created by Liu on 17/04/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import "DefaultSearchUI.h"

@interface DefaultSearchUI()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *searchTxtf;
@end
@implementation DefaultSearchUI

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)_initUI
{
    _searchTxtf = [UITextField new];
    _searchTxtf.placeholder = _placeholder;
    _searchTxtf.font = [UIFont systemFontOfSize:14];
    _searchTxtf.delegate = self;
    [self addSubview:_searchTxtf];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.returnBack?self.returnBack(textField.text):nil;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
