//
//  NSString+Encryption.h
//  LimToolsOC
//
//  Created by Liu on 07/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)

- (NSString *)md5;

- (NSString *)base64Encode;

- (NSString *)base64Decode;

- (NSString*)sha1;

@end
