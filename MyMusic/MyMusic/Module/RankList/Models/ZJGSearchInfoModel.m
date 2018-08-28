//
//  ZJGSearchInfoModel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/18.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGSearchInfoModel.h"

@implementation ZJGSearchInfoModel
+ (NSArray *)mj_allowedPropertyNames {
    return @[@"song",@"artist",@"album",@"song_info",@"album_info",@"artist_info",@"song_list",@"album_list",@"artist_list",@"total"];
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"song":@"ZJGSearchListModel",
             @"artist":@"ZJGSearchListModel",
             @"album":@"ZJGSearchListModel",
             @"song_list":@"ZJGSearchListModel",
             @"album_list":@"ZJGSearchListModel",
             @"artist_list":@"ZJGSearchListModel"
             };
}
@end
