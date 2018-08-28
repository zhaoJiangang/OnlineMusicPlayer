//
//  ZJGBlurViewTool.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/25.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGBlurViewTool.h"

@implementation ZJGBlurViewTool
+ (void)blurView:(UIView *)view sytle:(UIBarStyle)style {
    UIToolbar *blurView = [[UIToolbar alloc] init];
    blurView.barStyle = style;
    blurView.frame = view.frame;
    [view addSubview:blurView];
}
@end
