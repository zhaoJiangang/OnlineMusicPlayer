//
//  ZJGMusicModel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/3.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGMusicModel.h"

@implementation ZJGMusicModel
+ (NSArray *)mj_allowedPropertyNames {
    return @[@"songName",@"artistName",@"albumName",@"songPicSmall",@"songPicBig",@"songPicRadio",@"songLink",@"lrcLink",@"showLink",@"songId"];
}
@end
