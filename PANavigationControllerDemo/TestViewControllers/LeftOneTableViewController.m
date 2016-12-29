//
//  LeftOneTableViewController.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 2016/12/21.
//  Copyright © 2016年 Yanming. All rights reserved.
//

#import "LeftOneTableViewController.h"
#import "LeftTwoViewController.h"

@interface LeftOneTableViewController ()

@end

@implementation LeftOneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"Left One";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_leftOne"];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(nextButtonClicked)];
    
    NSDictionary *attrDict = @{NSForegroundColorAttributeName:[UIColor blueColor], NSFontAttributeName: [UIFont systemFontOfSize:18]};
    [self.navigationController.navigationBar setTitleTextAttributes:attrDict];

}

- (void)nextButtonClicked {
    LeftTwoViewController *leftTwoVC = [[LeftTwoViewController alloc] init];
    leftTwoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:leftTwoVC animated:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_leftOne" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行", indexPath.row + 1];
    return cell;
}


@end
