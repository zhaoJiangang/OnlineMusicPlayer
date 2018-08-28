//
//  ZJGHeadView.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/24.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGHeadView.h"
#import "ZJGSongListModel.h"
//添加扩展增加属性
@interface ZJGHeadView ()
/** 头视图图片 */
@property (nonatomic, weak ) UIImageView *picView;
/** 头视图标题 */
@property (nonatomic, weak ) UILabel *titleLabel;
/** 歌曲风格 */
@property (nonatomic, weak ) UILabel *tagLabel;
/** 听众数 */
@property (nonatomic, weak ) UILabel *listenumLabel;
/** 收藏 */
@property (nonatomic, weak ) UIButton *collectButton;
/** 分享 */
@property (nonatomic, weak ) UIButton *shareButton;
/** 添加为喜欢 */
@property (nonatomic, weak ) UIButton *likeButton;
/** 更多信息 */
@property (nonatomic, weak ) UIButton *listButton;
/** 头视图描述 */
@property (nonatomic, weak ) UILabel *descLabel;
/** 是否全图布尔值 */
@property (nonatomic, assign ) BOOL isFullImage;

@end
@implementation ZJGHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setMenuList:(ZJGSongListModel *)listModel {
    [self.picView sd_setImageWithURL:[NSURL URLWithString:listModel.pic_300]];
    self.titleLabel.text = listModel.title;
    self.tagLabel.text = listModel.tag;
    self.listenumLabel.text = [NSString stringWithFormat:@"%@个听众  %@个粉丝",listModel.listenum,listModel.collectnum];
    self.descLabel.text = listModel.desc;
}
- (void)setNewAlbum:(ZJGSongListModel *)albumModel {
    [self.picView sd_setImageWithURL:[NSURL URLWithString:albumModel.pic_radio]];
    self.titleLabel.text = albumModel.title;
    self.tagLabel.text = albumModel.author;
    self.listenumLabel.text = [NSString stringWithFormat:@"%@发行",albumModel.publishtime];
    self.descLabel.text = albumModel.info;
}
#pragma mark - setUp
- (instancetype)initWithFullHead:(BOOL)full {
    if (self = [super init]) {
        [self setUpHeadView];
        [self setUpButtons];
        [self setUpDescLabel];
        self.isFullImage = full;
        //self.tintColor = [UIColor whiteColor];
    }
    return self;
    
}
- (void)setUpHeadView {
    self.picView = [ZJGCreateTool imageViewWithView:self];
    self.titleLabel = [ZJGCreateTool labelWithView:self];
    self.titleLabel.font = ZJGBigFont;
    self.titleLabel.numberOfLines = 0;
    self.tagLabel = [ZJGCreateTool labelWithView:self];
    self.tagLabel.font = ZJGMiddleFont;
    self.listenumLabel = [ZJGCreateTool labelWithView:self];
    self.listenumLabel.font = ZJGMiddleFont;
}
- (void)setUpButtons {
    self.collectButton = [ZJGCreateTool buttonWithView:self image:[[UIImage imageNamed:@"icon_ios_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]  state:UIControlStateNormal];
    [self.collectButton addTarget:self action:@selector(clickCollectButton) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton = [ZJGCreateTool buttonWithView:self image:[[UIImage imageNamed:@"icon_ios_export"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]  state:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(clickShareButton) forControlEvents:UIControlEventTouchUpInside];
    self.likeButton = [ZJGCreateTool buttonWithView:self image:[[UIImage imageNamed:@"icon_ios_heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] state:UIControlStateNormal];
    [self.likeButton setImage:[[UIImage imageNamed:@"icon_ios_heart_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
    [self.likeButton addTarget:self action:@selector(clickLikeButton) forControlEvents:UIControlEventTouchUpInside];
    self.listButton = [ZJGCreateTool buttonWithView:self image:[[UIImage imageNamed:@"icon_ios_list"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] state:UIControlStateNormal];
    [self.listButton addTarget:self action:@selector(clickListButton) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setUpDescLabel {
    self.descLabel = [ZJGCreateTool labelWithView:self];
    self.descLabel.font = ZJGMiddleFont;
    self.descLabel.numberOfLines = 0;
}
#pragma mark - layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutDescLabel];
    [self layoutButtons];
    self.isFullImage ? [self layoutBigImageAndLabel] : [self layoutSmallImageAndLabel];
}
- (void)layoutBigImageAndLabel {
    self.listenumLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.tagLabel.textColor = [UIColor whiteColor];
    self.descLabel.textColor = [UIColor whiteColor];
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ZJGScreenWidth, ZJGScreenWidth));
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
    [self.listenumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ZJGHorizontalSpacing);
        make.bottom.equalTo(self.descLabel.mas_top).offset(-1 * ZJGVerticalSpacing);
        make.width.mas_equalTo(ZJGScreenWidth * 0.5);
        make.height.mas_equalTo(20);
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.listenumLabel);
        make.bottom.equalTo(self.listenumLabel.mas_top).offset(-0.5 *ZJGVerticalSpacing);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tagLabel.mas_top).offset(-0.5 * ZJGVerticalSpacing);
        make.left.equalTo(self.mas_left).offset(ZJGHorizontalSpacing);
        make.right.equalTo(self.mas_right).offset(-ZJGHorizontalSpacing);
        make.height.mas_equalTo(20);
    }];
}
- (void)layoutSmallImageAndLabel {
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(ZJGHorizontalSpacing);
        make.bottom.equalTo(self.descLabel.mas_top).offset(-1 * ZJGVerticalSpacing);
        make.width.equalTo(self.picView.mas_height);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picView.mas_top).offset(ZJGVerticalSpacing);
        make.left.equalTo(self.picView.mas_right).offset(ZJGHorizontalSpacing);
        make.right.equalTo(self.mas_right).offset(- ZJGHorizontalSpacing);
        make.height.mas_equalTo(40);
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(ZJGVerticalSpacing);
        make.left.and.right.equalTo(self.titleLabel);
    }];
    [self.listenumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLabel.mas_bottom).offset(ZJGVerticalSpacing);
        make.left.and.right.equalTo(self.tagLabel);
    }];
}
- (void)layoutButtons {
    [self.listButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.mas_right).offset(-1 * ZJGHorizontalSpacing);
        make.bottom.equalTo(self.descLabel.mas_top).offset(-1 * ZJGHorizontalSpacing);
    }];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20)); make.right.mas_equalTo(self.listButton.mas_left).offset(-1 * ZJGHorizontalSpacing);
        make.bottom.equalTo(self.listButton.mas_bottom);
    }];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.likeButton.mas_left).offset(-1 * ZJGHorizontalSpacing);
        make.bottom.equalTo(self.listButton.mas_bottom);
    }];
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.shareButton.mas_left).offset(-1 * ZJGHorizontalSpacing);
        make.bottom.equalTo(self.listButton.mas_bottom);
    }];
}
//约束一定要添加够
- (void)layoutDescLabel {
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ZJGHorizontalSpacing);
        make.bottom.equalTo(self.mas_bottom).offset(-ZJGVerticalSpacing);
        make.right.equalTo(self.mas_right).offset(-1 * ZJGHorizontalSpacing);
        make.height.mas_offset(60);
    }];
}
#pragma mark - clickButtons
- (void)clickCollectButton {
    ZJGLog(@"clickCollectButton");
    [ZJGPromptTool promptModeText:@"已添加至播放列队" afterDelay:1.0];
}
- (void)clickShareButton {
    ZJGLog(@"clickShareButton");
    [ZJGPromptTool promptModeText:@"分享功能待完善中" afterDelay:1.0];
}
- (void)clickLikeButton {
    ZJGLog(@"clickLikeButton");
    [ZJGPromptTool promptModeText:@"已添加到收藏" afterDelay:1.0];
}
- (void)clickListButton {
    ZJGLog(@"clickListButton");
    [ZJGPromptTool promptModeText:@"抱歉！暂无详细信息" afterDelay:1.0];
}
@end
