//
//  ZJGLrcTool.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/4.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

//#import <Foundation/Foundation.h>
@class ZJGLrcScrollView;
@interface ZJGLrcTool : NSObject
+ (void)lrcToolDownloadWithUrl:(NSString *)url setUpLrcView:(ZJGLrcScrollView *)lrcView;
@end
