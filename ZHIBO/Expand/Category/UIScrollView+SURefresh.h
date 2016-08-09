//
//  UITableView+SURefresh.h
//  ZHIBO
//
//  Created by 万众科技 on 16/7/29.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SURefresh)

- (void)addRefreshHeader:(void(^)())headerBlock footer:(void(^)())footerBlock;

@end
