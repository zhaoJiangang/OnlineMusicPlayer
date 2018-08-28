//
//  ZJGLrcTableViewCell.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/10.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJGLrcLabel;
@interface ZJGLrcTableViewCell : UITableViewCell
/** 显示歌词的label */
@property (nonatomic, weak, readonly ) ZJGLrcLabel *lrcLabel;
+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;
@end
