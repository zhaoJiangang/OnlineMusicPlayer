//
//  ZJGRankListTableViewCell.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/25.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGRankListTableViewCell.h"
#import "ZJGRankSongModel.h"

@interface ZJGRankListTableViewCell()
/** tableview头图片 */
@property (nonatomic, weak ) UIImageView *cellImageView;
@end
@implementation ZJGRankListTableViewCell
- (void)setRankListImage:(NSString *)rankListImage {
    _rankListImage = rankListImage;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:self.rankListImage]];
}
- (instancetype)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        NSInteger imageHeight = ZJGScreenWidth / 3;
        CGFloat labelHeight = (imageHeight - 3 * ZJGVerticalSpacing) / 4;
        CGFloat labelWidth = ZJGScreenWidth - imageHeight - 3 * ZJGVerticalSpacing;
        self.cellImageView = [ZJGCreateTool imageViewWithView:self.contentView];
        self.cellImageView.frame = CGRectMake(ZJGVerticalSpacing, ZJGVerticalSpacing, imageHeight, imageHeight);
        NSInteger i = 0;
        for (NSDictionary *dict in array) {
            ZJGRankSongModel *song = [ZJGRankSongModel mj_objectWithKeyValues:dict];
            UILabel *label = [ZJGCreateTool labelWithView:self.contentView];
            label.frame = CGRectMake(imageHeight + 2 * ZJGVerticalSpacing, ZJGVerticalSpacing + (labelHeight) * i, labelWidth, labelHeight);
            label.text = [NSString stringWithFormat:@"%ld. %@ - %@", i + 1 ,song.title,song.author];
            label.font = ZJGBigFont;
            i++;
        }
    }
    return self;
}
+ (instancetype)rankListCellWithTableView:(UITableView *)tableview songInfoArray:(NSArray *)info {
    static NSString *ID = @"rankListCell";
    ZJGRankListTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZJGRankListTableViewCell alloc] initWithArray:info];
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
