//
//  ViewController.m
//  ImageOperation
//
//  Created by QingHong on 16/5/23.
//  Copyright © 2016年 QingHong. All rights reserved.
//

#import "ViewController.h"
#import "DemoController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController () {
    NSArray <NSString *> *config;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片操作演示";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createDemoButtons];
}

- (void)createDemoButtons {
    config = @[@"添加水印",@"裁剪为圆形",@"带圆环圆图",@"控件截图",@""];
    [config enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        aBtn.frame = CGRectMake((kScreenWidth - 100) * 0.5, 100 + 40 * idx, 100, 30);
        aBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
        [aBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [aBtn setTitle:title forState:UIControlStateNormal];
        [aBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aBtn];
    }];
}

- (void)buttonAction:(UIButton *)button {
    DemoController *demoCtrl = [[DemoController alloc] initWithNibName:@"DemoController" bundle:[NSBundle mainBundle]];
    NSString *title = button.currentTitle;
    if ([title isEqualToString:config[0]]) {
        demoCtrl.demoType = DemoTypeWaterText;
    } else if ([title isEqualToString:config[1]]) {
        demoCtrl.demoType = DemoTypeOvalClip;
    } else if ([title isEqualToString:config[2]]) {
        demoCtrl.demoType = DemoTypeOvalWithRing;
    } else if ([title isEqualToString:config[3]]) {
        demoCtrl.demoType = DemoTypeControlClip;
    }
    [self.navigationController pushViewController:demoCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
