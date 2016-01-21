//
//  CollectViewController.m
//  WaterFlow
//
//  Created by fute on 15/12/17.
//  Copyright © 2015年 nanfang. All rights reserved.
//

#import "CollectViewController.h"
#import "UIImage+Extension.h"

static NSString *key = @"identify";//重用标识
static NSString *key1 = @"header";
static NSString *key2 = @"footer";

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation CollectViewController
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
    
    cell.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    // Config your cell
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, 5.0, SCREEN_WIDTH/4-10, SCREEN_WIDTH/4 - 10)];
//    NSString *url = dic.img;
//    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"error"]];
    imageView.image = [UIImage imageWithColor:[UIColor redColor]];
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), CGRectGetMidY(imageView.frame)/2, SCREEN_WIDTH - CGRectGetMaxX(imageView.frame), 10)];
    labelTitle.text = @"name";
    labelTitle.textColor = [UIColor blackColor];
    
    UILabel *labelTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), CGRectGetMidY(imageView.frame), SCREEN_WIDTH - CGRectGetMaxX(imageView.frame), 10)];
    labelTime.text = @"time";
    [cell addSubview:labelTitle];
    [cell addSubview:labelTime];
    [cell addSubview: imageView];
    
    
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
    return CGSizeMake(self.view.frame.size.width, SCREEN_WIDTH/4);
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
    
    if (self.cur >= 0)
    {
        NSIndexPath *oldIndex=[NSIndexPath indexPathForRow:self.cur inSection:0];
        UICollectionViewCell * oldCell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:oldIndex];
        oldCell.backgroundColor = [UIColor whiteColor];
    }
    
    self.cur = indexPath.row;
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    cell.backgroundColor = [UIColor greenColor];
    NSLog(@"item======%d",indexPath.item);
    NSLog(@"row=======%d",indexPath.row);
    NSLog(@"section===%d",indexPath.section);
    
    
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor redColor]];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    // Do any additional setup after loading the view, typically from a nib.
    self.cur = -1;
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
@end
