//
//  ZJGSongListViewController.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/23.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJGSongListViewController : UIViewController
/** 点中一个collectionCell对应的歌单列表id*/
@property (nonatomic ,copy) NSString *listid;
/** 表头视图图片*/
@property (nonatomic ,copy) NSString *picture;

@end
