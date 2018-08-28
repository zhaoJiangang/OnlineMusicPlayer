//
//  ZJGPlayingViewController.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/3.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGPlayingViewController.h"
#import "ZJGLrcScrollView.h"
#import <MediaPlayer/MediaPlayer.h>
//#import <AVFoundation/AVFoundation.h>
#import "ZJGPlayMusicTool.h"
#import "ZJGMusicModel.h"
#import "ZJGLrcTool.h"
typedef NS_ENUM(NSInteger) {
    CyclicMode = 0,
    RandomMode,
    SingleMode
}playMode;
@interface ZJGPlayingViewController ()<UIScrollViewDelegate>
/** 播放器背景图 */
@property (nonatomic, weak ) UIImageView *backgroundImageView;

/** 歌曲图片 */
@property (nonatomic, weak ) UIImageView *musicImageView;
/** 进度条 */
@property (nonatomic, weak ) UISlider *progressSlider;
/** 定时器 */
@property (nonatomic, strong ) NSTimer *progressTimer;

@property (nonatomic, weak ) UIView *playingItemView;
/** 显示歌曲当前时间的label */
@property (nonatomic, weak ) UILabel *currentTimeLabel;
/** 歌曲总时间label */
@property (nonatomic, weak ) UILabel *totalTimeLabel;
/** 显示歌名的label */
@property (nonatomic, weak ) UILabel *songNameLabel;
/** 歌手名 */
@property (nonatomic, weak ) UILabel *authorNameLabel;
/** 添加为喜欢 */
@property (nonatomic, weak ) UIButton *likeButton;
/** 上一曲 */
@property (nonatomic, weak ) UIButton *previousButton;
/** 下一曲 */
@property (nonatomic, weak ) UIButton *nextButton;
/** 播放/暂停 */
@property (nonatomic, weak ) UIButton *playOrPauseButton;
/** 返回菜单 */
@property (nonatomic, weak ) UIButton *backMenuButton;
/** 分享 */
@property (nonatomic, weak ) UIButton *shareButton;
/** 随机播放 */
@property (nonatomic, weak ) UIButton *randomButton;
/** 单曲循环 */
@property (nonatomic, weak ) UIButton *SingleCyclicButton;
/** 更多选项 */
@property (nonatomic, weak ) UIButton *moreChoiceButton;
/** 滚动歌词 */
@property (nonatomic, strong ) ZJGLrcScrollView *lrcScrollView;
/** 歌词定时器 */
@property (nonatomic, strong ) CADisplayLink *lrcTimer;
/** 播放条 */
@property (nonatomic, strong ) AVPlayerItem *playingItem;
/** 歌曲地址数组 */
@property (nonatomic, copy ) NSMutableArray *songIdArrayM;
/** 播放索引 */
@property (nonatomic, assign ) NSInteger playingIndex;
/** 播放模式 */
@property (nonatomic, assign ) playMode playMode;
/** 分页控制器 */
@property (nonatomic, strong ) UIPageControl *pageControl;
@end

@implementation ZJGPlayingViewController
static void *PlayingModeKVOKey = &PlayingModeKVOKey;
static void *IndicatorStateKVOKey = &IndicatorStateKVOKey;
static ZJGMusicIndicatorView *_indicatorView;
#pragma mark - getSongId
- (void)setSongIdArray:(NSMutableArray *)arry currentIndex:(NSInteger)index {
    self.songIdArrayM = arry;
    self.playingIndex = index;
    [self loadSongDetail];
    [self setUpKVO];
    if (!self.view) {
        [self setUpView];
        [self setUpLrcScrollView];
        [self setUpSlider];
        [self setUpLabelInPlayingItemView];
        [self setUpButtonInPlayingItemView];
        [self settingView];
        [self addProgressTimer];
        [self addLrcTimer];
    
    }
    
}
#pragma mark - KVO
- (void)setUpKVO {
    [self addObserver:self forKeyPath:@"currentMusic" options:NSKeyValueObservingOptionNew context:PlayingModeKVOKey];
    [_indicatorView addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:IndicatorStateKVOKey];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if(context == PlayingModeKVOKey) {
        ZJGLog(@"变化为:%@",[change objectForKey:@"new"]);
        ZJGMusicModel *new = [change objectForKey:@"new"];
        self.playingItem = [ZJGPlayMusicTool playMusicWithLink:new.showLink];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playingItem];
    } else if (context == IndicatorStateKVOKey) {
        ZJGLog(@"播放状态");
        [self refreshIndicatorViewState];
    }

}

