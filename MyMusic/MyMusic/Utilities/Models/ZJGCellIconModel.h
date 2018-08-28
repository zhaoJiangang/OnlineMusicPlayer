//
//  ZJGCellIconModel.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/27.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGCellIconModel : NSObject
/** 打开cell菜单条上button的图片 */
@property (nonatomic, copy ) NSString *icon;
/** 打开cell菜单条上button的标题 */
@property (nonatomic, copy ) NSString *title;
+ (NSArray *)CellMenuItemArray;

@end
