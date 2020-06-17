//
//  SKHomePageViewController.m
//  MySeckillApp
//
//  Created by Liu Baoshuai on 2019/6/9.
//  Copyright © 2019 Liu Baoshuai. All rights reserved.
//

/*
 主页视图
 */


#define SKWeakSelf __weak typeof(self) weakSelf = self


#import "SKHomePageViewController.h"
#import "SKListCellView.h"



#import "SKListModel.h"

#import <AFNetworking.h>  // 3rd  A delightful networking framework
#import <MJRefresh.h>  //3rd  An easy way to use pull-to-refresh

@interface SKHomePageViewController ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation SKHomePageViewController

#pragma mark - getter
- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (AFHTTPSessionManager *) manager {
    if(!_manager){
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // test 1
    // test 2
    // test 3
    [self setUpNav];
    [self setUpRefresh];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SKListCellView class]) bundle: nil] forCellReuseIdentifier:@"123"];
}


/// 设置导航
- (void) setUpNav {
    UIButton *hotButton = [UIButton buttonWithType:UIButtonTypeCustom];  //自定义类型
    [hotButton setImage:[UIImage imageNamed:@"hot_icon"] forState:UIControlStateNormal];
    [hotButton sizeToFit];
    [hotButton addTarget:self action:@selector(hotBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hotButton];
    
}

/// 设置刷新
- (void) setUpRefresh {
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - loadData
- (void) loadData {
    SKWeakSelf;   //@TODO ???
    self.listArray = nil;
    [self.manager GET: @"http://guangdiu.com/api/getlist.php"
           parameters:nil
             progress:nil
              success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                  weakSelf.listArray = [SKListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                  [weakSelf.tableView reloadData];
                  [weakSelf.tableView.mj_header endRefreshing];
                  weakSelf.tableView.mj_footer =
                  [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
              }
              failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                  NSLog(@"%@", error);
              }];

    

}


- (void)loadMoreData
{
    SKWeakSelf;
    
    [self.manager GET:@"http://guangdiu.com/api/getlist.php"
           parameters:nil
             progress:nil
              success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                  [weakSelf.listArray
                   addObjectsFromArray:[GDListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
                  [weakSelf.tableView reloadData];
                  [weakSelf.tableView.mj_footer endRefreshing];
              }
              failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                  NSLog(@"%@", error);
              }];
}

- (void) hotBtnClick {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
