//
//  UIView+distribute.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/7.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (distribute)
- (void)distributeViewsHorizontallyWith:(NSArray *)views margin:(CGFloat)margin;
- (void)distributeViewsVerticallyWith:(NSArray *)views margin:(CGFloat)margin;
- (void)distributeViewsHorizontallyWith:(NSArray *)views;
- (void)distributeViewsVerticallyWith:(NSArray *)views;
@end
