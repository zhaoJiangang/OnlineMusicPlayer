//
//  ZJGCreateTool.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/22.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGCreateTool.h"

@implementation ZJGCreateTool
+ (UIView *)viewWithView:(UIView *)superView {
    UIView *view = [[UIView alloc] init];
    [superView addSubview:view];
    return view;
}
+ (UITableView *)tableViewWithView:(UIView *)superView {
    UITableView *tableView = [[UITableView alloc] init];
    [superView addSubview:tableView];
    return tableView;
    
}
+ (UIScrollView *)scrollViewWithView:(UIView *)superView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [superView addSubview:scrollView];
    return scrollView;

}
+ (UIImageView *)imageViewWithView:(UIView *)superView {
    UIImageView *imageView = [[UIImageView alloc] init];
    [superView addSubview:imageView];
    return imageView;
    
}
+ (UIImageView *)imageViewWithView:(UIView *)superView size:(CGSize)size {
    UIImageView *imageView = [[UIImageView alloc] init];
    [superView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
    return imageView;
    
}
//在view上添加一个原始的button
+ (UIButton *)buttonWithView:(UIView *)superView {
    
return [self buttonWithView:superView image:nil state:UIControlStateNormal];
    
}
//在viwe上添加一个带图片带状态的按钮
+ (UIButton *)buttonWithView:(UIView *)superView image:(UIImage *)image state:(UIControlState)stae {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:stae];
    [superView addSubview: button];
    return button;
    
}
//在view上添加一个带图片带状态有确定大小的按钮
+ (UIButton *)buttonWithView:(UIView *)superView image:(UIImage *)image state:(UIControlState)state size:(CGSize)size {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:state];
    [superView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
    return button;
    
}
+ (UILabel *)labelWithView:(UIView *)superView {
    UILabel *label = [[UILabel alloc] init];
    [superView addSubview:label];
    return label;
    
}
+ (UILabel *)labelWithView:(UIView *)superView size:(CGSize)size {
    UILabel *label = [[UILabel alloc] init];
    [superView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
    
    return label;
    
}


@end
