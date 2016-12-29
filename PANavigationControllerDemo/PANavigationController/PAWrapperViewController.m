//
//  PAWrapperViewController.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 2016/12/21.
//  Copyright © 2016年 Yanming. All rights reserved.
//

#import "PAWrapperViewController.h"

@interface PAWrapperViewController ()

@end

@implementation PAWrapperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 确保使用者自定义的状态栏属性能挺过父子控制器正确传递
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.childViewControllers.lastObject;
}
@end
