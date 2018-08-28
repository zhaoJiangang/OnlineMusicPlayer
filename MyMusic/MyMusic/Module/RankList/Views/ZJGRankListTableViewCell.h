//
//  ZJGRankListTableViewCell.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/25.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJGRankListTableViewCell : UITableViewCell
/** 接收排行列表图片字符串 */
@property (nonatomic, copy ) NSString *rankListImage;
+ (instancetype)rankListCellWithTableView:(UITableView *)tableview songInfoArray:(NSArray *)info;
@end
