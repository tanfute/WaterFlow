//
//  CollectViewController.h
//  WaterFlow
//
//  Created by fute on 15/12/17.
//  Copyright © 2015年 nanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectViewController : UIViewController<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *imageArr;//图片数据
@property (strong, nonatomic) UITableView *tableLeft;
@property (strong, nonatomic) UITableView *tableRight;

@property (assign, nonatomic) NSInteger cur;
//存储所有的高度的数组
@property (strong,nonatomic) NSMutableArray  *heightArr;
@property (strong, nonatomic)UICollectionView *collectionView;

@end
