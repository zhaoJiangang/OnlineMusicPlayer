//
//  ZJGTableViewCell.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/24.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAKPlaybackIndicatorView.h"
@class ZJGSongDetailModel, ZJGTableViewCell;
//制定cell的协议
@protocol TableViewCellDelegate <NSObject>
- (void)clickCellMenuButton:(UIButton *)button openMenuOfCell:(ZJGTableViewCell *)cell;
- (void)clickCellMenuItemButtonAtIndex:(NSInteger)index Cell:(ZJGTableViewCell *)cell;
- (void)clickIndicatorView;
@end
@interface ZJGTableViewCell : UITableViewCell
/** 协议的代理属性 */
@property (nonatomic, weak ) id<TableViewCellDelegate> delegate;
/** 菜单是否是打开的 */
@property (nonatomic, assign ) BOOL isOpenMenu;
/** 是否有图片 */
@property (nonatomic, assign ) BOOL bePic;
/** cell上的button */
@property (nonatomic, weak ) UIButton *menuButton;
/** 播放状态 */
@property (nonatomic, assign ) NAKPlaybackIndicatorViewState indicatorViewState;
/** 歌曲详情模型 */
@property (nonatomic, weak ) ZJGSongDetailModel *detailModel;
- (void)setUpCellOpenedMenuView;
+ (instancetype)TableViewCellcellWithTableView:(UITableView *)tableView;
@end
