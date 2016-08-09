//
//  CALayer+SUBorder.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/29.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "CALayer+SUBorder.h"

@implementation CALayer (SUBorder)

- (void)setBorderUIColor:(UIColor*)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
