//
//  ZJGCreateTool.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/22.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJGCreateTool : NSObject
+ (UIView *)viewWithView:(UIView *)superView;
+ (UITableView *)tableViewWithView:(UIView *)superView;
+ (UIScrollView *)scrollViewWithView:(UIView *)superView;
+ (UIImageView *)imageViewWithView:(UIView *)superView;
+ (UIImageView *)imageViewWithView:(UIView *)superView size:(CGSize)size;
+ (UILabel *)labelWithView:(UIView *)superView;
+ (UILabel *)labelWithView:(UIView *)superView size:(CGSize)size;
+ (UIButton *)buttonWithView:(UIView *)superView;
+ (UIButton *)buttonWithView:(UIView *)superView image:(UIImage*)image state:(UIControlState)state;
+ (UIButton *)buttonWithView:(UIView *)superView image:(UIImage *)image state:(UIControlState)state size:(CGSize)size;
@end
