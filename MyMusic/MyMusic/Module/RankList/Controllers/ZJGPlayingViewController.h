//
//  ZJGPlayingViewController.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/3.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJGMusicModel;
//制定协议
@protocol playingViewControllerDelegate <NSObject>
@optional
- (void)updateIndicatorViewOfVisibleCells;
@end


@interface ZJGPlayingViewController : UIViewController
/** 协议代理属性 */
@property (nonatomic ,weak) id<playingViewControllerDelegate> delegate;
/** 当前播放音乐 */
@property (nonatomic, strong ) ZJGMusicModel *currentMusic;
+ (instancetype)sharedPlayingViewController;

- (void)setSongIdArray:(NSMutableArray *)arry currentIndex:(NSInteger)index;

- (void)clickIndicatorView;

@end
