//
//  DemoController.m
//  ImageOperation
//
//  Created by QingHong on 16/5/24.
//  Copyright © 2016年 QingHong. All rights reserved.
//

#import "DemoController.h"
#import "UIImage+ImageOperation.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define RectMacro(image) CGRectMake((kScreenWidth - image.size.width) * 0.5, (kScreenHeight - image.size.height) * 0.5, image.size.width, image.size.height)

@interface DemoController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic, strong) UIImageView *demoImage;

@property (nonatomic, assign) CGPoint startP;
@property (nonatomic, weak) UIView *recView;

@end

@implementation DemoController

//懒加载
- (UIView *)recView {
    if (!_recView) {
//        _recView = [[UIView alloc] init]; //Note:don't use this,_recView will be released immediately because of weak reference.
        UIView *aView = [[UIView alloc] init]; //in ARC environment,all local variables are strong reference in default.
        //create a translucent view
        _recView = aView;
        aView.backgroundColor = [UIColor blackColor];
        aView.alpha = 0.5;
        [self.view addSubview:aView];
    }
    return _recView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    switch (self.demoType) {
        case DemoTypeWaterText:
            [self addWaterText];
            break;
        case DemoTypeOvalClip:
            [self commonImageClip];
            break;
        case DemoTypeOvalWithRing:
            [self imageClip];
            break;
        case DemoTypeControlClip:
            [self captuerImageWithPan];
            break;
        default:
            break;
    }
}

#pragma mark - Add Water Text
- (void)addWaterText {
    UIImage *waterImg = [UIImage imageNamed:@"yellowman"];
    self.demoImage = [[UIImageView alloc] initWithFrame:RectMacro(waterImg)];
    NSString *text = @"WaterDemo-QH";
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor blueColor]};
    CGSize tSize = [text boundingRectWithSize:waterImg.size options:NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    self.demoImage.image = [waterImg addWaterText:text textPosition:CGPointMake((waterImg.size.width - tSize.width) * 0.5, waterImg.size.height - tSize.height) textAttributes:attributes];
    [self.view addSubview:_demoImage];
}

#pragma mark - Clip Image
- (void)commonImageClip {
    UIImage *image = [UIImage imageNamed:@"ali"];
    self.demoImage = [[UIImageView alloc] initWithFrame:RectMacro(image)];
    self.demoImage.image = [UIImage imageClip:image];
    [self.view addSubview:_demoImage];
}

- (void)imageClip {
    UIImage *image = [UIImage imageNamed:@"ali"];
    self.demoImage = [[UIImageView alloc] initWithFrame:RectMacro(image)];
    self.demoImage.image = [UIImage imageClip:image borderWidth:2.0 borderColor:[UIColor redColor]];
    [self.view addSubview:_demoImage];
}

#pragma mark - Capture Image In Specific Rect
- (void)captuerImageWithPan {
    UIImage *image = [UIImage imageNamed:@"naruto"];
    _imageV.image = image;
    _imageV.userInteractionEnabled = YES;
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
//        CGPoint convertSP = [self.imageV convertPoint:_startP toView:self.view];
//        CGPoint convertEP = [self.imageV convertPoint:endP toView:self.view];
//        CGFloat rectW = convertEP.x - convertSP.x;
//        CGFloat rectH = convertEP.y - convertSP.y;
        CGFloat rectW = endP.x - _startP.x;
        CGFloat rectH = endP.y - _startP.y;
        CGRect clipRect = CGRectMake(_startP.x, _startP.y, rectW, rectH);
        self.recView.frame = clipRect;
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        //clip image,generate a new image
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:_recView.frame];
        //移除recView
        [_recView removeFromSuperview];
        _recView = nil;
        [path addClip]; //add a clip rect
        //render to context
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.view.layer renderInContext:context];
        _imageV.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
