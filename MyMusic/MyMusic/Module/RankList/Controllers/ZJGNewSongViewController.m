//
//  ZJGNewSongViewController.m
//  My Music
//
//  Created by 赵建钢 on 2018/2/21.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGNewSongViewController.h"
#import "ZJGMusicTablesModel.h"
#import "ZJGCollectionViewCell.h"
#import "ZJGNewSongListViewController.h"

@interface ZJGNewSongViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 歌曲专辑数组 */
@property (nonatomic, strong ) NSMutableArray *SongAlbumArrayM;
/** 歌曲专辑集合视图 */
@property (nonatomic, strong ) UICollectionView *songAlbumCollectionView;
@end

@implementation ZJGNewSongViewController
static NSString *reusedId = @"newSong";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.songAlbumCollectionView.backgroundColor = [UIColor whiteColor];
    
}
- (NSMutableArray *)SongAlbumArrayM {
    if (!_SongAlbumArrayM) {
        _SongAlbumArrayM = [NSMutableArray array];
        [self loadNewSongData];
    }
    return _SongAlbumArrayM;
}

//http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.plaza.getRecommendAlbum&offset=0&limit=50&type=2
#pragma mark - load data
- (void)loadNewSongData {
    [ZJGNetWorkTool netWorkToolGetWithUrl:ZJGUrl parameters:ZJGParams(@"method":@"baidu.ting.plaza.getRecommendAlbum",@"offset":@0,@"limit":@50,@"type":@2) response:^(id response) {
        for (NSDictionary *dict in response[@"plaze_album_list"][@"RM"][@"album_list"][@"list"]) {
            //通过字典来创建一个模型
            ZJGMusicTablesModel *table = [ZJGMusicTablesModel mj_objectWithKeyValues:dict];
            [self.SongAlbumArrayM addObject:table];
        }
        [self.songAlbumCollectionView reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    self.songAlbumCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.songAlbumCollectionView registerClass:[ZJGCollectionViewCell class] forCellWithReuseIdentifier:reusedId];
    self.songAlbumCollectionView.delegate = self;
    self.songAlbumCollectionView.dataSource = self;
    [self.view addSubview:self.songAlbumCollectionView];
    
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.SongAlbumArrayM.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJGMusicTablesModel *musicTable = self.SongAlbumArrayM[indexPath.row];
    ZJGCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedId forIndexPath:indexPath];
    [collectionViewCell setNewSongAlbum:musicTable];
    return collectionViewCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJGMusicTablesModel *tables = self.SongAlbumArrayM[indexPath.row];
    ZJGLog(@"歌曲专辑Id:%@",tables.album_id);
    ZJGNewSongListViewController *songListViewController = [[ZJGNewSongListViewController alloc] init];
    songListViewController.album_id = tables.album_id;
    songListViewController.picture = tables.pic_big;
    [self.navigationController pushViewController:songListViewController animated:YES];
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = ZJGScreenWidth /2;
    ZJGLog(@"cell宽度为:%ld",width);
    CGSize size = CGSizeMake(width, width + 40);
    return size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
