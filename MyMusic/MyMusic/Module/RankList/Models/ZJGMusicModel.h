//
//  ZJGMusicModel.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/3.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGMusicModel : NSObject
/** 歌名 */
@property (nonatomic, copy ) NSString *songName;
/** 艺名 */
@property (nonatomic, copy ) NSString *artistName;
/** 专辑名 */
@property (nonatomic, copy ) NSString *albumName;
/** 歌曲小图片 */
@property (nonatomic, copy ) NSString *songPicSmall;
/** 歌曲大图片 */
@property (nonatomic, copy ) NSString *songPicBig;
/** 收听频道图片 */
@property (nonatomic, copy ) NSString *songPicRadio;
/** 歌曲链接 */
@property (nonatomic, copy ) NSString *songLink;
/** 歌词链接 */
@property (nonatomic, copy ) NSString *lrcLink;
/** 歌曲高品音质链接 */
@property (nonatomic, copy ) NSString *showLink;
/** 歌曲地址 */
@property (nonatomic, copy ) NSString *songId;

@end
