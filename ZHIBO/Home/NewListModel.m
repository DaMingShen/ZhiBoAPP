//
//  NewListModel.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/29.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "NewListModel.h"
#import "HotListModel.h"

@implementation NewListModel

+ (NSDictionary *)jsonKeyMapping {
     return @{@"isNew" : @"new"};
}

- (HotListModel *)convertModel {
    HotListModel * model = [[HotListModel alloc]init];
    model.allnum = self.allnum;
    model.flv = self.flv;
    model.myname = self.nickname;
    model.bigpic = self.photo;
    model.smallpic = self.photo;
    model.gps = self.position;
    model.roomid = self.roomid;
    model.serverid = self.serverid;
    model.starlevel = self.starlevel;
    model.useridx = self.useridx;
    return model;
}

@end
