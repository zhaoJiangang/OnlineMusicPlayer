//
//  ZJGMusicTablesModel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/22.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGMusicTablesModel.h"

@implementation ZJGMusicTablesModel
+ (NSArray *)mj_allowedPropertyNames {
    
    return @[@"listid",@"listenum",@"title",@"pic_300",@"pic_big",@"author",@"album_id"];
    
}
@end
