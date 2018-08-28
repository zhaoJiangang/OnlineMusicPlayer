//
//  ZJGPlayerQueue.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/4.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface ZJGPlayerQueue : AVQueuePlayer
+ (instancetype)sharedPlayerQueue;
@end
