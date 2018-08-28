//
//  ZJGCellMenuItemButton.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/27.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGCellMenuItemButton.h"
#import "ZJGCellIconModel.h"
@implementation ZJGCellMenuItemButton
- (instancetype)initWithFrame:(CGRect)frame model:(ZJGCellIconModel *)model {
    if (self = [super initWithFrame:frame]) {
        [self settingItemButtonWithModel:model];
    }
    return self;
    
}
- (void)settingItemButtonWithModel:(ZJGCellIconModel *)model {
    //设置打开cell菜单条上button的图片
    UIImageView *image = [[UIImageView alloc] init];
    image.bounds = CGRectMake(0, 0, 20, 20);
    image.center = CGPointMake(self.frame.size.width/2, 20);
    image.image = [UIImage imageNamed:model.icon];
    [self addSubview:image];
    //设置打开cell菜单条上button的标题
    UILabel *title = [[UILabel alloc] init];
    title.bounds = CGRectMake(0, 0, self.frame.size.width, 20);
    title.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 14);
    title.text = model.title;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = ZJGSmallFont;
    title.textColor = ZJGMainColor;
    [self addSubview:title];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
