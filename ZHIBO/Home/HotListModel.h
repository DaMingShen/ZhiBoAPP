//
//  HotListModel.h
//  ZHIBO
//
//  Created by 万众科技 on 16/7/27.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "SUBaseModel.h"

@interface HotListModel : SUBaseModel

@property (nonatomic, copy) NSString *flv; /** 直播流地址 */

@property (nonatomic, copy) NSString *myname; /** 主播名 */

@property (nonatomic, copy) NSString *smallpic; /** 主播头像 */

@property (nonatomic, assign) NSInteger serverid; /** 所处服务器 */

@property (nonatomic, assign) NSInteger roomid; /** 直播房间号码 */

@property (nonatomic, copy) NSString *gps; /** 所在城市 */

@property (nonatomic, assign) NSInteger starlevel; /** 星级 */

@property (nonatomic, copy) NSString *userId; /** 用户ID */

@property (nonatomic, copy) NSString *signatures; /** 个性签名 */

@property (nonatomic, copy) NSString *bigpic; /** 直播图 */

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger curexp;

@property (nonatomic, assign) NSInteger useridx; /** 用户ID */

@property (nonatomic, assign) NSInteger grade;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) NSInteger allnum; /** 朝阳群众数目 */

@end
