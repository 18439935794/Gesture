//
//  UIView+CornerRadius.m
//  gestureDemo
//
//  Created by weifangzou on 2017/7/4.
//  Copyright © 2017年 Ttpai. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)
- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}


- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}


- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}
@end
