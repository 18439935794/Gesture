//
//  UIView+CornerRadius.h
//  gestureDemo
//
//  Created by weifangzou on 2017/7/4.
//  Copyright © 2017年 Ttpai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor *borderColor;
@end
