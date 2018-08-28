//
//  ZJGMusicIndicatorView.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/4.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGMusicIndicatorView.h"

@implementation ZJGMusicIndicatorView
static ZJGMusicIndicatorView *_indicatorView = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _indicatorView = [super allocWithZone:zone];
    });
    return _indicatorView;
}
+ (instancetype)sharedIndicatorView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _indicatorView = [[self alloc] initWithFrame:CGRectMake(ZJGScreenWidth -44, 0, 44, 44)];
    });
    return _indicatorView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
