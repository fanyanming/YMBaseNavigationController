//
//  RightTwoViewController.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 2016/12/21.
//  Copyright © 2016年 Yanming. All rights reserved.
//

#import "RightTwoViewController.h"
#import "UIViewController+PANavigationControllerCategory.h"
#import "RightThreeTableViewController.h"

@interface RightTwoViewController ()

@end

@implementation RightTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    self.title = @"Right Two";
//    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(backButtonClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(nextButtonClicked)];

//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}
- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)nextButtonClicked {
    RightThreeTableViewController *threeVC = [[RightThreeTableViewController alloc] init];
    [self.navigationController pushViewController:threeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
