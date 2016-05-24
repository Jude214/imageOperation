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

@property (nonatomic, assign) CGPoint startP;
@property (nonatomic, weak) UIView *recView;

@end

@implementation ViewController

//懒加载
- (UIView *)recView {
    if (!_recView) {
//        _recView = [[UIView alloc] init]; //Note:don't use this,_recView will be released immediately because of weak reference.
        UIView *aView = [[UIView alloc] init];
        //create a translucent view
        _recView = aView;
        _recView.backgroundColor = [UIColor blackColor];
        _recView.alpha = 0.5;
        [self.view addSubview:aView];
    }
    return _recView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self imageClip];
    
    [self captuerImageWithPan];
}

#pragma mark - Capture Image In Specific Rect
- (void)captuerImageWithPan {
    UIImage *image = [UIImage imageNamed:@"naruto"];
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - image.size.width) * 0.5, (kScreenHeight - image.size.height) * 0.5, image.size.width, image.size.height)];
    _imageV.image = image;
    [self.view addSubview:_imageV];
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:panGes];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    CGPoint endP = CGPointZero;
    if (pan.state == UIGestureRecognizerStateBegan) { //pan start
        _startP = [pan locationInView:pan.view];
        NSLog(@"begin point:%@",NSStringFromCGPoint(_startP));
    } else if (pan.state == UIGestureRecognizerStateChanged) { //paning action
        endP = [pan locationInView:pan.view];
        //generate rectangle clip view
        CGFloat rectW = endP.x - _startP.x;
        CGFloat rectH = endP.y - _startP.y;
        self.recView.frame = CGRectMake(_startP.x, _startP.y, rectW, rectH);
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        //clip image,generate a new image
        UIGraphicsBeginImageContextWithOptions(_imageV.bounds.size, NO, 0);
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:_recView.bounds];
        [path addClip]; //add a clip rect
        //render to context
        CGContextRef context = UIGraphicsGetCurrentContext();
        [_imageV.layer renderInContext:context];
        _imageV.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //移除recView
        [_recView removeFromSuperview];
        _recView = nil;
    }
}

#pragma mark - Clip Image
- (void)imageClip {
    //image clip
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
