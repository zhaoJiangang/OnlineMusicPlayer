//
//  ZJGTabBarController.m
//  My Music
//
//  Created by 赵建钢 on 2018/2/21.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGTabBarController.h"
#import "ZJGSearchTableViewController.h"
#import "ZJGNewSongViewController.h"
#import "ZJGRankListTableViewController.h"
#import "ZJGSongMenuViewController.h"
#import "ZJGNavigationController.h"

@interface ZJGTabBarController ()

@end

@implementation ZJGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.(加载视图之后做一些额外的构建)
    //创建四个模块的控制器
    ZJGSongMenuViewController *songMenu = [[ZJGSongMenuViewController alloc] init];
    [self addChildViewController:songMenu WithTitle:@"歌单" image:@"songList_normal" selectedImage:@"songList_highLighted"];
    ZJGNewSongViewController *newSong = [[ZJGNewSongViewController alloc] init];
    [self addChildViewController:newSong WithTitle:@"新曲" image:@"songNewList_normal" selectedImage:@"songNewList_highLighted"];
    ZJGSearchTableViewController *search = [[ZJGSearchTableViewController alloc] init];
    [self addChildViewController:search WithTitle:@"搜索" image:@"songSearch_normal" selectedImage:@"songSearch_highLighted"];
    ZJGRankListTableViewController *rankList = [[ZJGRankListTableViewController alloc] init];
    [self addChildViewController:rankList WithTitle:@"排行" image:@"songRank_normal" selectedImage:@"songRank_highLighted"];
    
    
    
}
//封装一个添加子控制器的方法
- (void)addChildViewController:(UIViewController *)childViewController WithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    //添加导航控制器
    ZJGNavigationController *navigationController = [[ZJGNavigationController alloc] initWithRootViewController:childViewController];
    childViewController.title = title;
    childViewController.tabBarItem.image = [UIImage imageNamed:image];
    //将图片原始的样子显示出来,不自动渲染为其它颜色
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSMutableDictionary *text = [NSMutableDictionary dictionary];
    //设置文字颜色
    text[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = [UIColor colorWithRed:252/255.0 green:12/255.0 blue:68/255.0 alpha:1.0];
    [childViewController.tabBarItem setTitleTextAttributes:text forState:UIControlStateNormal];
    [childViewController.tabBarItem setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    [self addChildViewController:navigationController];
    
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
