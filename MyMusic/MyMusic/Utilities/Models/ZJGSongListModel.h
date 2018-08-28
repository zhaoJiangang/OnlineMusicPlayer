//
//  ZJGSongListModel.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/24.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGSongListModel : NSObject
/** 表头图片 */
@property (nonatomic, copy) NSString *pic_300;
/** 听众数 */
@property (nonatomic, copy) NSString *listenum;
/** 粉丝数 */
@property (nonatomic, copy ) NSString *collectnum;
/** 歌单列表类型描述 */
@property (nonatomic, copy ) NSString *desc;
/** 歌单标题 */
@property (nonatomic, copy ) NSString *title;
/** 歌单类型 */
@property (nonatomic, copy ) NSString *tag;
/** 歌单内容 */
@property (nonatomic, strong ) NSArray *content;
/** ??? */
@property (nonatomic, copy ) NSString *pic_radio;
/** 唱片发行时间 */
@property (nonatomic, copy) NSString *publishtime;
/** 歌曲信息 */
@property (nonatomic, copy ) NSString *info;
/** 歌手 */
@property (nonatomic, copy ) NSString *author;

@end
