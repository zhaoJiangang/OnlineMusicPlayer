//
//  ZJGRankSongViewController.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/29.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGRankSongViewController.h"
#import "ZJGTableView.h"
#import "ZJGRankListModel.h"
#import "ZJGSongDetailModel.h"

@interface ZJGRankSongViewController ()
/** 背景图 */
@property (nonatomic, weak ) UIImageView *backGroundImageView;
/** 公共tableview */
@property (nonatomic, strong ) ZJGTableView *tableView;
/** 排行数组 */
@property (nonatomic, strong ) NSMutableArray *rankArrayM;
/** 歌曲id数组 */
@property (nonatomic, strong ) NSMutableArray *songIds;

@end

@implementation ZJGRankSongViewController
- (void)setRankType:(ZJGRankListModel *)rankType {
    _rankType = rankType;
    [self loadRankDetail];
    
}
- (void)loadRankDetail {
    [ZJGNetWorkTool netWorkToolGetWithUrl:ZJGUrl parameters:ZJGParams(@"method":@"baidu.ting.billboard.billList",@"offset":@"0",@"size":@"100",@"type":self.rankType.type) response:^(id response) {
        NSInteger i = 0;
        for (NSDictionary *dict in response[@"song_list"]) {
            ZJGSongDetailModel *songDetail = [ZJGSongDetailModel mj_objectWithKeyValues:dict];
            songDetail.num = ++i;
            [self.rankArrayM addObject:songDetail];
            [self.songIds addObject:songDetail.song_id];
            [self.tableView setSongList:self.rankArrayM songIds:self.songIds];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rankArrayM = [NSMutableArray array];
    self.songIds = [NSMutableArray array];
    [self setUpBackGroundImageView];
    [self setUpTableView];
    [self setUpTableViewHeader];
}
- (void)setUpBackGroundImageView {
    self.backGroundImageView = [ZJGCreateTool imageViewWithView:self.view];
    self.backGroundImageView.frame = CGRectMake(-ZJGScreenWidth, -ZJGScreenHeight, 3 * ZJGScreenWidth, 3 * ZJGScreenHeight);
    [self.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:self.rankType.pic_s210]];
    [ZJGBlurViewTool blurView:self.backGroundImageView sytle:UIBarStyleDefault];
}
- (void)setUpTableView {
    self.tableView = [[ZJGTableView alloc] init];
    self.tableView.frame = CGRectMake(0, 64, ZJGScreenWidth, ZJGScreenHeight);
    
    [self.view addSubview:self.tableView];
}
- (void)setUpTableViewHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJGScreenWidth, ZJGScreenWidth * 0.6)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.rankType.pic_s210]];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * ZJGCommonSpacing, ZJGScreenWidth * 0.5, ZJGScreenWidth, 25)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = [NSString stringWithFormat:@"%@",self.rankType.name];
    [view addSubview:imageView];
    self.tableView.tableHeaderView = view;
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
