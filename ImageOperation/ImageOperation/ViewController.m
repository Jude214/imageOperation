//
//  ViewController.m
//  ImageOperation
//
//  Created by 廖祖德 on 16/5/23.
//  Copyright © 2016年 QingHong. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageOperation.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"ali"];
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - image.size.width) * 0.5, (kScreenHeight - image.size.height) * 0.5, image.size.width, image.size.height)];
    _imageV.image = [UIImage imageClip:image borderWidth:2.0 borderColor:[UIColor redColor]];
    //    _imageV.image = [UIImage imageClip:image];
    [self.view addSubview:_imageV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
