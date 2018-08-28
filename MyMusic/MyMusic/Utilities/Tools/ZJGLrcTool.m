//
//  ZJGLrcTool.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/4.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGLrcTool.h"
#import "ZJGLrcModel.h"
#import "ZJGLrcScrollView.h"
@implementation ZJGLrcTool
+ (void)lrcToolDownloadWithUrl:(NSString *)url setUpLrcView:(ZJGLrcScrollView *)lrcView {
    [ZJGNetWorkTool netWorkToolDownloadWithUrl:url targetPath:NSDocumentDirectory DomainMask:NSUserDomainMask endPath:^(NSURL *endPath) {
        NSMutableArray *lrcArrayM = [NSMutableArray array];
        //
        NSString *path = (NSString *)endPath;
        NSString *lrc = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray *array = [lrc componentsSeparatedByString:@"\n"];
        for (NSString *lrc in array) {
            if ([lrc hasPrefix:@"ti:"] || [lrc hasPrefix:@"ar:"] || [lrc hasPrefix:@"al:"] ||
                ![lrc hasPrefix:@"["]) {
                continue;
            }
            ZJGLrcModel *lrcModel = [ZJGLrcModel lrcModeWithLrcString:lrc];
            [lrcArrayM addObject:lrcModel];
        }
        lrcView.lrcArray = lrcArrayM;
    }];
}
@end
