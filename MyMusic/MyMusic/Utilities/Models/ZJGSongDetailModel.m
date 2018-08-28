//
//  ZJGSongDetailModel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/24.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGSongDetailModel.h"

@implementation ZJGSongDetailModel
+ (NSArray *)mj_allowedPropertyNames {
    return @[@"title",@"song_id",@"author",@"album_title",@"pic_small"];
}
@end
