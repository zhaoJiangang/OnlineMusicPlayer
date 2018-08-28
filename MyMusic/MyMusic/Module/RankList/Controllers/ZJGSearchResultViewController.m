//
//  ZJGSearchResultViewController.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/19.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGSearchResultViewController.h"
#import "ZJGTableView.h"
#import "ZJGSearchInfoModel.h"
#import "ZJGSongDetailModel.h"
#import "ZJGSearchReferralTableViewController.h"

@interface ZJGSearchResultViewController ()<UISearchBarDelegate>
/** 搜索栏 */
@property (nonatomic, strong ) UISearchBar *searchBar;
/** 搜索内容 */
@property (nonatomic, copy ) NSString *text;
/** 歌单数组 */
@property (nonatomic, strong ) NSMutableArray *songListArrayM;
/** 歌曲id数组 */
@property (nonatomic, strong ) NSMutableArray *songIdsArrayM;
/** 公共的tableView */
@property (nonatomic, strong ) ZJGTableView *tableview;
@end

@implementation ZJGSearchResultViewController
- (void)setSearchText:(NSString *)text {
    self.text = text;
    self.songListArrayM = [NSMutableArray array];
    self.songIdsArrayM = [NSMutableArray array];
    [self loadSearchResultData:text];
}
- (void)loadSearchResultData:(NSString *)text {
    [ZJGNetWorkTool netWorkToolGetWithUrl:ZJGUrl parameters:ZJGParams(@"method":@"baidu.ting.search.merge",@"page_size":@"50",@"page_no":@"-1",@"type":@"-1",@"query":text) response:^(id response) {
        ZJGSearchInfoModel *info = [ZJGSearchInfoModel mj_objectWithKeyValues:response[@"result"]];
        ZJGSearchInfoModel *songList = [ZJGSearchInfoModel mj_objectWithKeyValues:info.song_info];
        NSInteger i = 0;
        for (NSDictionary *dict in songList.song_list) {
            ZJGSongDetailModel *detail = [ZJGSongDetailModel mj_objectWithKeyValues:dict];
            detail.num = ++i;
            [self.songListArrayM addObject:detail];
            [self.songIdsArrayM addObject:detail.song_id];
        }
        [self.tableview setSongList:self.songListArrayM songIds:self.songIdsArrayM];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchBar.placeholder = self.text;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSearchBar];
    self.tableview = [[ZJGTableView alloc] init];
    self.tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
}
- (void)setUpSearchBar {
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    self.searchBar.tintColor = ZJGTintColor;
    self.searchBar.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];//占位
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackButton)];
    self.navigationItem.titleView = self.searchBar;
}
- (void)clickBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(self.view);
//    }];
    self.tableview.frame = self.view.frame;
    
    
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self pushToSearchReferralViewWithText:searchText];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
