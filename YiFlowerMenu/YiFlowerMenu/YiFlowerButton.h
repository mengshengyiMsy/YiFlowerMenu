//
//  YiFlowerButton.h
//  YiFlowerMenu
//
//  Created by 蒙圣燚 on 2016/12/4.
//  Copyright © 2016年 MSYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YiFlowerButton : UIButton
/* 角度 */
@property (nonatomic, assign) CGFloat degree;
/* 打开状态 */
@property (nonatomic, assign) BOOL isOpen;

/* 打开按钮 */
- (void)open;
/* 关闭按钮 */
- (void)close;

@end
