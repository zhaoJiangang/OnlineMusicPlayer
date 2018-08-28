//
//  ZJGPlayerQueue.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/4.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGPlayerQueue.h"

@implementation ZJGPlayerQueue
static ZJGPlayerQueue *_playerQueue = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playerQueue = [super allocWithZone:zone];
    });
    return _playerQueue;
}
+ (instancetype)sharedPlayerQueue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playerQueue = [[ZJGPlayerQueue alloc] init];
    });
    return _playerQueue;
}
@end
