//
//  ZJGRankListModel.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/25.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGRankListModel : NSObject
/** 排行种类 */
@property (nonatomic, copy ) NSString *name;
/** 排行类型 */
@property (nonatomic, assign ) NSString *type;
/** 排行描述 */
@property (nonatomic, copy ) NSString *comment;
/** 方图 */
@property (nonatomic, copy ) NSString *pic_s192;
/** 长图 */
@property (nonatomic, copy ) NSString *pic_s210;
/** 排行种类数组 */
@property (nonatomic, strong ) NSArray *content;

@end
