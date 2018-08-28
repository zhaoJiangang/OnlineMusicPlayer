//
//  ZJGPlayMusicTool.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/4.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class ZJGPlayerQueue;
@interface ZJGPlayMusicTool : NSObject

+ (AVPlayerItem *)playMusicWithLink:(NSString *)link;
+(void)pauseMusicWithLink:(NSString *)link;
+ (void)stopMusicWithLink:(NSString *)link;
+ (void)setUpCurrentPlayingTime:(CMTime)time link:(NSString *)link;
@end
