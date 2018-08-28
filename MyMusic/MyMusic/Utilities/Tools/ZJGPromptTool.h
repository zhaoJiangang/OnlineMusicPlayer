//
//  ZJGPromptTool.h
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/21.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface ZJGPromptTool : NSObject
+ (void)promptModeText:(NSString *)text afterDelay:(NSInteger)time;
+ (MBProgressHUD *)promptModeIndeterminatetext:(NSString *)text;



@end
