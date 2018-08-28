//
//  ZJGSearchReferralTableViewController.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/18.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGSearchReferralTableViewController.h"
#import "ZJGSearchInfoModel.h"
#import "ZJGSearchListModel.h"
#import "ZJGCellHeaderView.h"
#import "ZJGSearchResultViewController.h"

@interface ZJGSearchReferralTableViewController ()<UISearchBarDelegate>
/** 搜索栏 */
@property (nonatomic, strong ) UISearchBar *searchBar;
/** 歌曲数组 */
@property (nonatomic, strong ) NSMutableArray *songArrayM;
/** 专辑数组 */
@property (nonatomic, strong ) NSMutableArray *albumArrayM;
/** 唱片数组 */
@property (nonatomic, strong ) NSMutableArray *artistArrayM;
/** 接收输入的搜索内容 */
@property (nonatomic, copy ) NSString *text;

@end

@implementation ZJGSearchReferralTableViewController
- (void)setSearchText:(NSString *)text {
    self.text = text;
    self.songArrayM = [NSMutableArray array];
    self.albumArrayM = [NSMutableArray array];
    self.artistArrayM = [NSMutableArray array];
    [self loadSearchDataWithText:text];
}
- (void)loadSearchDataWithText:(NSString *)text {
    //将搜索字符转化
//    NSCharacterSet *set = [NSCharacterSet URLFragmentAllowedCharacterSet];
//
//    NSString *key = [text stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    [ZJGNetWorkTool netWorkToolGetWithUrl:ZJGUrl parameters:ZJGParams(@"method":@"baidu.ting.search.catalogSug",@"query":text) response:^(id response) {
        ZJGSearchInfoModel *info = [ZJGSearchInfoModel mj_objectWithKeyValues:response];
        self.songArrayM = [info.song mutableCopy];
        self.albumArrayM = [info.album mutableCopy];
        self.artistArrayM = [info.artist mutableCopy];
        [self.tableView reloadData];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchBar.text = self.text;
    [self.searchBar becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBar];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)setUpSearchBar {
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;//凸出的
    self.searchBar.tintColor = ZJGMainColor;
    
    self.searchBar.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];//占位
    self.navigationItem.titleView = self.searchBar;
    [self.navigationItem setHidesBackButton:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.songArrayM.count > 5 ? 5 : self.songArrayM.count;
    } else if (section == 1){
        return self.albumArrayM.count > 5 ? 5 : self.albumArrayM.count;
    } else {
        return self.artistArrayM.count > 5 ? 5 : self.artistArrayM.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"referralCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.font = ZJGBigFont;
    cell.detailTextLabel.font = ZJGMiddleFont;
    if (self.songArrayM.count && indexPath.section == 0) {
        ZJGSearchListModel *songList = self.songArrayM[indexPath.row];
        cell.textLabel.text = songList.songname;
        cell.detailTextLabel.text = songList.artistname;
    } else if (self.albumArrayM.count && indexPath.section == 1) {
        ZJGSearchListModel *albumList = self.albumArrayM[indexPath.row];
        cell.textLabel.text = albumList.albumname;
        cell.detailTextLabel.text = albumList.artistname;
    }
    else if (self.artistArrayM.count && indexPath.section == 2) {
        ZJGSearchListModel *artistList = self.artistArrayM[indexPath.row];
        cell.textLabel.text = artistList.artistname;
        
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZJGCellHeaderView *headerView = [ZJGCellHeaderView headViewWithTableView:self.tableView];
    if (section == 0) {
        [headerView setHeadTitle:@"歌曲" button:@""];
    } else if (section == 1) {
        [headerView setHeadTitle:@"专辑" button:@""];
    } else {
        [headerView setHeadTitle:@"歌手" button:@""];
    }
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.songArrayM.count ? 30 : 0;
    } else if (section == 1) {
        return self.albumArrayM.count ? 30 : 0;
    } else {
        return self.artistArrayM.count ? 30 : 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [NSString string];
    if (indexPath.section == 0) {
        ZJGSearchListModel *songList = self.songArrayM[indexPath.row];
        text = songList.songname;
    } else if (indexPath.section == 1) {
        ZJGSearchListModel *albumList = self.albumArrayM[indexPath.row];
        text = albumList.albumname;
    } else {
        ZJGSearchListModel *artistList = self.artistArrayM[indexPath.row];
        text = artistList.artistname;
    }
    ZJGLog(@"对应的文本是:%@",text);
    [self addSearchText:text];
    [self pushTosearchResultViewWithText:text];
}
- (void)pushTosearchResultViewWithText:(NSString *)text {
    ZJGSearchResultViewController *resultViewController = [[ZJGSearchResultViewController alloc] init];
    [resultViewController setSearchText:text];
    [self.navigationController pushViewController:resultViewController animated:NO];
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:NO];
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self loadSearchDataWithText:searchText];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self addSearchText:searchBar.text];
    [self pushTosearchResultViewWithText:searchBar.text];
}
#pragma mark - 缓存记录
- (void)addSearchText:(NSString *)text {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults arrayForKey:@"history"];
    if (!array.count) {
        //创建一个
        array = [NSArray array];
    }
    NSMutableArray *arrayM = [array mutableCopy];
    [arrayM insertObject:text atIndex:0];
    //最多缓存15个
    if (arrayM.count > 15) {
        [arrayM removeObjectAtIndex:0];
    }
    [userDefaults setObject:arrayM forKey:@"history"];
    [userDefaults synchronize];
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
