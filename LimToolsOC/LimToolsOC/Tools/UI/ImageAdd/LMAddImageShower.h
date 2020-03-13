//
//  LMAddImageShower.h
//  ArtWorkCloud
//
//  Created by Liu on 22/08/2017.
//  Copyright © 2017 rvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMImageObject.h"
#import "LMAddImagePresentTransition.h"

@interface LMAddImageShower : UIView
@property (nonatomic, weak) UIViewController<UIViewControllerTransitioningDelegate> *ownerVC;//该控件所在的VC,需要用到该VC去跳转获取图片,Alert等窗口
@property (nonatomic, weak) LMAddImagePresentTransition *presenter;
@property (nonatomic, weak) LMAddImagePresentTransition *dismisser;

@property (nonatomic, assign) BOOL  hiddenAddImage;
@property (nonatomic, copy) void(^addImageCallBack)(void); //点击了添加图片,如果ownerVC不为空时,外界不要再跳转添加图片
@property (nonatomic, copy) void(^updateHeight)(CGFloat height);
@property (nonatomic, copy) void(^clickImageCallBack)(NSArray *imgs, NSInteger index);
@property (nonatomic, copy) void(^currentImages)(NSArray *imgs);

- (void)addImage:(LMImage *)image;
- (void)removeImage:(LMImage *)image;
@end
