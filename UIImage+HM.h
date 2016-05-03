//
//  UIImage+HM.h
//  25-画水印
//
//  Created by 韩萌 on 16/4/21.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HM)


+(instancetype)circleImageWithName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+(instancetype)captureWithView:(UIView *)view;

@end
