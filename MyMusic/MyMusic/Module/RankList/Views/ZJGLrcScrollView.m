//
//  ZJGLrcScrollView.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/10.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGLrcScrollView.h"
#import "ZJGLrcTableViewCell.h"
#import "ZJGLrcLabel.h"
#import "ZJGLrcModel.h"
//添加扩展增加属性
@interface ZJGLrcScrollView ()<UITableViewDataSource>
/** 滑动视图 */
@property (nonatomic, weak ) UITableView *tableView;
/** 当前索引 */
@property (nonatomic, assign ) NSInteger currentIndex;
@end
@implementation ZJGLrcScrollView
- (instancetype)init {
    if (self = [super init]) {
        [self setupTableView];
    }
    return self;
}
- (void)setupTableView {
    self.tableView = [ZJGCreateTool tableViewWithView:self];
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 35;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.height.equalTo(self.mas_height).offset(-20);
        make.left.equalTo(self.mas_left).offset(ZJGScreenWidth);
        make.width.equalTo(self.mas_width);
    }];
}
#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lrcArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJGLrcTableViewCell *cell = [ZJGLrcTableViewCell lrcCellWithTableView:tableView];
    if (indexPath.row == self.currentIndex) {
        cell.lrcLabel.font = ZJGTitleFont;
    } else {
        cell.lrcLabel.font = ZJGBigFont;
        cell.lrcLabel.progress = 0;
    }
    ZJGLrcModel *lrcModel = self.lrcArray[indexPath.row];
    cell.lrcLabel.text = lrcModel.text;
    return cell;
}
#pragma mark - setter - NSStringToTime
- (void)setCurrentTime:(NSTimeInterval)currentTime {
    _currentTime = currentTime;
    //找出对应时间的歌词
    NSInteger count = self.lrcArray.count;
    for (NSInteger i = 0; i < count; i++) {
        ZJGLrcModel *currentLrcLine = self.lrcArray[i];
        //下一句
        NSInteger nextIndex = i + 1;
        //歌曲播放完毕
        if (nextIndex > count - 1) {
            return;
        }
        ZJGLrcModel *nextLrcLine = self.lrcArray[nextIndex];
        //对比两句歌词时间,处理歌曲快进的情况
        if (currentTime >= currentLrcLine.time && currentTime < nextLrcLine.time && self.currentIndex !=i) {
            //上一句
            NSMutableArray *indexes = [NSMutableArray array];
            if (self.currentIndex < count -1) {
                NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
                [indexes addObject:previousIndexPath];
            }
            //当前句
            self.currentIndex = i;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [indexes addObject:indexPath];
            [self.tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationNone];
            //当前句居中
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
        if (self.currentIndex == i) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            ZJGLrcTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.lrcLabel.progress = (currentTime -currentLrcLine.time) / (nextLrcLine.time - currentLrcLine.time);
        }
    }
}
- (void)setLrcArray:(NSArray *)lrcArray {
    _lrcArray = lrcArray;
    [self.tableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
