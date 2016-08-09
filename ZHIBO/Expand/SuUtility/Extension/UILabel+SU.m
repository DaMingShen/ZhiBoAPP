//
//  UILabel+SuExt.m
//  SuUtility
//
//  Created by KevinSu on 15/10/17.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import "UILabel+SU.h"

@implementation UILabel (SU)

- (CGSize)boundsSize:(CGSize)size {
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    CGSize resSize = [self.text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return resSize;
}

@end
