//
//  LMImageObject.h
//  LimToolsOC
//
//  Created by Liu on 2018/7/6.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define __kWidth [UIScreen mainScreen].bounds.size.width
#define __kHeight [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b)          [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r,g,b,a)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define CRGB(r,g,b)         RGB(r,g,b).CGColor
#define CRGBA(r,g,b,a)      RGBA(r,g,b,a).CGColor
#define RGBS(s)             RGB(s,s,s)
#define __kWindow           [UIApplication sharedApplication].delegate.window

@interface LMImage : NSObject
@property (nonatomic, strong) UIImage  *originalImage;
@property (nonatomic, copy)   NSString *netUrl;
@property (nonatomic, copy)   NSString *serverFilePath;
@end

