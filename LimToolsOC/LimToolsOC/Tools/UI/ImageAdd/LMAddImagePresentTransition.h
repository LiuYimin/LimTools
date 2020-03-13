//
//  LMAddImagePresentTransition.h
//  LimToolsOC
//
//  Created by Liu on 2018/7/6.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LMAddImagePresentTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, assign, getter=present) BOOL   isPresent;
@end
