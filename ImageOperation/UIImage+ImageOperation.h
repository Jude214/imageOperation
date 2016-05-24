//
//  UIImage+ImageOperation.h
//  图片的系列操作
//
//  Created by QingHong on 16/5/23.
//  Copyright © 2016年 QingHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageOperation)

/**
 * @brief 添加水印文字
 * @param waterText 待添加的水印文字
 * @param position 水印文字位置
 * @param attributes 水印文字属性字典
 * @return return a new image with water text
 */
- (UIImage *)addWaterText:(NSString *)waterText textPosition:(CGPoint)position textAttributes:(NSDictionary <NSString *, id> * )attributes;

/**
 * @brief 将图片裁剪为圆形图片
 * @param image, original image
 * @return return the clipped image
 */
+ (UIImage *)imageClip:(UIImage *)image;

/**
 * @brief 图片裁剪为带圆环的圆图
 * @param image, original image
 * @param border, width of the ring. Minimum value is zero
 * @param borderColor, color of the ring
 * @return return the clipped image
 */
+ (UIImage *)imageClip:(UIImage *)image borderWidth:(CGFloat)border borderColor:(UIColor *)borderColor;

/**
 * @brief 控件截图
 * @param aView, the view to be captured
 * @param return a captured image
 */
+ (UIImage *)captureImageInView:(UIView *)aView;

@end