- (void)playerItemAction:(AVPlayerItem *)item {
    [self clickNextButton];
}


+ (instancetype)sharedPlayingViewController {
    static ZJGPlayingViewController *_playingViewController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playingViewController = [[ZJGPlayingViewController alloc] init];
    });
    return _playingViewController;
}
- (void)clickIndicatorView {
    
    [self clickPlayOrPauseButton];
}



#pragma mark - delegate:refreshCellIndicatorView
- (void)refreshIndicatorViewState {
    if ([self.delegate respondsToSelector:@selector(updateIndicatorViewOfVisibleCells)]) {
        [self.delegate updateIndicatorViewOfVisibleCells];
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //修改透明度
    CGFloat scale = scrollView.contentOffset.x /scrollView.frame.size.width;
    self.musicImageView.alpha = 1.0 - scale;
    //设定currentPage是0还是1
    NSInteger pageValue = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    self.pageControl.currentPage = pageValue;
}
//http://ting.baidu.com/data/music/links
#pragma mark - loadSongDetail
- (void)loadSongDetail {
    [ZJGNetWorkTool netWorkToolGetWithUrl:ZJGMusic parameters:@{@"songIds":self.songIdArrayM[self.playingIndex]} response:^(id response) {
        NSMutableArray *arrayM = response[@"data"][@"songList"];
        ZJGLog(@"------>成功获取");
        self.currentMusic = [ZJGMusicModel mj_objectWithKeyValues:arrayM.firstObject];
        [self settingView];
       
    }];
    
}
#pragma mark - settingView
- (void)settingView {
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.currentMusic.songPicRadio] placeholderImage:[UIImage imageNamed:@"lyric-sharing-background-7"]];
    [self.musicImageView sd_setImageWithURL:[NSURL URLWithString:self.currentMusic.songPicRadio] placeholderImage:[UIImage imageNamed:@"lyric-sharing-background-5"]];
    self.songNameLabel.text = self.currentMusic.songName;
    self.authorNameLabel.text = [NSString stringWithFormat:@"%@   %@",self.currentMusic.artistName,self.currentMusic.albumName];
    [ZJGLrcTool lrcToolDownloadWithUrl:self.currentMusic.lrcLink setUpLrcView:self.lrcScrollView];
    self.playOrPauseButton.selected = YES;
}

#pragma mark - viewLoadAndLayout
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpView];
    [self setUpLrcScrollView];
    [self setUpSlider];
    [self setUpLabelInPlayingItemView];
    [self setUpButtonInPlayingItemView];
    [self settingView];
    [self addProgressTimer];
    [self addLrcTimer];
    //后台播放被打断
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickPlayOrPauseButton) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutViews];
    [self layoutLabelAndButtons];
}

- (void)layoutViews {
    [self.musicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width);
    }];
    [self.lrcScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width);
    }];
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.pageControl.mas_bottom).offset(ZJGVerticalSpacing);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(5);
    }];
    [self.playingItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressSlider.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
}
- (void)layoutLabelAndButtons {
    [self.songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.currentTimeLabel.mas_bottom).offset(ZJGCommonSpacing);
    }];
    
    [self.authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.songNameLabel.mas_bottom).offset(ZJGVerticalSpacing);
    }];
    [self.playingItemView distributeViewsHorizontallyWith:@[self.currentTimeLabel,self.totalTimeLabel] margin:ZJGCommonSpacing];
    [self.playingItemView distributeViewsVerticallyWith:@[self.currentTimeLabel,self.likeButton,self.shareButton] margin:ZJGCommonSpacing];
    [self.playingItemView distributeViewsHorizontallyWith:@[self.likeButton,self.previousButton,self.playOrPauseButton,self.nextButton,self.backMenuButton] margin:ZJGHorizontalSpacing];
    [self.playingItemView distributeViewsHorizontallyWith:@[self.shareButton,self.randomButton,self.SingleCyclicButton,self.moreChoiceButton] margin:ZJGHorizontalSpacing];
}
- (void)setUpView {
    self.backgroundImageView = [ZJGCreateTool imageViewWithView:self.view];
    self.backgroundImageView.frame = self.view.frame;
    [ZJGBlurViewTool blurView:self.backgroundImageView sytle:UIBarStyleDefault];
    self.musicImageView = [ZJGCreateTool imageViewWithView:self.view];
    self.playingItemView = [ZJGCreateTool viewWithView:self.view];
    
}
- (void)setUpLrcScrollView {
    ZJGLrcScrollView *scrollView = [[ZJGLrcScrollView alloc] init];
    scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.lrcScrollView = scrollView;
    self.lrcScrollView.contentSize = CGSizeMake(ZJGScreenWidth * 2, 0);
   
    //添加Pagecontrol
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ZJGScreenWidth, ZJGScreenWidth, 30)];
    self.pageControl.numberOfPages = 2;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    [self.view addSubview:self.pageControl];
}

