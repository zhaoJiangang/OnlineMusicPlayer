//
//  ZJGSongListModel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/24.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGSongListModel.h"

@implementation ZJGSongListModel
+ (NSArray *)mj_allowedPropertyNames {
    return @[@"pic_300",@"listenum",@"collectnum",@"desc",@"title",@"tag",@"content",@"pic_radio",@"publishtime",@"info",@"author"];
}
@end
