//
//  YLAlbumVC.h
//  LimToolsOC
//
//  Created by Liu on 21/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YLAlbumDelegate <NSObject>

@optional
- (void)yl_albumChooseImage:(UIImage *)image;

@end

@interface YLAlbumVC : UIViewController

//一行有多少张图片,默认是4
@property (nonatomic, assign) NSUInteger rowNum;

@property (nonatomic, weak) id<YLAlbumDelegate> delegate;

@end
