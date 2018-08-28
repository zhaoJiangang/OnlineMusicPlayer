//
//  ZJGRankListModel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/25.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGRankListModel.h"

@implementation ZJGRankListModel
+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"count",@"web_url",@"pic_s444",@"pic_s260"];
}
@end
