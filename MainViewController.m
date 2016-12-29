//
//  MainViewController.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 2016/12/21.
//  Copyright © 2016年 Yanming. All rights reserved.
//

#import "MainViewController.h"
#import "LeftOneTableViewController.h"
#import "RightoOneTableViewController.h"
#import "PANavigationViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // left
    LeftOneTableViewController *leftOneVC = [[LeftOneTableViewController alloc] init];
    leftOneVC.title = @"LEFT ONE";
    leftOneVC.tabBarItem.image = [UIImage imageNamed:@"calendar_normal"];
    leftOneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"calendar_selected"];
    PANavigationViewController *LeftPaNaviVC = [[PANavigationViewController alloc] init];
    [LeftPaNaviVC pa_setTintColor:[UIColor redColor] atIndexInStack:1];
    [LeftPaNaviVC pa_setBarTintColor:[UIColor grayColor]];
    [LeftPaNaviVC pa_setBarTintColor:[UIColor brownColor] atIndexInStack:1];
    [LeftPaNaviVC pushViewController:leftOneVC animated:YES];
    
    // right
    RightoOneTableViewController *rightOneVC = [[RightoOneTableViewController alloc] init];
    rightOneVC.title = @"RIGHT ONE";
    rightOneVC.tabBarItem.image = [UIImage imageNamed:@"calendar_normal"];
    rightOneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"calendar_selected"];

    PANavigationViewController *rightPaNaviVC = [[PANavigationViewController alloc] init];
    [rightPaNaviVC pa_setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor blackColor]}];
    [rightPaNaviVC pa_setTintColor:[UIColor whiteColor]];
    [rightPaNaviVC pa_setBarTintColor:[UIColor redColor] atIndexInStack:2];
    [rightPaNaviVC pa_setTintColor:[UIColor blackColor] atIndexInStack:1];
    [rightPaNaviVC pushViewController:rightOneVC animated:NO];
    
    self.viewControllers = @[LeftPaNaviVC, rightPaNaviVC];
    
}


@end
