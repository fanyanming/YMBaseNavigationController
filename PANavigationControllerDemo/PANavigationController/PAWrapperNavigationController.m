//
//  PAWrapperNavigationController.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 16/12/20.
//  Copyright © 2016年 Yanming. All rights reserved.
//

#import "PAWrapperNavigationController.h"
#import "UIViewController+PANavigationControllerCategory.h"

@interface PAWrapperNavigationController ()

@end

@implementation PAWrapperNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
}

// 截取用户的push 和 pop 动作 ,传递给根navigationController来执行
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 0) {
        [super pushViewController:viewController animated:YES];
        return;
    }
    [self.pa_navigationController pushViewController:viewController animated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
//    self.viewControllers.firstObject.hidesBottomBarWhenPushed = NO;

    [self.pa_navigationController popViewControllerAnimated:YES];
    return nil;
}

#pragma mark - 确保使用者自定义的状态栏属性能挺过父子控制器正确传递
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    [self.pa_navigationController popToRootViewControllerAnimated:YES];
    return nil;
}

@end
