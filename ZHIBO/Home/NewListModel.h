//
//  NewListModel.h
//  ZHIBO
//
//  Created by 万众科技 on 16/7/29.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "SUBaseModel.h"

@class HotListModel;
@interface NewListModel : SUBaseModel

@property (nonatomic, assign) NSInteger allnum;

@property (nonatomic, assign) NSInteger roomid;

@property (nonatomic, assign) NSInteger starlevel;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger useridx;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, assign) NSInteger serverid;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *flv;

@property (nonatomic, assign) NSInteger isNew;

- (HotListModel *)convertModel;

@end
