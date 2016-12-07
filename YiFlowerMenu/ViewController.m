//
//  ViewController.m
//  YiFlowerMenu
//
//  Created by 蒙圣燚 on 2016/12/4.
//  Copyright © 2016年 MSYi. All rights reserved.
//

#import "ViewController.h"
#import "YiFlowerMenu.h"

@interface ViewController () <YiFlowerDelegate>

@property (nonatomic, strong) YiFlowerMenu *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *images = @[[UIImage imageNamed:@"menu1.png"], [UIImage imageNamed:@"menu2.png"], [UIImage imageNamed:@"menu3.png"], [UIImage imageNamed:@"menu4.png"], [UIImage imageNamed:@"menu5.png"]];
    self.menu = [[YiFlowerMenu alloc]initWithSuperView:self.view buttonArray:images];
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
}

- (void)flowerButtonSelected:(NSInteger)index {
    NSLog(@"点击了第%ld个按钮", index);
    [self.menu close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
