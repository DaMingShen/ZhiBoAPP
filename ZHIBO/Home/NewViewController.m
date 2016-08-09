//
//  NewViewController.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/27.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "NewViewController.h"
#import "NewListCell.h"
#import "NewListModel.h"
#import "LiveViewController.h"

static NSString * newListCellID = @"newListCell";

@interface NewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * stars;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat itemLen = (ScreenW - 2) / 3;
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(itemLen, itemLen);
        layout.minimumLineSpacing = 1.0;
        layout.minimumInteritemSpacing = 1.0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, WZNavHeight, ScreenW, ScreenH - WZNavHeight - WZTabbarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = ClearColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"NewListCell" bundle:nil] forCellWithReuseIdentifier:newListCellID];
        WEAKSELF
        [_collectionView addRefreshHeader:^{
            [weakSelf fetchHotListWithRefresh:YES];
        } footer:^{
            [weakSelf fetchHotListWithRefresh:NO];
        }];
        [_collectionView.header beginRefreshing];
    }
    return _collectionView;
}

#pragma mark - CollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stars.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:newListCellID forIndexPath:indexPath];
    cell.model = self.stars[indexPath.item];
    return cell;
}

#pragma mark - CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        LiveViewController * liveVC = [[LiveViewController alloc]init];
        NSMutableArray * liveArray = [NSMutableArray array];
        for (NewListModel * model in self.stars) {
            [liveArray addObject:[model convertModel]];
        }
        liveVC.stars = liveArray;
        liveVC.currentIndex = indexPath.item;
        [self presentViewController:liveVC animated:YES completion:nil];
    });
}

#pragma mark - Fetch Data
- (void)fetchHotListWithRefresh:(BOOL)refresh {
    [WZOperation GET:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld", refresh ? 1 : self.currentPage + 1] success:^(id data) {
        WZLog_INFO(data);
        [self.collectionView.header endRefreshing];
        [self.collectionView.footer endRefreshing];
        if (refresh) {
            self.currentPage = 1;
            self.stars = [NewListModel modelArrayFromDictArray:[((NSDictionary *)data) objectForKey:@"list"]].mutableCopy;
            self.collectionView.footer.hidden = NO;
        }else {
            self.currentPage ++;
            [self.stars addObjectsFromArray:[NewListModel modelArrayFromDictArray:[((NSDictionary *)data) objectForKey:@"list"]]];
        }
        [self.collectionView reloadData];
    } failure:^(NSString *msg, NSError *error) {
        [self.collectionView.header endRefreshing];
        [self.collectionView.footer endRefreshing];
        WZLog_INFO(msg);
    }];
}

@end