- (void)setUpSlider {
    UISlider *slider = [[UISlider alloc] init];
    [slider setMinimumTrackTintColor:ZJGMainColor];
    [slider setMaximumTrackTintColor:ZJGTextColor];
    
    [slider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    self.progressSlider = slider;
}
- (void)sliderValueChanged:(UISlider *)slider {
    if (!_playingItem) {
        return;
    }
    self.currentTimeLabel.text = [self setUpTimeStringWithTime:slider.value];
    CMTime dragCMtime = CMTimeMake(slider.value, 1);
    [ZJGPlayMusicTool setUpCurrentPlayingTime:dragCMtime link:self.currentMusic.songLink];
    //按钮状态变为播放状态
    self.playOrPauseButton.selected = YES;
}
//时间转字符串
- (NSString *)setUpTimeStringWithTime:(NSTimeInterval)time {
    int minute = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute,second];
}

- (void)setUpLabelInPlayingItemView {
    self.currentTimeLabel = [ZJGCreateTool labelWithView:self.playingItemView size:CGSizeMake(40, 20)];
    self.currentTimeLabel.font = ZJGMiddleFont;
    self.totalTimeLabel = [ZJGCreateTool labelWithView:self.playingItemView size:CGSizeMake(40, 20)];
    self.totalTimeLabel.font = ZJGMiddleFont;
    self.songNameLabel = [ZJGCreateTool labelWithView:self.playingItemView size:CGSizeMake(ZJGScreenWidth - ZJGHorizontalSpacing, 40)];
    self.songNameLabel.font = ZJGTitleFont;
    self.songNameLabel.textAlignment = NSTextAlignmentCenter;
    self.authorNameLabel = [ZJGCreateTool labelWithView:self.playingItemView size:CGSizeMake(ZJGScreenWidth - 2 * ZJGHorizontalSpacing, 20)];
    self.authorNameLabel.font = ZJGBigFont;
    self.authorNameLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)setUpButtonInPlayingItemView {
    self.likeButton = [ZJGCreateTool buttonWithView:self.playingItemView image:[UIImage imageNamed:@"icon_ios_heart"] state:UIControlStateNormal size:CGSizeMake(30, 30)];
    [self.likeButton addTarget:self action:@selector(clickLikeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.likeButton setImage:[UIImage imageNamed:@"icon_ios_heart_filled"] forState:UIControlStateSelected];
    self.previousButton = [ZJGCreateTool buttonWithView:self.playingItemView image:[UIImage imageNamed:@"icon_ios_music_backward"] state:UIControlStateNormal size:CGSizeMake(35, 35)];
    [self.previousButton addTarget:self action:@selector(clickPreviousButton) forControlEvents:UIControlEventTouchUpInside];
    self.playOrPauseButton = [ZJGCreateTool buttonWithView:self.playingItemView image:[UIImage imageNamed:@"icon_ios_music_play"] state:UIControlStateNormal size:CGSizeMake(35, 35)];
    [self.playOrPauseButton setImage:[UIImage imageNamed:@"icon_ios_music_pause"] forState:UIControlStateSelected];
    [self.playOrPauseButton addTarget:self action:@selector(clickPlayOrPauseButton) forControlEvents:UIControlEventTouchUpInside];
    self.nextButton = [ZJGCreateTool buttonWithView:self.playingItemView image:[UIImage imageNamed:@"icon_ios_music_forward"] state:UIControlStateNormal size:CGSizeMake(35, 35)];
    [self.nextButton addTarget:self action:@selector(clickNextButton) forControlEvents:UIControlEventTouchUpInside];
    self.backMenuButton = [ZJGCreateTool buttonWithView:self.playingItemView image:[UIImage imageNamed:@"icon_ios_down"] state:UIControlStateNormal size:CGSizeMake(30, 30)];
    [self.backMenuButton addTarget:self action:@selector(clickBackMenuButton) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton = [ZJGCreateTool buttonWithView:self.playingItemView image:[UIImage imageNamed:@"icon_ios_export"] state:UIControlStateNormal size:CGSizeMake(30, 30)];
    [self.shareButton addTarget:self action:@selector(clickShareButton) forControlEvents:UIControlEventTouchUpInside];
    self.randomButton = [ZJGCreateTool buttonWithView:self.playingItemView image:[UIImage imageNamed:@"icon_ios_shuffle copy"] state:UIControlStateNormal size:CGSizeMake(30, 30)];
    [self.randomButton setImage:[UIImage imageNamed:@"icon_ios_shuffle _ selected"] forState:UIControlStateSelected];
    [self.randomButton addTarget:self action:@selector(clickRandomButton) forControlEvents:UIControlEventTouchUpInside];
    self.SingleCyclicButton = [ZJGCreateTool buttonWithView:self.playingItemView image:[UIImage imageNamed:@"icon_ios_replay"] state:UIControlStateNormal size:CGSizeMake(30, 30)];
    [self.SingleCyclicButton setImage:[UIImage imageNamed:@"icon_ios_replay _ selected"] forState:UIControlStateSelected];
    [self.SingleCyclicButton addTarget:self action:@selector(clickSingleCyclicButton) forControlEvents:UIControlEventTouchUpInside];
    self.moreChoiceButton = [ZJGCreateTool buttonWithView:self.playingItemView image:[UIImage imageNamed:@"icon_ios_more_filled"] state:UIControlStateNormal size:CGSizeMake(30, 30)];
    [self.moreChoiceButton addTarget:self action:@selector(clickMoreChoiceButton) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - clickButtons
-(void)clickLikeButton {
    ZJGLog(@"点击了添加到喜欢按钮");
    self.likeButton.selected = !self.likeButton.selected;
    [ZJGPromptTool promptModeText:self.likeButton.selected ? @"已添加到喜欢" : @"取消成功" afterDelay:1.0];
}
//数组边界值处理
- (void)clickPreviousButton {
    ZJGLog(@"点击了上一曲按钮");
    if (self.playingIndex != 0) {
        [self changeMusic:-1];
    } else {
        [self changeMusic:self.songIdArrayM.count - 1];
    }
    
}
- (void)changeMusic:(NSInteger)variable {
    [self removeProgressTimer];
    [self removeLrcTimer];
    
    [ZJGPlayMusicTool stopMusicWithLink:self.currentMusic.songLink];
    switch (self.playMode) {
        case CyclicMode:
            [self cyclicMusic:variable];
            break;
            case RandomMode:
            [self randomMusic];
            break;
            
            
       case SingleMode:
            break;
    }
    [self loadSongDetail];
    [self addProgressTimer];
    [self addLrcTimer];
    
}
- (void)addLrcTimer {
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcTimer)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
- (void)updateLrcTimer {
    self.lrcScrollView.currentTime = CMTimeGetSeconds(self.playingItem.currentTime);
    
}
- (void)addProgressTimer {
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}
- (void)updateProgressTimer {
    self.currentTimeLabel.text = [self setUpTimeStringWithTime:CMTimeGetSeconds(self.playingItem.currentTime)];
    self.totalTimeLabel.text = [self setUpTimeStringWithTime:CMTimeGetSeconds(self.playingItem.duration)];
    ZJGLog(@"获取的秒数为:%f",CMTimeGetSeconds(self.playingItem.duration));
    self.progressSlider.value = CMTimeGetSeconds(self.playingItem.currentTime);
    //防止过快切换歌曲导致duration == nan 而崩溃
    if (isnan(CMTimeGetSeconds(self.playingItem.duration))) {
        self.progressSlider.maximumValue = CMTimeGetSeconds(self.playingItem.currentTime) + 1;
    } else {
        self.progressSlider.maximumValue = CMTimeGetSeconds(self.playingItem.duration);
    }
    [self setUpLockInfo];
}
- (void)cyclicMusic:(NSInteger)variable {
//    if (self.playingIndex == self.songIdArrayM.count - 1) {
//        self.playingIndex = 0;
//    }
//    else {
        self.playingIndex = variable + self.playingIndex;
   // }
//    else if (self.playingIndex == 0) {
//        self.playingIndex = self.songIdArrayM.count - 1;
    
    
}
- (void)randomMusic {
    self.playingIndex = arc4random() % self.songIdArrayM.count;
}
- (void)removeProgressTimer {
    
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}
- (void)removeLrcTimer {
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}
- (void)
clickPlayOrPauseButton {
    ZJGLog(@"点击播放/暂停按钮");
    if (self.playOrPauseButton.selected) {
        [ZJGPlayMusicTool pauseMusicWithLink:self.currentMusic.songLink];
    } else {
        [ZJGPlayMusicTool playMusicWithLink:self.currentMusic.songLink];
    }
    self.playOrPauseButton.selected = !self.playOrPauseButton.selected;
    [self refreshIndicatorViewState];
}
//数组边界值处理
- (void)clickNextButton {
    ZJGLog(@"点击了下一曲按钮");
    if (self.playingIndex != self.songIdArrayM.count - 1) {
        [self changeMusic:1];
    } else {
        [self changeMusic:1 - self.songIdArrayM.count];
    }
    
}
- (void)clickBackMenuButton {
    ZJGLog(@"点击了返回歌曲列表按钮");
    [self dismissViewControllerAnimated:YES completion:^{
        [self refreshIndicatorViewState];
    }];
}
- (void)clickShareButton {
    ZJGLog(@"点击了分享按钮");
    [ZJGPromptTool promptModeText:@"抱歉!暂未实现分享功能..." afterDelay:1.0];
}
- (void)clickRandomButton {
    ZJGLog(@"点击了随机播放按钮");
    self.randomButton.selected = !self.randomButton.selected;
    self.SingleCyclicButton.selected = NO;
    [ZJGPromptTool promptModeText:(self.randomButton.selected ? @"随机播放" : @"取消随机播放") afterDelay:1.0];
    self.playMode = self.randomButton.selected ? RandomMode : CyclicMode;
}
- (void)clickSingleCyclicButton {
    ZJGLog(@"点击了单曲循环按钮");
    self.SingleCyclicButton.selected = !self.SingleCyclicButton.selected;
    self.randomButton.selected = NO;
    [ZJGPromptTool promptModeText:(self.SingleCyclicButton.selected ? @"单曲循环" : @"取消单曲循环") afterDelay:1.0];
    self.playMode = self.SingleCyclicButton.selected ? SingleMode : CyclicMode;
}
- (void)clickMoreChoiceButton {
    ZJGLog(@"点击了更多选择按钮");
    [ZJGPromptTool promptModeText:@"功能完善中" afterDelay:1.0];
}
#pragma mark - 设置锁屏信息/后台
- (void)setUpLockInfo {
    //1.获取当前播放中心
    
    MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
    
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        infos[MPMediaItemPropertyTitle] = self.currentMusic.songName;
        NSLog(@"当前播放歌曲:%@",self.currentMusic.songName);
        infos[MPMediaItemPropertyArtist] = self.currentMusic.artistName;
        infos[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithBoundsSize:self.view.bounds.size requestHandler:^UIImage * _Nonnull(CGSize size) {
            
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.currentMusic.songPicRadio]]];
            ZJGLog(@"歌曲大图:%@",self.currentMusic.songPicRadio);

            return image;
        }];
    
    
    infos[MPMediaItemPropertyPlaybackDuration] = @(CMTimeGetSeconds(self.playingItem.duration));
        infos[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(CMTimeGetSeconds(self.playingItem.currentTime));
    
        [center setNowPlayingInfo:infos];
    
    
    
    
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            [self clickPlayOrPauseButton];
            break;
        case UIEventSubtypeRemoteControlPause:
            [self clickPlayOrPauseButton];
            break;
            case UIEventSubtypeRemoteControlNextTrack:
            [self clickNextButton];
            break;
            case UIEventSubtypeRemoteControlPreviousTrack:
            [self clickPreviousButton];
            break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
            [self clickPlayOrPauseButton];//耳机模式
            break;
        default:
            break;
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
