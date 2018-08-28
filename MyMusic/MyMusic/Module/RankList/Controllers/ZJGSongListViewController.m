//
//  ZJGSongListViewController.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/23.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGSongListViewController.h"
#import "ZJGTableView.h"
#import "ZJGHeadView.h"
#import "ZJGSongListModel.h"
#import "ZJGSongDetailModel.h"
@interface ZJGSongListViewController ()
/** 歌单列表背景图片*/
@property (nonatomic ,weak) UIImageView *backGroundImageView;
/** 滚动视图*/
@property (nonatomic ,weak) UIScrollView *scrollView;
/** 表头视图 */
@property (nonatomic, strong )  ZJGTableView*tableView;
/** 头视图 */
@property (nonatomic, strong ) ZJGHeadView *headView;
/** 歌单数组 */
@property (nonatomic, strong ) NSMutableArray *songListArrayM;
/** 歌单id数组 */
@property (nonatomic, strong ) NSMutableArray *songIdsArrayM;

@end

@implementation ZJGSongListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    [self setUpBackGroundView];
    [self setUpScrollView];
    self.songListArrayM = [NSMutableArray array];
    self.songIdsArrayM = [NSMutableArray array];
    [self loadSongList];
    
}
- (void)setUpBackGroundView {
    self.backGroundImageView = [ZJGCreateTool imageViewWithView:self.view];
    self.backGroundImageView.frame = CGRectMake(-ZJGScreenWidth, -ZJGScreenHeight, 3 * ZJGScreenWidth, 3 * ZJGScreenHeight);
    [self.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:self.picture]];
    [ZJGBlurViewTool blurView:self.backGroundImageView sytle:UIBarStyleDefault];
}
- (void)setUpScrollView {
    self.scrollView = [ZJGCreateTool scrollViewWithView:self.view];
    self.scrollView.frame = self.view.frame;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(0, ZJGScreenHeight + ZJGScreenWidth * 0.5 + 60);
    self.headView = [[ZJGHeadView alloc] initWithFullHead:arc4random() % 2];//通过arc4random() 获取0到x-1之间的整数的代码如下：int value = arc4random() % x;
    
    self.headView.frame = CGRectMake(0, 64, ZJGScreenWidth, ZJGScreenWidth * 0.5 + 60);
    [self.scrollView addSubview:self.headView];
    self.tableView = [[ZJGTableView alloc] init];
    self.tableView.frame = CGRectMake(0, ZJGScreenWidth * 0.5 + 124, ZJGScreenWidth, ZJGScreenHeight);
    [self.scrollView addSubview:self.tableView];
    
}
//http://tingapi.ting.baidu.com/v1/restserver/ting?

#pragma mark - loadData
- (void)loadSongList {
    [ZJGNetWorkTool netWorkToolGetWithUrl:ZJGUrl parameters:ZJGParams(@"method":@"baidu.ting.diy.gedanInfo",@"listid":self.listid) response:^(id response) {
        ZJGSongListModel *songList = [ZJGSongListModel mj_objectWithKeyValues:response];
        NSInteger i = 0;
        for (NSDictionary *dict in songList.content) {
            ZJGSongDetailModel *songDetail = [ZJGSongDetailModel mj_objectWithKeyValues:dict];
            songDetail.num = ++i;
            [self.songListArrayM addObject:songDetail];
            [self.songIdsArrayM addObject:songDetail.song_id];
        }
        [self.headView setMenuList:songList];
        [self.tableView setSongList:self.songListArrayM songIds:self.songIdsArrayM];
    }];
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

