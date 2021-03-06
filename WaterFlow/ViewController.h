//
//  ViewController.h
//  WaterFlow
//
//  Created by fute on 15/12/15.
//  Copyright © 2015年 nanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGE_COUNT 17
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController : UIViewController<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *imageArr;//图片数据
@property (strong, nonatomic) UITableView *tableLeft;
@property (strong, nonatomic) UITableView *tableRight;


//存储所有的高度的数组
@property (strong,nonatomic) NSMutableArray  *heightArr;
@property (strong, nonatomic)UICollectionView *collectionView;
@end

