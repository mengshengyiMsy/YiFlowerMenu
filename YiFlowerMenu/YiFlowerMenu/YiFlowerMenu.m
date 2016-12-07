//
//  YiFlowerMenu.m
//  YiFlowerMenu
//
//  Created by 蒙圣燚 on 2016/12/4.
//  Copyright © 2016年 MSYi. All rights reserved.
//

#import "YiFlowerMenu.h"
#import "YiFlowerButton.h"

@implementation YiFlowerMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithSuperView:(UIView *)superView buttonArray:(NSArray *)imagesArray {
    if (self = [super init]) {
        /* 父视图添加长按手势 */
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
        [superView addGestureRecognizer:longPress];
        /* 父视图添加点击手势 */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [superView addGestureRecognizer:tap];
        
        [self addButtonWithImages:imagesArray];
        
    }
    return self;
}

- (void)addButtonWithImages:(NSArray *)images {
    self.frame = CGRectMake(200, 200, ((UIImage *)[images lastObject]).size.height*2, ((UIImage *)[images lastObject]).size.height*2);
    if (self.subviews.count > 0) {
        /* 从父视图中移除 */
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    NSInteger i = 0;
    CGFloat degree = 360.f/images.count;
    for (UIImage *image in images) {
        YiFlowerButton *button = [[YiFlowerButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2-image.size.width/2, 0, image.size.width, image.size.height)];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.degree = i * degree;
        button.hidden = YES;
        button.tag = i;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        i++;
    }
}

- (void)open {
    self.isOpen = YES;
    CGFloat delay = 0.f;
    for (YiFlowerButton *button in self.subviews) {
        [self performSelector:@selector(showButton:) withObject:button afterDelay:delay];
        delay += 0.05;
    }
    
}

- (void)close {
    for (YiFlowerButton *button in self.subviews) {
        [button close];
    }
    self.isOpen = NO;
}

- (void)showButton:(YiFlowerButton *)button {
    [button open];
}

#pragma mark 手势处理
- (void)handleLongPress:(UILongPressGestureRecognizer *)sender {
    if (self.isOpen) {
        /* 已展开 无动作 */
        return;
    }
    UIView *superView = [sender view];
    CGPoint pressedPoint = [sender locationInView:superView];
    CGPoint newCenter = pressedPoint;
    if ((pressedPoint.x - self.frame.size.width/2) < 0) {
        newCenter.x = self.frame.size.width/2;
    }
    if ((pressedPoint.x + self.frame.size.width/2) > superView.frame.size.width){
        newCenter.x = superView.frame.size.width - self.frame.size.width/2;
    }
    if ((pressedPoint.y - self.frame.size.height/2) <0){
        newCenter.y = self.frame.size.height/2;
    }
    if ((pressedPoint.y + self.frame.size.height/2) > superView.frame.size.height){
        newCenter.y = superView.frame.size.height - self.frame.size.height/2;
    }
    self.center = newCenter;
    [self open];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (!self.isOpen) {
        /* 已收回 无动作 */
        return;
    }
    [self close];
}

#pragma mark 点击按钮
- (void)clickButton:(YiFlowerButton *)button {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(flowerButtonSelected:)]) {
            [self.delegate flowerButtonSelected:button.tag + 1];
        }
    }
}

@end
