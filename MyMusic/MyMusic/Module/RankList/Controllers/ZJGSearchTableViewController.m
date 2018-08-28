//
//  ZJGSearchTableViewController.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/18.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGSearchTableViewController.h"
#import "ZJGCellHeaderView.h"
#import "ZJGSearchReferralTableViewController.h"
#import "JCTagListView.h"
#import "ZJGSearchResultViewController.h"

@interface ZJGSearchTableViewController ()<UISearchBarDelegate,CellHeaderViewDelegate>
/** 搜索栏 */
@property (nonatomic, strong ) UISearchBar *searchBar;
/** 热门搜索数组 */
@property (nonatomic, strong ) NSMutableArray *hotSearchArrayM;
/** 搜索历史数组 */
@property (nonatomic, strong ) NSArray *historyArray;
@end

@implementation ZJGSearchTableViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hotSearchArrayM = [NSMutableArray array];
    self.historyArray = [NSArray array];
    [self readUserSearchDefaults];
    [self loadHotSearchData];
}
- (void)readUserSearchDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults arrayForKey:@"history"];
    self.historyArray = array;
    [self.tableView reloadData];
}
- (void)deleteSearchHistory {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"history"];
    [userDefaults synchronize];
}
- (void)loadHotSearchData {
    [ZJGNetWorkTool netWorkToolGetWithUrl:ZJGUrl parameters:ZJGParams(@"method":@"baidu.ting.search.hot",@"page_num":@"15") response:^(id response) {
        for (NSDictionary *dict in response[@"result"]) {
            [self.hotSearchArrayM addObject:dict[@"word"]];
        }
        ZJGLog(@"下载完成");
        [self.tableView reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setUpSearchBar];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)setUpSearchBar {
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;//凸出的
    self.searchBar.tintColor = ZJGMainColor;
    self.searchBar.placeholder = @"歌曲/歌手/专辑/歌单/歌词";
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    [searchField setValue:ZJGMiddleFont forKeyPath:@"_placeholderLabel.font"];
    self.searchBar.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];//占位
    self.navigationItem.titleView = self.searchBar;
    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length) {
        [self pushToSearchReferralViewWithText:searchText];
    }
}
- (void)pushToSearchReferralViewWithText:(NSString *)text {
    ZJGSearchReferralTableViewController *referralTableViewController = [[ZJGSearchReferralTableViewController alloc] init];
    [referralTableViewController setSearchText:text];
    [self.navigationController pushViewController:referralTableViewController animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.historyArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //热门
        
        
        JCTagListView *cell = [[JCTagListView alloc] initWithFrame:CGRectMake(0, 0, ZJGScreenWidth, 150)];
        cell.tagCornerRadius = 5.0f;
        cell.canSelectTags = NO;
        [cell.tags addObjectsFromArray:self.hotSearchArrayM];
        [cell setCompletionBlockWithSelected:^(NSInteger index) {
            ZJGLog(@"点击的热门搜索项为:%@",self.hotSearchArrayM[index]);
            //点击热门搜索
            
            [self pushTosearchResultVieWithText:self.hotSearchArrayM[index]];
            
        }];
        
        return cell;
    } else {
        //历史搜索
        static NSString *ID = @"historyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.imageView.image = [UIImage imageNamed:@"cm2_list_icn_recent"];
        cell.textLabel.text = self.historyArray[indexPath.row];
        return cell;
    }
    
}
- (void)pushTosearchResultVieWithText:(NSString *)text {
    ZJGSearchResultViewController *resultViewController = [[ZJGSearchResultViewController alloc] init];
    [resultViewController setSearchText:text];
    [self.navigationController pushViewController:resultViewController animated:NO];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZJGCellHeaderView *headerView = [ZJGCellHeaderView headViewWithTableView:tableView];
    if (section == 0) {
        [headerView setHeadTitle:@"热门搜索" button:@""];
        return headerView;
    } else {
        ZJGCellHeaderView *headerView = [ZJGCellHeaderView headViewWithTableView:tableView];
        [headerView setHeadTitle:@"搜索历史" button:@"清空"];
        headerView.delegate = self;
        return headerView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushTosearchResultVieWithText:self.historyArray[indexPath.row]];
}
#pragma mark - CellHeaderViewDelegate
- (void)clickCellHeaderViewButton {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清空搜索历史吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteSearchHistory];
        self.historyArray = nil;//当前的也清空
        [self.tableView reloadData];
    }];
    [alert addAction:cancel];
    [alert addAction:delete];
    [self presentViewController:alert animated:YES completion:nil];
}
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
