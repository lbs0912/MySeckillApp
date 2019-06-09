//
//  SKTabBarViewController.m
//  MySeckillApp
//
//  Created by Liu Baoshuai on 2019/6/9.
//  Copyright © 2019 Liu Baoshuai. All rights reserved.
//

#import "SKTabBarController.h"
#import "SKNavigationController.h"  //顶部导航栏 Navigation
#import "SKHomePageViewController.h"  //首页

@interface SKTabBarController ()

@end

@implementation SKTabBarController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建子控制器
    [self setUpChildViewController];
}


#pragma mark - 创建子控制器
- (void) setUpChildViewController {
    //首页
    [self setUpOneChildViewController:[[SKHomePageViewController alloc] init]
                                Title:@"首页"
                             TabImage:@"tabicon_home"
                             NavImage:@"navtitle_home"];
    //首页
    [self setUpOneChildViewController:[[SKHomePageViewController alloc] init]
                                Title:@"首页"
                             TabImage:@"tabicon_home"
                             NavImage:@"navtitle_home"];
    //首页
    [self setUpOneChildViewController:[[SKHomePageViewController alloc] init]
                                Title:@"首页"
                             TabImage:@"tabicon_home"
                             NavImage:@"navtitle_home"];
}


#pragma mark - 创建单个子控制器
- (void) setUpOneChildViewController:(UIViewController *) vc
                               Title:(NSString *) title                            TabImage:(NSString *) tabImage
                            NavImage:(NSString *) navImage
{
    SKNavigationController *navVC = [[SKNavigationController alloc] initWithRootViewController:vc];
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:tabImage];
    UIImageView *navImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:navImage]];
    vc.navigationItem.titleView = navImageView;
    [self addChildViewController:navVC];  //添加顶部导航视图控制器
}


@end
