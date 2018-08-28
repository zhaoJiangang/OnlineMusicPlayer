//
//  ZJGNavigationController.m
//  My Music
//
//  Created by 赵建钢 on 2018/2/21.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGNavigationController.h"
#import "ZJGPlayingViewController.h"

@interface ZJGNavigationController ()

@end

@implementation ZJGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setUpMusicIndicatorView];
}
- (void)setUpMusicIndicatorView {
    ZJGMusicIndicatorView *indicatorView = [ZJGMusicIndicatorView sharedIndicatorView];
    indicatorView.hidesWhenStopped = NO;
    indicatorView.tintColor = ZJGMainColor;
    if (indicatorView.state != NAKPlaybackIndicatorViewStatePlaying) {
        indicatorView.state = NAKPlaybackIndicatorViewStatePaused;
    } else {
        indicatorView.state = NAKPlaybackIndicatorViewStatePlaying;
    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMusicIndicatorView)];
    [indicatorView addGestureRecognizer:tapGesture];
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationBar addSubview:indicatorView];
}
- (void)clickMusicIndicatorView {
    ZJGPlayingViewController *viewController = [ZJGPlayingViewController sharedPlayingViewController];
    if (!viewController.currentMusic) {
        [ZJGPromptTool promptModeText:@"没有正在播放的歌曲" afterDelay:1.0];
        return;
    }
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    self.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.tabBarController.tabBar.hidden = NO;
    ZJGTintColor = ZJGMainColor;
    return [super popViewControllerAnimated:animated];
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 0) {
        ZJGTintColor = ZJGRandomColor;
        viewController.navigationController.navigationBar.tintColor = ZJGTintColor;
        viewController.tabBarController.tabBar.hidden = YES;
    }
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
