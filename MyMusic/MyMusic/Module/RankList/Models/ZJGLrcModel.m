//
//  ZJGLrcModel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/4.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGLrcModel.h"

@implementation ZJGLrcModel
- (instancetype)initWithLrcString:(NSString *)lrcString {
    if (self = [super init]) {
        //以]为界将歌词时间分割开
        self.text = [[lrcString componentsSeparatedByString:@"]"]lastObject];
        NSString *timeString = [[[lrcString componentsSeparatedByString:@"]"] firstObject] substringFromIndex:1];
        self.time = [self timeWithString:timeString];
    }
    return self;
}
- (NSTimeInterval)timeWithString:(NSString *)timeString {
    //将时间分离出来
    NSInteger minute = [[[timeString componentsSeparatedByString:@":"] firstObject] integerValue];
    NSInteger second = [[[[[timeString componentsSeparatedByString:@":"] lastObject] componentsSeparatedByString:@"."] firstObject] integerValue];
    NSInteger milliecond = [[[[[timeString componentsSeparatedByString:@":"] lastObject] componentsSeparatedByString:@"."] firstObject] integerValue];
    return minute * 60 + second + milliecond * 0.01;
}
+ (instancetype)lrcModeWithLrcString:(NSString *)lrcString {
    return [[self alloc] initWithLrcString:lrcString];
}
@end
