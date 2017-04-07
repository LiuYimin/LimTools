//
//  NSString+Valid.h
//  LimToolsOC
//
//  Created by Liu on 07/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Valid)

- (BOOL)valid;//为nil则为无效
- (BOOL)emailValid;//是否是邮箱格式
- (BOOL)telphoneValid;//是否是电话号码
- (BOOL)mobileValid;//是否是手机号码
- (BOOL)cardNumberValid;//是否是车牌号
- (BOOL)cardTypeValid;//车型验证
- (BOOL)identityCardValid;//身份证验证

@end
