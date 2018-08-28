//
//  ZJGTableViewCell.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/24.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGTableViewCell.h"
#import "ZJGCellIconModel.h"
#import "ZJGSongDetailModel.h"
#import "ZJGCellMenuItemButton.h"
//#import "NAKPlaybackIndicatorView.h"
//添加扩展
@interface ZJGTableViewCell ()
/** 展示cell的View */
@property (nonatomic, weak ) UIView *cellContentView;
/** cell行号label */
@property (nonatomic, weak ) UILabel *numLabel;
/** 歌名 */
@property (nonatomic, weak ) UILabel *songNameLabel;
/** 歌手名 */
@property (nonatomic, weak ) UILabel *authorLabel;
/** 专辑名 */
@property (nonatomic, weak ) UILabel *album_titleLabel;
/** 小图片 */
@property (nonatomic, weak ) UIImageView *pic_SmallView;
/** 播放引导标志 */
@property (nonatomic, weak ) NAKPlaybackIndicatorView *indicatorView;
/** 分割线 */
@property (nonatomic, weak ) UIView *lineView;
/** 显示下拉菜单的View */
@property (nonatomic, weak ) UIView *cellOpenedMenuView;
/** 是否为加载的菜单 */
@property (nonatomic, assign ) BOOL isLoadedMenu;
/** cell菜单条数组 */
@property (nonatomic, strong ) NSArray *cellMenuItemArray;
@end
@implementation ZJGTableViewCell
//cell开启时button间距
static NSInteger const ItemPadding = 10;
//cell开启时button的个数
static NSInteger const ItemNum = 5;
#pragma mark - setterAndgetter
- (NAKPlaybackIndicatorViewState)indicatorViewState{
    return self.indicatorView.state;
}
-(void)setIndicatorViewState:(NAKPlaybackIndicatorViewState)indicatorViewState {
    self.indicatorView.state = indicatorViewState;
    self.numLabel.hidden = (indicatorViewState != NAKPlaybackIndicatorViewStateStopped);
    
}
//getter方法
- (NSArray *)cellMenuItemArray {
    if (!_cellMenuItemArray) {
        _cellMenuItemArray = [ZJGCellIconModel CellMenuItemArray];
    }
    return _cellMenuItemArray;
    
}
//setter方法
- (void)setDetailModel:(ZJGSongDetailModel *)detailModel {
    _detailModel = detailModel;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.detailModel.num];
    NSString *image = [NSString stringWithFormat:@"cm2_daily_banner%d",arc4random() % 6 + 1];
    if (self.bePic) {
        
        [self.pic_SmallView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.pic_small] placeholderImage:[UIImage imageNamed:image]];
    } else {
        self.pic_SmallView.image = [UIImage imageNamed:image];
    }
    self.songNameLabel.text = self.detailModel.title;
    self.authorLabel.text = [NSString stringWithFormat:@"%@    %@",self.detailModel.author,self.detailModel.album_title];

}
#pragma mark - setUpCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //不设置会全部显示为下拉菜单
        self.layer.masksToBounds = YES;
       self.clipsToBounds = YES;
        
         self.selectionStyle = UITableViewCellEditingStyleNone;
        [self setUpCellContentView];
        [self setUpButtonAndLine];
        //创建播放引导标志
        [self setUpMusicIndicatorView];
        //创建cell下拉菜单
        self.cellOpenedMenuView = [ZJGCreateTool viewWithView:self.cellContentView];
        self.cellOpenedMenuView.backgroundColor = [UIColor clearColor];
        self.tintColor = ZJGTintColor;
    }
    return self;

}
- (void)setUpMusicIndicatorView {
    NAKPlaybackIndicatorView *indicatorView = [[NAKPlaybackIndicatorView alloc] init];
    [self.cellContentView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    self.indicatorView.tintColor = ZJGRandomColor;//随机颜色
    UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] init]initWithTarget:self action:@selector(clickIndicatorView)];
    [self.indicatorView addGestureRecognizer:tapGesture];
}
- (void)setUpCellContentView {
    self.cellContentView = [ZJGCreateTool viewWithView:self];
    self.numLabel = [ZJGCreateTool labelWithView:self.cellContentView];
    self.numLabel.textColor = ZJGNumColor;
    self.pic_SmallView = [ZJGCreateTool imageViewWithView:self.cellContentView];
    self.songNameLabel = [ZJGCreateTool labelWithView:self.contentView];
    self.songNameLabel.textColor = ZJGArtistColor;
    self.authorLabel = [ZJGCreateTool labelWithView:self.cellContentView];
    self.authorLabel.font = ZJGMiddleFont;
    self.authorLabel.textColor = ZJGTextColor;
    
}
//设置cell上的按钮和分割线
- (void)setUpButtonAndLine {
    self.menuButton = [ZJGCreateTool buttonWithView:self.cellContentView];
    [self.menuButton setImage:[[UIImage imageNamed:@"icon_ios_more_tiny"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.menuButton addTarget:self action:@selector(clickCellMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    self.lineView = [ZJGCreateTool viewWithView:self.cellContentView];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
}
- (void)clickCellMenuButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(clickCellMenuButton:openMenuOfCell:)]) {
        ZJGLog(@"展开菜单");
        self.isOpenMenu = !self.isOpenMenu;
        [self.delegate clickCellMenuButton:button openMenuOfCell:self];
        
    }
}

#pragma mark - reuseCell
+ (instancetype)TableViewCellcellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"cell";
    ZJGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[ZJGTableViewCell alloc] initWithFrame:CGRectMake(0, 0, ZJGScreenWidth, 50)];
    }
    return cell;
    
}
#pragma mark - createCellMenu
- (void)setUpCellOpenedMenuView {
    if (!self.isLoadedMenu) {
        CGFloat MenuItmeWidth = (ZJGScreenWidth - ItemPadding * (ItemNum + 1)) / ItemNum;
        __weak __typeof(self) weakSelf = self;
        for (NSInteger i = 0; i < ItemNum; i ++) {
            ZJGCellIconModel *iconModel = self.cellMenuItemArray[i];
            CGRect rect = CGRectMake(ItemPadding + (ItemPadding + MenuItmeWidth) * i, 0, MenuItmeWidth, 44);
            ZJGCellMenuItemButton *button = [[ZJGCellMenuItemButton alloc] initWithFrame:rect model:iconModel];
            button.tag = i;
            [button addTarget:self action:@selector(clickCellMenuItemButton:) forControlEvents:UIControlEventTouchUpInside];
            [weakSelf.cellOpenedMenuView addSubview:button];
        }
    }
    self.isLoadedMenu = YES;
}
#pragma mark - TableViewCellDelegate
- (void)clickCellMenuItemButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(clickCellMenuItemButtonAtIndex:Cell:)]) {
        [self.delegate clickCellMenuItemButtonAtIndex:button.tag Cell:self];
    }
}
- (void)clickIndicatorView {
    if ([self.delegate respondsToSelector:@selector(clickIndicatorView)]) {
        [self.delegate clickIndicatorView];
    }
}
#pragma mark layoutCell
- (void)layoutSubviews {
    [self.cellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(ZJGScreenWidth);
        make.height.mas_equalTo(100);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellContentView.mas_left).offset(ZJGHorizontalSpacing);
        make.top.equalTo(self.cellContentView.mas_top).offset(ZJGVerticalSpacing);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [self.pic_SmallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_right).offset(-1 *ZJGVerticalSpacing);
        make.top.equalTo(self.cellContentView.mas_top).offset(ZJGCommonSpacing);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [self.songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pic_SmallView.mas_right).offset(ZJGCommonSpacing);
        make.top.equalTo(self.cellContentView.mas_top).offset(ZJGVerticalSpacing);
        make.right.equalTo(self.menuButton.mas_left);
        make.bottom.equalTo(self.authorLabel.mas_top);
    }];
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.songNameLabel.mas_bottom);
        make.left.equalTo(self.songNameLabel.mas_left);
        make.right.equalTo(self.songNameLabel.mas_right);
        make.bottom.equalTo(self.lineView.mas_bottom).offset(-1 * ZJGVerticalSpacing);
    }];
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.songNameLabel.mas_right);
        make.centerY.equalTo(self.numLabel.mas_centerY);
        make.right.equalTo(self.cellContentView.mas_right).offset(-1 * ZJGHorizontalSpacing);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellContentView.mas_left).offset(ZJGVerticalSpacing);
        make.right.equalTo(self.cellContentView.mas_right);
        make.top.equalTo(self.cellContentView.mas_top).offset(49);
        make.height.mas_equalTo(1);
    }];
    [self.cellOpenedMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellContentView.mas_top).offset(50);
        make.left.and.right.equalTo(self.cellContentView);
        make.height.mas_equalTo(50);
    }];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellContentView.mas_left).offset(5);
        make.top.equalTo(self.cellContentView.mas_top).offset(3);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
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
