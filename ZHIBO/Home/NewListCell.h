//
//  NewListCell.h
//  ZHIBO
//
//  Created by 万众科技 on 16/7/29.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewListModel;
@interface NewListCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *starImg;
@property (weak, nonatomic) IBOutlet UIButton *starLocation;
@property (weak, nonatomic) IBOutlet UILabel *starName;
@property (weak, nonatomic) IBOutlet UIImageView *isNewStar;
@property (weak, nonatomic) IBOutlet UIImageView *starLevelImg;

@property (nonatomic, strong) NewListModel * model;

@end
