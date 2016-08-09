//
//  SUPageControl.h
//  PictureScrollDemo
//
//  Created by 万众科技 on 16/4/11.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUPageControl : UIView

@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame
                        count:(NSInteger)count
                pageIndicator:(NSString *)pageIndicator
             currentIndicator:(NSString *)currentIndicator;

@end
