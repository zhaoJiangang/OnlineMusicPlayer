//
//  ZJGRankListTableViewController.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/25.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGRankListTableViewController.h"
#import "ZJGRankListModel.h"
#import "ZJGRankListTableViewCell.h"
#import "ZJGRankSongViewController.h"

@interface ZJGRankListTableViewController ()
/** 排行列表数组 */
@property (nonatomic, strong ) NSMutableArray *rankListArrayM;
@end

@implementation ZJGRankListTableViewController
- (NSMutableArray *)rankListArrayM {
    if (!_rankListArrayM) {
        _rankListArrayM = [NSMutableArray array];
        [self loadRankData];
    }
    return _rankListArrayM;
}
//http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billCategory&kflag=1
- (void)loadRankData {
    [ZJGNetWorkTool netWorkToolGetWithUrl:ZJGUrl parameters:ZJGParams(@"method":@"baidu.ting.billboard.billCategory",@"kflag":@"1") response:^(id response) {
        for (NSDictionary *dict in response[@"content"]) {
            ZJGRankListModel *rankList = [ZJGRankListModel mj_objectWithKeyValues:dict];
            [self.rankListArrayM addObject:rankList];
        }
        [self.tableView reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rankListArrayM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJGRankListModel *list = self.rankListArrayM[indexPath.row];
    ZJGRankListTableViewCell *cell = [ZJGRankListTableViewCell rankListCellWithTableView:tableView songInfoArray:list.content];
    cell.rankListImage = list.pic_s192;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger height = ZJGScreenWidth / 3;
    return height + 2 * ZJGVerticalSpacing;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJGRankListModel * list = self.rankListArrayM[indexPath.row];
    ZJGRankSongViewController *rankSongViewController = [[ZJGRankSongViewController alloc] init];
    rankSongViewController.rankType = list;
    [self.navigationController pushViewController:rankSongViewController animated:YES];
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
