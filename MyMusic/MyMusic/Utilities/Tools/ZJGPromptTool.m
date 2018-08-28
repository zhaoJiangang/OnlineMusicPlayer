//
//  ZJGPromptTool.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/21.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGPromptTool.h"

@implementation ZJGPromptTool
+ (MBProgressHUD *)promptMode:(MBProgressHUDMode)mode text:(NSString *)text afterDelay:(NSInteger)time {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *prompt = [MBProgressHUD showHUDAddedTo:view animated:YES];
    prompt.userInteractionEnabled = NO;
    prompt.mode = mode;
    prompt.label.font = [UIFont systemFontOfSize:15];
    prompt.label.text = text;
    prompt.margin = 10.f;
    prompt.removeFromSuperViewOnHide = YES;
    [prompt hideAnimated:YES afterDelay:time];
    return prompt;
}
+ (void)promptModeText:(NSString *)text afterDelay:(NSInteger)time {
    [self promptMode:MBProgressHUDModeIndeterminate text:text afterDelay:time];
}
+ (MBProgressHUD *)promptModeIndeterminatetext:(NSString *)text {
    return [self promptMode:MBProgressHUDModeIndeterminate text:text afterDelay:60];
}
@end
