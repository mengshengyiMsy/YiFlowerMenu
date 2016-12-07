//
//  YiFlowerButton.m
//  YiFlowerMenu
//
//  Created by 蒙圣燚 on 2016/12/4.
//  Copyright © 2016年 MSYi. All rights reserved.
//

#import "YiFlowerButton.h"

#define DegreesToRadians(degrees) (degrees * M_PI / 180.f)


@implementation YiFlowerButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.anchorPoint = CGPointMake(0.5, 1.f);
        self.layer.position =CGPointMake(frame.size.width/2+frame.origin.x, frame.size.height);
    }
    
    return self;
}

- (void)open {
    self.hidden = NO;
    [self.layer addAnimation:[self buttonFadeIn] forKey:@"ButtonFadeIn"];
}

- (void)close {
    [self.layer addAnimation:[self rotateFromDegree:self.degree toDegree:0 delegate:self] forKey:@"ButtonRotate"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CABasicAnimation *animation = (CABasicAnimation *)anim;
    if ([animation.keyPath isEqualToString:@"transform.scale"] && flag) {
        if (self.isOpen) {
            [self.layer addAnimation:[self rotateFromDegree:0 toDegree:self.degree delegate:nil] forKey:@"ButtonRotate"];
            self.transform = CGAffineTransformMakeRotation(DegreesToRadians(self.degree));
        }else {
            self.hidden = YES;
        }
    }else if ([animation.keyPath isEqualToString:@"transform.rotation"] && flag) {
        [self.layer addAnimation:[self buttonFadeOut] forKey:@"ButtonFadeOut"];
        self.transform = CGAffineTransformMakeRotation(DegreesToRadians(self.degree));
    }
}

/* 淡入 */
- (CABasicAnimation *)buttonFadeIn {
    self.isOpen = YES;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.01, .01, .1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = 0.2;
    scaleAnimation.delegate = self;
    return scaleAnimation;
}
/* 淡出 */
- (CABasicAnimation *)buttonFadeOut{
    self.isOpen = NO;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.01, .01, .1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = 0.2;
    scaleAnimation.delegate = self;
    return scaleAnimation;
}
/* 旋转 */
- (CABasicAnimation *)rotateFromDegree:(CGFloat)from toDegree:(CGFloat)to delegate:(id)delegete {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:DegreesToRadians(from)];
    rotateAnimation.toValue = [NSNumber numberWithFloat:DegreesToRadians(to)];
    rotateAnimation.duration = 0.5;
    rotateAnimation.delegate = delegete;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    return rotateAnimation;
}

@end






















