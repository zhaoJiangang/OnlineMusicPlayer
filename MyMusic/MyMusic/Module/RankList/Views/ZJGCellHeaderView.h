//
//  ZJGCellHeaderView.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/18.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>
//制定协议
@protocol CellHeaderViewDelegate <NSObject>
- (void)clickCellHeaderViewButton;

@end
@interface ZJGCellHeaderView : UITableViewHeaderFooterView
/** 协议delegate属性 */
@property (nonatomic, weak ) id<CellHeaderViewDelegate> delegate;
- (void)setHeadTitle:(NSString *)title button:(NSString *)button;
+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end
