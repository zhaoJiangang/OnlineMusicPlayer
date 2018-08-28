//
//  ZJGPlayMusicTool.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/4.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGPlayMusicTool.h"
#import "ZJGMusicIndicatorView.h"
#import <AVFoundation/AVFoundation.h>
#import "ZJGPlayerQueue.h"
//添加扩展
@interface ZJGPlayMusicTool()
@end
@implementation ZJGPlayMusicTool
static ZJGMusicIndicatorView *_indicatorView;
static NSMutableDictionary *_playingMusic;
+ (void)initialize {
    _playingMusic = [NSMutableDictionary dictionary];
    _indicatorView = [ZJGMusicIndicatorView sharedIndicatorView];
    
}
+ (void)setUpCurrentPlayingTime:(CMTime)time link:(NSString *)link {
    AVPlayerItem *playItem = _playingMusic[link];
    ZJGPlayerQueue *queue = [ZJGPlayerQueue sharedPlayerQueue];
    [playItem seekToTime:time completionHandler:^(BOOL finished) {
        [_playingMusic setObject:playItem forKey:link];
        //开始播放
        [queue play];
        _indicatorView.state = NAKPlaybackIndicatorViewStatePlaying;
    }];
}
+ (AVPlayerItem *)playMusicWithLink:(NSString *)link {
    ZJGPlayerQueue *queue = [ZJGPlayerQueue sharedPlayerQueue];
    AVPlayerItem *playItem = _playingMusic[link];
    if (!playItem) {
        playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:link]];
        [_playingMusic setObject:playItem forKey:link];
        [queue replaceCurrentItemWithPlayerItem:playItem];
    }
    [queue play];
    _indicatorView.state = NAKPlaybackIndicatorViewStatePlaying;
    return playItem;
}
+ (void)pauseMusicWithLink:(NSString *)link {
    AVPlayerItem *playItem = _playingMusic[link];
    if (playItem) {
        ZJGPlayerQueue *queue = [ZJGPlayerQueue sharedPlayerQueue];
        [queue pause];
        _indicatorView.state = NAKPlaybackIndicatorViewStatePaused;
    }
}
+ (void)stopMusicWithLink:(NSString *)link {
    AVPlayerItem *playItem = _playingMusic[link];
    if (playItem) {
        ZJGPlayerQueue *queue = [ZJGPlayerQueue sharedPlayerQueue];
        [_playingMusic removeAllObjects];
        [queue removeItem:playItem];
    }
}
@end
