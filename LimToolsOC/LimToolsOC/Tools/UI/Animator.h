//
//  Animator.h
//  PresentCustomDemo
//
//  Created by Liu on 24/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//present 自定义 动画 

@interface Animator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, assign, getter=present) BOOL   isPresent;

@end
