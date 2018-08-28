//
//  ZJGLrcLabel.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/3/11.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGLrcLabel.h"

@implementation ZJGLrcLabel
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGRect drawRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    [[UIColor redColor] set];
    UIRectFillUsingBlendMode(drawRect, kCGBlendModeSourceIn);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
