
//
//  UIImage+ImageOperation.m
//  图片的系列操作
//
//  Created by QingHong on 16/5/23.
//  Copyright © 2016年 QingHong. All rights reserved.
//

#import "UIImage+ImageOperation.h"

@implementation UIImage (ImageOperation)

- (UIImage *)addWaterText:(NSString *)waterText textPosition:(CGPoint)position textAttributes:(NSDictionary<NSString *,id> *)attributes {
    [self drawAtPoint:CGPointZero];
    [waterText drawAtPoint:position withAttributes:attributes];
    UIImage *waterImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return waterImg;
}

+ (UIImage *)imageClip:(UIImage *)image {
    return [UIImage imageClip:image borderWidth:0 borderColor:nil];
}

+ (UIImage *)imageClip:(UIImage *)image borderWidth:(CGFloat)border borderColor:(UIColor *)borderColor {
    CGFloat oriW = image.size.width;
    CGFloat oriH = image.size.height;
    CGFloat ovalWidth = oriW;
    CGFloat ovalHeight = oriH;
    if (border > 0) {
        ovalWidth = oriW + 2 * border;
        ovalHeight = oriH + 2 * border;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWidth, ovalHeight), NO, 0);
    UIBezierPath *biggerOval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWidth, ovalHeight)]; //绘制大圆
    [borderColor setFill];
    [biggerOval fill];
    
    //set the clip rect
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, oriW, oriH)];
    [clipPath addClip];
    //draw image
    [image drawAtPoint:CGPointMake(border, border)];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipImage;
}

+ (UIImage *)captureImageInView:(UIView *)aView {
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [aView.layer renderInContext:context];
    UIImage *capture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capture;
}


@end

