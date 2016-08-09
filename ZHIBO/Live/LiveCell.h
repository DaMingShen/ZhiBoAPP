//
//  LiveCell.h
//  ZHIBO
//
//  Created by 万众科技 on 16/7/27.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotListModel.h"

typedef enum : NSUInteger {
    ActionTypeClose,
    ActionTypeOther
} ActionType;

@interface LiveCell : UITableViewCell

@property (nonatomic, strong) HotListModel * model;
@property (nonatomic, copy) void(^actionCallback)(ActionType actionType);

- (void)startPlay;
- (void)stop;

@end
