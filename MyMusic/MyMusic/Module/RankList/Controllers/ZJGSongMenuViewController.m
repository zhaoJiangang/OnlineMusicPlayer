//
//  ZJGSongMenuViewController.m
//  My Music
//
//  Created by 赵建钢 on 2018/2/21.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGSongMenuViewController.h"
#import "ZJGCollectionViewCell.h"
#import "ZJGMusicTablesModel.h"
#import "ZJGSongListViewController.h"
@interface ZJGSongMenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 歌单数组*/
@property (nonatomic ,strong) NSMutableArray *songMenuArrayM;
/** 歌单集合视图*/
@property (nonatomic ,strong) UICollectionView *songMenuCollectionView;
/** 歌单页数*/
@property (nonatomic, assign) NSInteger songMenuPage;

@end

@implementation ZJGSongMenuViewController
//本质：const在谁后面谁就不可修改，const在最前面则将其后移一位即可，二者等效;静态全局变量则限制了其作用域， 即只在定义该变量的源文件内有效， 在同一源程序的其它源文件中不能使用它;开发使用场景:在一个文件中经常使用的字符串常量，可以使用static与const组合
static NSString *const reusedId = @"songMenu";
#pragma mark - setterArray
/** 懒加载:
 本质是重写getter方法;
 用到时候再加载,而且只加载一次;
 */

- (NSMutableArray *)songMenuArrayM {
    if (!_songMenuArrayM) {
        _songMenuArrayM = [NSMutableArray array];
        self.songMenuPage = 1;
        //加载数据
        [self loadSongMenuWithPage:self.songMenuPage array:self.songMenuArrayM reloadView:self.songMenuCollectionView];
    }
    return _songMenuArrayM;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.songMenuCollectionView.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSongMenuCollectionView];
    [self setUpRefreshFooter];
    [self setUpRefreshHeader];
}
#pragma mark - setUpCollecitonView
- (void)setUpSongMenuCollectionView {
    //创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置横向间距最小
    layout.minimumInteritemSpacing = 0;
    
    self.songMenuCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.songMenuCollectionView registerClass:[ZJGCollectionViewCell class] forCellWithReuseIdentifier:reusedId];
    //设置代理数据源
    self.songMenuCollectionView.delegate = self;
    self.songMenuCollectionView.dataSource = self;
    [self.view addSubview:self.songMenuCollectionView];
}
- (void)setUpRefreshFooter {
    __weak __typeof(self) weakSelf = self;
    self.songMenuCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.songMenuPage += 1;
        //下载数据
        [self loadSongMenuWithPage:weakSelf.songMenuPage array:weakSelf.songMenuArrayM reloadView:weakSelf.songMenuCollectionView];
        self.songMenuCollectionView.mj_footer.hidden = YES;
        
    }];
}
-(void)setUpRefreshHeader {
    __weak typeof(self) WeakSelf = self;
    self.songMenuCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.songMenuPage = 1;
        [self loadSongMenuWithPage:WeakSelf.songMenuPage array:WeakSelf.songMenuArrayM reloadView:WeakSelf.songMenuCollectionView];
        [self.songMenuCollectionView reloadData];
        [self.songMenuCollectionView.mj_header endRefreshing];
    }];
}
#pragma mark - collectionViewDelegate
//设置集合视图流式布局的分区数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.songMenuCollectionView.mj_footer.hidden = self.songMenuArrayM.count == 0;
    return self.songMenuArrayM.count;
    
}
//设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJGMusicTablesModel *musicTable = self.songMenuArrayM[indexPath.row];
    ZJGCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedId forIndexPath:indexPath];
    [collectionCell setSongMenu:musicTable];
    
    return collectionCell;
    
}
//点中cell执行的逻辑
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJGMusicTablesModel *tables = self.songMenuArrayM[indexPath.row];
    ZJGLog(@"歌单id:%@",tables.listid);
    ZJGSongListViewController *listViewController = [[ZJGSongListViewController alloc] init];
    listViewController.listid = tables.listid;
    listViewController.picture = tables.pic_300;
    [self.navigationController pushViewController:listViewController animated:YES];
}
#pragma mark - layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = ZJGScreenWidth / 2;
    ZJGLog(@"CollectionViewCell的宽度为:%ld",(long)width);
    CGSize size = CGSizeMake(width, width + 40);
    return size;
    
}

#pragma mark - loadData
//下载数据
//json拼接格式url?key=value&
//http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedan&page_no=1&page_size=30
- (void)loadSongMenuWithPage:(NSInteger)page array:(NSMutableArray *)array reloadView:(UICollectionView *)view {
    [ZJGNetWorkTool netWorkToolGetWithUrl:ZJGUrl parameters:@{@"method":@"baidu.ting.diy.gedan",@"page_no":[NSString stringWithFormat:@"%ld",page],@"page_size":@"30"} response:^(id response) {
        for (NSDictionary *dict in response[@"content"]) {
            ZJGMusicTablesModel *tables = [ZJGMusicTablesModel mj_objectWithKeyValues:dict];
            [array addObject:tables];
            [view reloadData];
        }
        
    }];
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
