//
//  ZJGLrcTableViewCell.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/10.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGLrcTableViewCell.h"
#import "ZJGLrcLabel.h"
@implementation ZJGLrcTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        ZJGLrcLabel *lrcLabel = [[ZJGLrcLabel alloc] init];
        lrcLabel.textColor = ZJGTextColor;
        lrcLabel.font = ZJGMiddleFont;
        lrcLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lrcLabel];
       _lrcLabel = lrcLabel;
        lrcLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [lrcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}
+ (instancetype)lrcCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"lrcCell";
    ZJGLrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZJGLrcTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
