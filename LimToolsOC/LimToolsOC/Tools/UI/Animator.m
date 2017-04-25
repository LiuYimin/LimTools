//
//  Animator.m
//  PresentCustomDemo
//
//  Created by Liu on 24/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "Animator.h"

@implementation Animator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;//动画时间
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
        
        [UIView animateWithDuration:1 animations:^{
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
        [UIView animateWithDuration:1 animations:^{
            fromView.transform = CGAffineTransformMakeScale(xScale, yScale);
            fromView.center = CGPointMake(CGRectGetMidX(_originFrame), CGRectGetMidY(_originFrame));
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
