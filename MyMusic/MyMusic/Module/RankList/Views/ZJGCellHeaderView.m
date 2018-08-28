//
//  ZJGCellHeaderView.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/18.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGCellHeaderView.h"
//增加扩展
@interface ZJGCellHeaderView ()
/** headerView上的button */
@property (nonatomic, weak ) UIButton *clickButton;
/** 显示headerView标题的label */
@property (nonatomic, weak ) UILabel *titleLabel;
/** headerView上的竖线 */
@property (nonatomic, weak ) UIView *lineView;
/** 备胎😁 */
@property (nonatomic, assign ) BOOL isButton;
@end

@implementation ZJGCellHeaderView
- (void)setHeadTitle:(NSString *)title button:(NSString *)button {
    self.titleLabel.text = title;
    if (button.length) {
        [self.clickButton setTitle:button forState:UIControlStateNormal];
    }
    else {
        self.clickButton.hidden = YES;
    }
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.lineView = [ZJGCreateTool viewWithView:self];
        self.lineView.backgroundColor = ZJGTintColor;
        self.lineView.frame = CGRectMake(ZJGCommonSpacing, 3, 2, 20);
        self.titleLabel = [ZJGCreateTool labelWithView:self];
        self.titleLabel.frame = CGRectMake(ZJGHorizontalSpacing, 3, ZJGScreenWidth - 100, 20);
        self.titleLabel.font = ZJGBigFont;
        self.titleLabel.textColor = ZJGTintColor;
        self.clickButton = [ZJGCreateTool buttonWithView:self];
        self.clickButton.frame = CGRectMake(ZJGScreenWidth - 74, 3, 54, 20);
        self.clickButton.titleLabel.font = ZJGBigFont;
        self.clickButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.clickButton.layer.borderWidth = 1;
        self.clickButton.layer.cornerRadius = 5.0;
        [self.clickButton setTitleColor:ZJGMainColor forState:UIControlStateNormal];
        [self.clickButton addTarget:self action:@selector(clickHeaderViewButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
+ (instancetype)headViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"head";
    ZJGCellHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headView) {
        headView = [[ZJGCellHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headView;
}
- (void)clickHeaderViewButton {
    ZJGLog(@"点击清空");
    if ([self.delegate respondsToSelector:@selector(clickCellHeaderViewButton)]) {
        [self.delegate clickCellHeaderViewButton];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
