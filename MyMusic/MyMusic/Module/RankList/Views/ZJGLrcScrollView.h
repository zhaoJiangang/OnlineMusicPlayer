//
//  ZJGLrcScrollView.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/10.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJGLrcScrollView : UIScrollView
/** 当前时间 */
@property (nonatomic, assign ) NSTimeInterval currentTime;
/** 歌词数组 */
@property (nonatomic, strong ) NSArray *lrcArray;
@end
