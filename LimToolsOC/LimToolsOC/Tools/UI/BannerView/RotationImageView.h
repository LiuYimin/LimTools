//
//  RotationImageView.h
//  PictureCircle
//
//  Created by Liu on 26/05/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

//

#import <UIKit/UIKit.h>

@interface RotationImageView : UIView

@property (nonatomic, assign) BOOL cycleScroll;//循环滚动,默认为NO
@property (nonatomic, copy) void(^tapCallBack)(NSUInteger index);

- (void)configImgs:(NSArray <NSString *> *)imgs;

@end
