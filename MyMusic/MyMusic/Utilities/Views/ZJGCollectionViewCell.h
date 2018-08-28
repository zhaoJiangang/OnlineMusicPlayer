//
//  ZJGCollectionViewCell.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/21.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJGMusicTablesModel;
@interface ZJGCollectionViewCell : UICollectionViewCell
- (void)setSongMenu:(ZJGMusicTablesModel *)menu;

- (void)setNewSongAlbum:(ZJGMusicTablesModel *)newSong;
@end
