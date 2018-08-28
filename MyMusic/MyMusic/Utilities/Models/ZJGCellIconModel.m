//
//  ZJGCellIconModel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/27.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGCellIconModel.h"

@implementation ZJGCellIconModel
+ (NSArray *)CellMenuItemArray {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CellMenuItem" ofType:@"plist"]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[ZJGCellIconModel mj_objectWithKeyValues:dict]];
    }
    return arrayM;
    
}
@end
