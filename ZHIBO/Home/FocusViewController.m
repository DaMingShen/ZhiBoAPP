//
//  FocusViewController.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/29.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "FocusViewController.h"

@interface FocusViewController ()

@property (weak, nonatomic) IBOutlet UIButton *jumpingBtn;
@end

@implementation FocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)jumping:(UIButton *)sender {
    [(UIScrollView *)self.view.superview setContentOffset:CGPointZero animated:YES];
}

@end
