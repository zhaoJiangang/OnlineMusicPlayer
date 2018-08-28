//
//  ZJGSearchInfoModel.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/18.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGSearchInfoModel : NSObject
/** 歌曲数组 */
@property (nonatomic, strong ) NSArray *song;
/** 专辑数组 */
@property (nonatomic, strong ) NSArray *album;
/** 唱片数组 */
@property (nonatomic, strong ) NSArray *artist;
/** 总数 */
@property (nonatomic, copy ) NSString *total;
/** 歌曲列表 */
@property (nonatomic, strong ) NSArray *song_list;
/** 专辑列表 */
@property (nonatomic, strong ) NSArray *album_list;
/** 唱片列表 */
@property (nonatomic, strong ) NSArray *artist_list;
/** 歌曲信息 */
@property (nonatomic, strong ) ZJGSearchInfoModel *song_info;
/** 专辑信息 */
@property (nonatomic, strong ) ZJGSearchInfoModel *album_info;
/** 唱片信息 */
@property (nonatomic, strong ) ZJGSearchInfoModel *artist_info;
@end
