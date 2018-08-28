//
//  ZJGMusicTablesModel.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/22.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGMusicTablesModel : NSObject
/** 歌单id*/
@property(nonatomic, copy) NSString *listid;
/** 唱片id*/
@property(nonatomic, copy) NSString *album_id;
/** 听众数*/
@property(nonatomic, copy) NSString *listenum;
/** 歌单标题*/
@property(nonatomic, copy) NSString *title;
/** 歌单大图*/
@property(nonatomic, copy) NSString *pic_big;
/** 歌手*/
@property(nonatomic, copy) NSString *author;
/** 歌单原图*/
@property(nonatomic, copy) NSString *pic_300;

@end
