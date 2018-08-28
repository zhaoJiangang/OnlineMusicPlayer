//
//  ZJGSearchListModel.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/19.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGSearchListModel : NSObject
/** 歌名 */
@property (nonatomic, copy ) NSString *songname;
/** 唱片名 */
@property (nonatomic, copy ) NSString *artistname;
/** 专辑名 */
@property (nonatomic, copy ) NSString *albumname;

/** 歌曲标题 */
@property (nonatomic, copy ) NSString *title;
/** 歌手 */
@property (nonatomic, copy ) NSString *author;
/** 专辑标题 */
@property (nonatomic, copy ) NSString *album_title;
/** 小图片 */
@property (nonatomic, copy ) NSString *pic_small;
/** <#Content#> */
@property (nonatomic, copy ) NSString *avatar_middle;//替身
/** 歌曲id */
@property (nonatomic, copy ) NSString *song_id;
/** 专辑id */
@property (nonatomic, copy ) NSString *album_id;
/** 唱片id */
@property (nonatomic, copy ) NSString *artist_id;

/** 专辑数 */
@property (nonatomic, copy ) NSString *album_num;
/** 歌曲数 */
@property (nonatomic, copy ) NSString *song_num;
/** <#Content#> */
@property (nonatomic, copy ) NSString *ting_uid;

@end
