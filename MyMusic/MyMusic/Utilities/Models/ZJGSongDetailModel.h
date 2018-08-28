//
//  ZJGSongDetailModel.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/24.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGSongDetailModel : NSObject
/** 歌曲标题 */
@property (nonatomic, copy ) NSString *title;
/** 歌曲id */
@property (nonatomic, copy ) NSString *song_id;
/** 歌手 */
@property (nonatomic, copy ) NSString *author;
/** 专辑名 */
@property (nonatomic, copy ) NSString *album_title;
/** 歌曲小图片 */
@property (nonatomic, copy ) NSString *pic_small;
/** 歌曲数量 */
@property (nonatomic, assign ) NSInteger num;
@end
