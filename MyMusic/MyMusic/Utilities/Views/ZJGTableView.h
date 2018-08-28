//
//  ZJGTableView.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/23.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJGTableView : UITableView
- (void)setSongList:(NSMutableArray *)list songIds:(NSMutableArray *)ids;
@end
