//
//  YiFlowerMenu.h
//  YiFlowerMenu
//
//  Created by 蒙圣燚 on 2016/12/4.
//  Copyright © 2016年 MSYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YiFlowerDelegate <NSObject>
/* 点击按钮回调方法 */
- (void)flowerButtonSelected:(NSInteger)index;

@end

@interface YiFlowerMenu : UIView
/* 代理 */
@property (nonatomic, weak) id <YiFlowerDelegate> delegate;
/* 打开状态 */
@property (nonatomic, assign) BOOL isOpen;

/* 构造传入SuperView的方法 */
- (instancetype)initWithSuperView:(UIView *)superView buttonArray:(NSArray *)imagesButton;
/* 打开按钮 */
- (void)open;
/* 关闭按钮 */
- (void)close;

@end
