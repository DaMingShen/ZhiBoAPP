//
//  UITableView+SURefresh.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/29.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "UIScrollView+SURefresh.h"

@implementation UIScrollView (SURefresh)

- (void)addRefreshHeader:(void(^)())headerBlock footer:(void(^)())footerBlock {
    if (headerBlock) {
        MJRefreshGifHeader * header = [self addGifHeaderWithRefreshingBlock:^{
            headerBlock();
        }];
        header.stateHidden = YES;
        header.updatedTimeHidden = YES;
        [header setImages:@[[UIImage imageNamed:@"reflesh1"]] forState:MJRefreshHeaderStateIdle];
        [header setImages:@[[UIImage imageNamed:@"reflesh1"],
                            [UIImage imageNamed:@"reflesh2"],
                            [UIImage imageNamed:@"reflesh3"]] forState:MJRefreshHeaderStateRefreshing];
    }
    if (footerBlock) {
        [self addLegendFooterWithRefreshingBlock:^{
            footerBlock();
        }];
        if (headerBlock) {
            self.footer.hidden = YES;
        }
    }
}

@end
