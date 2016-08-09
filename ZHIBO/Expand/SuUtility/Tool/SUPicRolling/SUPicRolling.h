//
//  SUPicRolling.h
//  PictureScrollDemo
//
//  Created by 万众科技 on 16/4/11.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUPicRolling : UIView

typedef void(^handleImg)(UIImageView * imgView, NSString * imgUrl);
typedef void(^clickImg)(NSInteger imgIndex);


/**
 *  实例化方法
 *
 *  @param frame            坐标
 *  @param urlArray         图片地址数组
 *  @param scrollInterval   滚动时间 设置为0时不滚动
 *  @param pageIndicator    自定义指示器(默认)
 *  @param currentIndicator 自定义指示器(选中)
 *  @param handleBlock      图片设置回调
 *  @param clickBlock       点击回调
 *
 *  @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                     urlArray:(NSArray *)urlArray
               scrollInterval:(float)scrollInterval
                pageIndicator:(NSString *)pageIndicator
             currentIndicator:(NSString *)currentIndicator
                    handleImg:(handleImg)handleBlock
                     clickImg:(clickImg)clickBlock;

/**
 *  开启滚动
 */
- (void)startRolling;

/**
 *  停止滚动
 */
- (void)stopRolling;



@end
