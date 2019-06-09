//
//  SKBaseTableViewController.m
//  MySeckillApp
//
//  Created by Liu Baoshuai on 2019/6/9.
//  Copyright © 2019 Liu Baoshuai. All rights reserved.
//

#import "SKBaseTableViewController.h"

@interface SKBaseTableViewController ()

@end

@implementation SKBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];  //Footer 视图
}



@end
