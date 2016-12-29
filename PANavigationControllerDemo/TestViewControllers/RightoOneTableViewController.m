//
//  RightoOneTableViewController.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 2016/12/21.
//  Copyright © 2016年 Yanming. All rights reserved.
//

#import "RightoOneTableViewController.h"
#import "RightTwoViewController.h"
#import "UIViewController+PANavigationControllerCategory.h"
#import "UIView+YMEasyFrame.h"

@interface RightoOneTableViewController ()
@property (nonatomic, weak) UIImageView *headerBgVeiw;
@property (nonatomic, weak) UIView *naviBarBgView;
@property (nonatomic, weak) UIView *bottomSeperateLine;
@end

@implementation RightoOneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Right One";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_rightOne"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(nextButtonClicked)];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = YES;
    
    
    UIView *naviBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 64)];
    
    naviBarBgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [self.navigationController.navigationBar.subviews[0] addSubview:naviBarBgView];
    _naviBarBgView = naviBarBgView;
    
    UIView *bottomSeperateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, 375, 0.5)];
    bottomSeperateLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0];
//    [naviBarBgView addSubview:bottomSeperateLine];
//    _bottomSeperateLine = bottomSeperateLine;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 192)];
//    headerView.backgroundColor = CCLightGrayColor;
    self.tableView.tableHeaderView = headerView;
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    // bg
    UIImageView *headerBgVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, 375, 192 + 64)];
    headerBgVeiw.contentMode = UIViewContentModeScaleAspectFill;
    headerBgVeiw.clipsToBounds = YES;
    headerBgVeiw.image = [UIImage imageNamed:@"me_header_bg"];
    [headerView addSubview:headerBgVeiw];
    _headerBgVeiw = headerBgVeiw;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < -64) {
        _headerBgVeiw.ym_height = 256 + (- scrollView.contentOffset.y) - 64;
        _headerBgVeiw.ym_y = scrollView.contentOffset.y;
    }
    
    CGFloat delta = (offsetY - (-64))/(256 - 64);
    
    CGFloat validDelta = fmin(delta, 1);
    
    if (scrollView.contentOffset.y > -64) {
        
        _naviBarBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:validDelta];
        _bottomSeperateLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:validDelta];
    }
}
- (void)nextButtonClicked {
    RightTwoViewController *rightTwoVC = [[RightTwoViewController alloc] init];
    rightTwoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rightTwoVC animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self nextButtonClicked];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_rightOne" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行", indexPath.row + 1];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"第 %ld 行", indexPath.row + 1];
    return cell;
}

@end
