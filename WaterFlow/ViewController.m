//
//  ViewController.m
//  WaterFlow
//
//  Created by fute on 15/12/15.
//  Copyright © 2015年 nanfang. All rights reserved.
//  test

#import "ViewController.h"
#import "UIImage+Extension.h"

static NSString *key = @"identify";//重用标识
static NSString *key1 = @"header";
static NSString *key2 = @"footer";

@interface ViewController ()

@end

@implementation ViewController
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2-10, self.view.frame.size.width/2-10);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
//    cell.backgroundColor = [UIColor greenColor];
    NSLog(@"item======%d",indexPath.item);
    NSLog(@"row=======%d",indexPath.row);
    NSLog(@"section===%d",indexPath.section);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    // Do any additional setup after loading the view, typically from a nib.
    
    if (_imageArr == nil) {
        _imageArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < 10; i++) {
            UIImage *image = [UIImage imageWithColor:[UIColor blueColor]];
            [_imageArr addObject:image];
        }
    }
    
//    _tableLeft = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH/2, SCREEN_HEIGHT) style:UITableViewStylePlain];
//    _tableLeft.dataSource = self;
//    _tableLeft.delegate = self;
//    _tableLeft.showsHorizontalScrollIndicator = NO;
//    _tableLeft.showsVerticalScrollIndicator = NO;
//    _tableLeft.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_tableLeft];
//
//    _tableRight = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0.0, SCREEN_WIDTH/2, SCREEN_HEIGHT) style:UITableViewStylePlain];
//    _tableRight.dataSource = self;
//    _tableRight.delegate = self;
//    _tableRight.showsHorizontalScrollIndicator = NO;
//    _tableRight.showsVerticalScrollIndicator = NO;
//    _tableRight.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_tableRight];
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    //    return 100;
//    if (tableView == _tableLeft) {
//        return ([_imageArr count]+1)/2;
//    }else{
//        return [_imageArr count] - ([_imageArr count]+1)/2;
//    }
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger row = indexPath.row;
//    static NSString *CellIdentifier = @"Cell";
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];//首先从可重用队列里面弹出一个cell
//    if (cell == nil) {//说明可重用队列里面并cell，此时需要重新创建cell实例，采用下面方法
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
//    }else{//此时表示有可重用cell，直接返回即可
//        NSLog(@"cell 重用啦");
//    }
//    
//    // TODO
//    // Config your cell
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, 5.0, SCREEN_WIDTH/2-10, SCREEN_WIDTH/2 - 10)];
//    imageView.image = [UIImage imageWithColor:[UIColor blueColor]];
//    [cell addSubview: imageView];
//    return cell;
//}
//
//- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_imageArr.count > 0) {
//        return SCREEN_WIDTH/2;
//    }
//    return 0.0;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}
//
//- (void)Backhome{
//    [self dismissModalViewControllerAnimated:YES];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == _tableLeft) {
//        [_tableRight setContentOffset:_tableLeft.contentOffset];
//    }else{
//        [_tableLeft setContentOffset:_tableRight.contentOffset];
//    }
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
