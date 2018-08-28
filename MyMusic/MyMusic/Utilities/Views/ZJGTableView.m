//
//  ZJGTableView.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/23.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGTableView.h"
#import "ZJGSongDetailModel.h"
#import "ZJGTableViewCell.h"
#import "ZJGPlayingViewController.h"
#import "ZJGMusicModel.h"
typedef NS_ENUM(NSInteger) {
    FavoriteItem = 0,
    AlbumItem,
    DownLoadItem,
    SingerOperation,
    DeleteItem
}item;
//添加扩展遵循协议并实现协议方法
@interface ZJGTableView ()<UITableViewDelegate,UITableViewDataSource,TableViewCellDelegate,playingViewControllerDelegate>
/** 要打开的cell */
@property (nonatomic, weak ) ZJGTableViewCell *isOpenCell;

/** 打开的cell的索引*/
@property (nonatomic ,assign) NSIndexPath *openedCellIndex;
/** cell是否为打开状态*/
@property (nonatomic, assign) BOOL isOpen;
/** 歌单列表数组*/
@property (nonatomic, strong) NSMutableArray *songListArrayM;
/** 歌曲地址数组*/
@property (nonatomic ,strong) NSMutableArray *songIdsArrayM;

@end
@implementation ZJGTableView
- (void)setSongList:(NSMutableArray *)list songIds:(NSMutableArray *)ids {
    self.songListArrayM = list;
    self.songIdsArrayM = ids;
    [self reloadData];
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        //防止ScrollView滚动的时候往回弹跳
        self.bounces = NO;
    }
    return self;
    
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZJGLog(@"该CollectionViewCell的歌曲数为:%ld",self.songListArrayM.count);
    return self.songListArrayM.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJGSongDetailModel *songDetail = self.songListArrayM[indexPath.row];
    ZJGTableViewCell *cell = [ZJGTableViewCell TableViewCellcellWithTableView:tableView];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.bePic = songDetail.pic_small ? YES : NO;
    cell.menuButton.tag = indexPath.row;
    cell.detailModel = songDetail;
    cell.delegate = self;
    [self updateIndicatorViewOfCell:cell];
    //设置cell下拉菜单
    [cell setUpCellOpenedMenuView];
    
    return cell;
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell为开启状态满足的条件
    self.isOpen = self.isOpenCell && self.isOpenCell.isOpenMenu && (self.openedCellIndex.row == indexPath.row);
    if (self.isOpen) {
        return 100;
    } else {
        return 50;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    ZJGPlayingViewController *playingViewController = [ZJGPlayingViewController sharedPlayingViewController];
    playingViewController.delegate = self;
    [playingViewController setSongIdArray:self.songIdsArrayM currentIndex:index];
    [self updateIndicatorViewWithIndexPath:indexPath];
}
#pragma mark - update indicatorView state
- (void)updateIndicatorViewWithIndexPath:(NSIndexPath *)indexPath {
    for (ZJGTableViewCell *cell in self.visibleCells) {
        cell.indicatorViewState = NAKPlaybackIndicatorViewStateStopped;
    }
    ZJGTableViewCell *musicCell = [self cellForRowAtIndexPath:indexPath];
    musicCell.indicatorViewState = NAKPlaybackIndicatorViewStatePlaying;
}
- (void)updateIndicatorViewOfCell:(ZJGTableViewCell *)cell {
    ZJGSongDetailModel *detailModel = cell.detailModel;
    if (detailModel.song_id == [ZJGPlayingViewController sharedPlayingViewController].currentMusic.songId) {
        cell.indicatorViewState = [ZJGMusicIndicatorView sharedIndicatorView].state;
    } else {
        cell.indicatorViewState = NAKPlaybackIndicatorViewStateStopped;
    }
    
}

- (void)clickIndicatorView {
    [[ZJGPlayingViewController sharedPlayingViewController] clickIndicatorView];
}
#pragma mark - playingViewControllerDelegate
- (void)updateIndicatorViewOfVisibleCells {
    for (ZJGTableViewCell *cell in self.visibleCells) {
        [self updateIndicatorViewOfCell:cell];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJGScreenWidth, 10)];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 74;
}
#pragma mark - TableViewCellDelegate
//在合理的时机实现协议方法
- (void)clickCellMenuButton:(UIButton *)button openMenuOfCell:(ZJGTableViewCell *)cell {
    NSIndexPath *openIndex = [NSIndexPath indexPathForRow:button.tag inSection:0];
    
    if (self.isOpen && (self.openedCellIndex.row == button.tag)) {
        
        self.isOpenCell = nil;//关闭cell
        
        [self reloadRowsAtIndexPaths:@[self.openedCellIndex] withRowAnimation:UITableViewRowAnimationFade];//refesh cell
        
        self.openedCellIndex = nil;
        
    }
    else {
        //打开cell
        self.isOpenCell = cell;
        self.openedCellIndex = openIndex;
        
        [self reloadRowsAtIndexPaths:@[self.openedCellIndex] withRowAnimation:UITableViewRowAnimationFade];
        [self scrollToRowAtIndexPath:self.openedCellIndex atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
    
    
}
- (void)clickCellMenuItemButtonAtIndex:(NSInteger)index Cell:(ZJGTableViewCell *)cell {
    //点击button后自动关闭cell
    self.isOpenCell = nil;
    [self reloadRowsAtIndexPaths:@[self.openedCellIndex] withRowAnimation:UITableViewRowAnimationFade];//逐渐消失
    self.openedCellIndex = nil;
    switch (index) {
        case FavoriteItem:
            ZJGLog(@"点击了收藏");
            [ZJGPromptTool promptModeText:@"已添加到收藏" afterDelay:1.0];
            break;
            case AlbumItem:
            ZJGLog(@"点击了专辑");
            [ZJGPromptTool promptModeText:@"暂无专辑信息" afterDelay:1.0];
            break;
            case DownLoadItem:
            ZJGLog(@"点击了下载");
            [ZJGPromptTool promptModeText:@"暂时无法下载" afterDelay:1.0];
            break;
            case SingerOperation:
            ZJGLog(@"点击了歌手");
            [ZJGPromptTool promptModeText:@"暂无歌手信息" afterDelay:1.0];
            break;
            case DeleteItem:
            ZJGLog(@"点击了删除");
            [ZJGPromptTool promptModeText:@"无法删除网络资源" afterDelay:1.0];
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
