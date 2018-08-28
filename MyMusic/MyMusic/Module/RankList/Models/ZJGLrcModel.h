//
//  ZJGLrcModel.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/4.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGLrcModel : NSObject
/** 时间段 */
@property (nonatomic, assign ) NSTimeInterval time;
/** 歌词 */
@property (nonatomic, copy ) NSString *text;
- (instancetype)initWithLrcString:(NSString *)lrcString;
+ (instancetype)lrcModeWithLrcString:(NSString *)lrcString;
@end
