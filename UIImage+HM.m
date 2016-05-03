//
//  UIImage+HM.m
//  25-画水印
//
//  Created by 韩萌 on 16/4/21.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "UIImage+HM.h"

@implementation UIImage (HM)

/**
 *  将圆环的生成方式写成一个分类
 *
 *  @param imageName   图片名称
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
+(instancetype)circleImageWithName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    //1.获取原图
    UIImage *oldImg = [UIImage imageNamed:imageName];
    
    //2.开启上下文
    CGFloat imgSizeW = oldImg.size.width + 2 * borderWidth;
    CGFloat imgSizeH = oldImg.size.height + 2 * borderWidth;
    CGSize imgSize = CGSizeMake(imgSizeW, imgSizeH);
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, 0.0);
    
    //3.获取当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //4.画大圆
    [borderColor set];
    CGFloat radius = imgSizeW * 0.5;
    CGFloat centerX = radius;
    CGFloat centerY = radius;
    CGContextAddArc(contextRef, centerX, centerY, radius, 0, M_PI * 2, 0);
    CGContextFillPath(contextRef);//填充
    
    //5.画小圆并裁剪
    CGFloat smallRadius = radius - borderWidth;
    CGContextAddArc(contextRef, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    //裁剪
    CGContextClip(contextRef);
    
    //6.画图
    [oldImg drawInRect:CGRectMake(borderWidth, borderWidth, oldImg.size.width, oldImg.size.height)];
    
    //7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //8.结束上下文
    UIGraphicsEndImageContext();
    
    //9.返回新图片
    return newImage;
}

/**
 *  截图
 *
 *  @param view 要截取的view
 */
+(instancetype)captureWithView:(UIView *)view{
    //1.开启上下文
    UIGraphicsBeginImageContext(view.frame.size);
    
    //2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *data = UIImagePNGRepresentation(newImage);
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"new.png"];
    [data writeToFile:path atomically:YES];
    
    //4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
