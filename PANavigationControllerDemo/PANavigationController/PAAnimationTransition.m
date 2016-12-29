//
//  PAAnimationTransition.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 2016/12/21.
//  Copyright © 2016年 Yanming. All rights reserved.
//  thanks to onevcat(https://onevcat.com/2013/10/vc-transition-in-ios7/)

#import "PAAnimationTransition.h"
#import "UIViewController+PANavigationControllerCategory.h"

@interface PAAnimationTransition()
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, weak) UIViewController *presentingVC;

@end

@implementation PAAnimationTransition
-(void)wireToViewController:(UIViewController *)viewController
{
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
    
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    // 边缘滑动
    UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    edgePanGesture.edges = UIRectEdgeLeft;
    
    // 全屏滑动
    //    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:edgePanGesture];
}


- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    
    switch (gestureRecognizer.state) {
            
        case UIGestureRecognizerStateBegan:
            // Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            [self.presentingVC.pa_navigationController popViewControllerAnimated:YES];
            break;
            
        case UIGestureRecognizerStateChanged: {
            // Calculate the percentage of guesture
            CGFloat progress = translation.x / 375.0;
            
            // Limit it between 0 and 1
            progress = fminf(fmaxf(progress, 0.0), 1.0);
            self.shouldComplete = (progress > 0.5);
            [self updateInteractiveTransition:progress];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}


@end
