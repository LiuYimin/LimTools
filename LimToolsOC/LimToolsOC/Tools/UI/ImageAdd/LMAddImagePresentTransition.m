//
//  LMAddImagePresentTransition.m
//  LimToolsOC
//
//  Created by Liu on 2018/7/6.
//  Copyright © 2018 Liu. All rights reserved.
//

#import "LMAddImagePresentTransition.h"

const CGFloat durationTime = 0.5;

@implementation LMAddImagePresentTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return durationTime;//动画时间
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    if (self.present) {
        CGRect finalFrame = toView.frame;
        CGFloat xScale = _originFrame.size.width/finalFrame.size.width;
        CGFloat yScale = _originFrame.size.height/finalFrame.size.height;
        toView.transform = CGAffineTransformMakeScale(xScale, yScale);
        toView.center = CGPointMake(CGRectGetMidX(_originFrame), CGRectGetMidY(_originFrame));
        
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:durationTime animations:^{
            toView.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else {
        CGFloat xScale = _originFrame.size.width/fromView.frame.size.width;
        CGFloat yScale = _originFrame.size.height/fromView.frame.size.height;
        [containerView addSubview:toView];
        [containerView bringSubviewToFront:fromView];
        [UIView animateWithDuration:durationTime animations:^{
            fromView.transform = CGAffineTransformMakeScale(xScale, yScale);
            fromView.center = CGPointMake(CGRectGetMidX(_originFrame), CGRectGetMidY(_originFrame));
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
//    return 0.8;
//}
//
//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    UIView *containerView = [transitionContext containerView];
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//
//    fromView.frame = CGRectMake(0, CGRectGetMinY(toView.frame), screenSize.width, CGRectGetHeight(toView.frame));
//    [containerView addSubview:toView];
//
//    [containerView bringSubviewToFront:fromView];
//
//    [UIView animateWithDuration:0.8 animations:^{
//        fromView.frame = CGRectMake(CGRectGetMaxX(toView.frame), CGRectGetMinY(toView.frame), screenSize.width, CGRectGetHeight(toView.frame));
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
//}



//// 返回动画的时间
//- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
//    return 0.8;
//}
//- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView * container = [transitionContext containerView];
//
//    [container addSubview:toVC.view];
//    [container bringSubviewToFront:fromVC.view];
//
//    // 改变m34
//    CATransform3D transfrom = CATransform3DIdentity;
//    transfrom.m34 = -0.002;
//    container.layer.sublayerTransform = transfrom;
//
//    // 设置archPoint和position
//    CGRect initalFrame = [transitionContext initialFrameForViewController:fromVC];
//    toVC.view.frame = initalFrame;
//    fromVC.view.frame = initalFrame;
//    fromVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
//    fromVC.view.layer.position = CGPointMake(0, initalFrame.size.height / 2.0);
//
//    // 添加阴影效果
//    CAGradientLayer * shadowLayer = [[CAGradientLayer alloc] init];
//    shadowLayer.colors =@[
//                          [UIColor colorWithWhite:0 alpha:1],
//                          [UIColor colorWithWhite:0 alpha:0.5],
//                          [UIColor colorWithWhite:1 alpha:0.5]
//                          ];
//    shadowLayer.startPoint = CGPointMake(0, 0.5);
//    shadowLayer.endPoint = CGPointMake(1, 0.5);
//    shadowLayer.frame = initalFrame;
//
//    UIView * shadow = [[UIView alloc] initWithFrame:initalFrame];
//    shadow.backgroundColor = [UIColor clearColor];
//    [shadow.layer addSublayer:shadowLayer];
//    [fromVC.view addSubview:shadow];
//    shadow.alpha = 0;
//
//    // 动画
//    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:2 animations:^{
//        fromVC.view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
//        shadow.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
//        fromVC.view.layer.position = CGPointMake(CGRectGetMidX(initalFrame), CGRectGetMidY(initalFrame));
//        fromVC.view.layer.transform = CATransform3DIdentity;
//        [shadow removeFromSuperview];
//
//        [transitionContext completeTransition:YES];
//    }];
//}

@end
