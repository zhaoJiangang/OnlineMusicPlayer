//
//  ZJGHeadView.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/24.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJGSongListModel;
@interface ZJGHeadView : UIView
- (void)setMenuList:(ZJGSongListModel *)listModel;
- (void)setNewAlbum:(ZJGSongListModel *)albumModel;
- (instancetype)initWithFullHead:(BOOL)full;

@end
