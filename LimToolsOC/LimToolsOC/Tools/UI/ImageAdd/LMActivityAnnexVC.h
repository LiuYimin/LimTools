//
//  LMActivityAnnexVC.h
//  ArtWorkCloud
//
//  Created by Liu on 22/08/2017.
//  Copyright © 2017 rvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMImageObject.h"

@interface LMActivityAnnexVC : UIViewController
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray<LMImage *> *imgArray;
@property (nonatomic, copy) void(^deleteImageCallBack)(LMImage *img);
@property (nonatomic, assign) BOOL   singleTapClose;//点击消失;
@end
