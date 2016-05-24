//
//  DemoController.h
//  ImageOperation
//
//  Created by QingHong on 16/5/24.
//  Copyright © 2016年 QingHong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DemoType) {
    DemoTypeWaterText           = 0, //图片添加水印
    DemoTypeOvalClip            = 1, //裁切为圆图
    DemoTypeOvalWithRing        = 2, //带圆环圆图
    DemoTypeControlClip         = 3 //控件截图
};

@interface DemoController : UIViewController

@property (nonatomic, assign) DemoType demoType;

@end
