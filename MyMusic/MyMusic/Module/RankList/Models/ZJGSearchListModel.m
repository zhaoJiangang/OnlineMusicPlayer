//
//  ZJGSearchListModel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/19.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGSearchListModel.h"

@implementation ZJGSearchListModel
+ (NSArray *)mj_allowedPropertyNames {
    return @[@"songname",@"albumname",@"artistname",@"song_id",@"album_id",@"artist_id",@"ting_uid",@"title",@"author",@"album_title",@"pic_small",@"avatar_middle",@"song_num",@"album_num"];
}
@end
