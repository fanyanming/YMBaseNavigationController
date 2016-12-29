//
//  PANormalDismissAnimationTransition.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 2016/12/22.
//  Copyright © 2016年 Yanming. All rights reserved.
//  thanks to onevcat(https://onevcat.com/2013/10/vc-transition-in-ios7/)

#define ScreenBounds [[UIScreen mainScreen] bounds]
#define ScreenH [[UIScreen mainScreen] bounds].size.height
#define ScreenW [[UIScreen mainScreen] bounds].size.width
#import "PANormalDismissAnimationTransition.h"

@implementation PANormalDismissAnimationTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // Get controllers from transition context

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 底部TabBar
    UITabBar *tabBar = toVC.tabBarController.tabBar;
    
    CGRect fromTo = CGRectMake(ScreenW, 0, ScreenW, ScreenH);
    CGRect toTo = CGRectMake(-ScreenW, 0, ScreenW, ScreenH);
    toVC.view.frame = toTo;
    tabBar.frame = CGRectMake(-ScreenW, ScreenH - 49, ScreenW, 49);

    // Add target view to the container
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];

    // animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = fromTo;
        toVC.view.frame = CGRectMake(0, 0, ScreenW, ScreenH);
        tabBar.frame = CGRectMake(0, ScreenH - 49, ScreenW, 49);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
