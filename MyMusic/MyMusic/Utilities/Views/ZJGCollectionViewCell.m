//
//  ZJGCollectionViewCell.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/21.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGCollectionViewCell.h"
#import "ZJGMusicTablesModel.h"
//给该类添加一个扩展增加属性
@interface ZJGCollectionViewCell()
/** cell的图片*/
@property (nonatomic ,weak) UIImageView *picView;
/** 显示cell标题的label*/
@property (nonatomic ,weak) UILabel *titleLabel;
/** 显示听众数的label*/
@property (nonatomic ,weak) UILabel *listenumLabel;
@end
@implementation ZJGCollectionViewCell
- (void)setSongMenu:(ZJGMusicTablesModel *)menu {
    [self.picView sd_setImageWithURL:[NSURL URLWithString:menu.pic_300]];
    self.titleLabel.text = [NSString stringWithFormat:@"  %@",menu.title];
    
    self.listenumLabel.text = [NSString stringWithFormat:@"   🎧%@",menu.listenum];
}
- (void)setNewSongAlbum:(ZJGMusicTablesModel *)newSong {
    [self.picView sd_setImageWithURL:[NSURL URLWithString:newSong.pic_big]];
    self.titleLabel.text = [NSString stringWithFormat:@" %@  %@",newSong.author,newSong.title];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.picView = [ZJGCreateTool imageViewWithView:self.contentView];
        self.titleLabel = [ZJGCreateTool labelWithView:self.contentView];
        self.titleLabel.font = ZJGBigFont;
        self.titleLabel.numberOfLines = 0;
        self.listenumLabel = [ZJGCreateTool labelWithView:self.contentView];
        self.listenumLabel.font = ZJGBigFont;
        self.listenumLabel.textColor = [UIColor whiteColor];
    }
return self;
    
}
//布局cell
- (void)layoutSubviews {
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self.mas_width);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(40);
    }];
    [self.listenumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(15);
    }];
}
@end
