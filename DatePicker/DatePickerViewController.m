//
//  DatePickerViewController.m
//  liu
//
//  Created by liu on 16/4/19.
//  Copyright © 2016年 liu. All rights reserved.
//

#define datePickerCellReuse @"datePickerCellReuse"
#define datePickerHeaderReuse @"datePickerHeaderReuse"
#define datePickerFooterReuse @"datePickerFooterReuse"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "DatePickerViewController.h"

#import "FactoryLab.h"
#import "WeekView.h"
#import "DatePickerView.h"
#import "NSDate+Extension.h"

@interface DatePickerViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    void(^selectBlock)(void);
}

@property (nonatomic, strong) WeekView              *weekView;
@property (nonatomic, strong) UICollectionView      *collection;

@end

@implementation DatePickerViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
#pragma deploymate push "ignored-api-availability"
        self.edgesForExtendedLayout = UIRectEdgeNone;
#pragma deploymate pop
    }
    
    [self setTitle:@"提现到银行卡时间"];
    
    [self.view addSubview:self.weekView];
    [self.view addSubview:self.collection];
    
    [self updateViewConstraints];
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [_weekView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@30);
    }];
}

-(void)selectClick:(void (^)(void))select
{
    selectBlock = select;
}

#pragma mark collectionview delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSDate *date = [[NSDate date] dateOffsetMonth:section];
    
    return [date daysInCurrentMonth] + [date firstWeekdayInCurrentMonth].integerValue;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DatePickerCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:datePickerCellReuse forIndexPath:indexPath];
    
    [cell updateCellIndex:indexPath select:(_selectIndex == indexPath)];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        DatePickerHeaderView * headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:datePickerHeaderReuse forIndexPath:indexPath];
        
        NSDate *date = [[NSDate date] dateOffsetMonth:indexPath.section];
        
        headerCell.tipLab.text = [date ymString];
        
        return headerCell;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        DatePickerFooterView * footerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:datePickerFooterReuse forIndexPath:indexPath];
        footerCell.hidden = !(indexPath.section == 0);
        
        return footerCell;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    _selectIndex = indexPath;
    
    [collectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        if (selectBlock) {
            selectBlock();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark set get

-(WeekView *)weekView
{
    if (_weekView == nil) {
        _weekView = [[WeekView alloc] init];
    }
    
    return _weekView;
}

-(UICollectionView *)collection
{
    if (_collection == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/7.f, SCREEN_WIDTH/7.f)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH, 50)];
        [flowLayout setFooterReferenceSize:CGSizeMake(SCREEN_WIDTH, 0.5f)];
        [flowLayout setMinimumInteritemSpacing:0]; //设置 y 间距
        [flowLayout setMinimumLineSpacing:0]; //设置 x 间距
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 10, 0);//设置其边界
        //UIEdgeInsetsMake(设置上下cell的上间距,设置cell左距离,设置上下cell的下间距,设置cell右距离);
        
        //其布局很有意思，当你的cell设置大小后，一行多少个cell，由cell的宽度决定
        
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-[[UIApplication sharedApplication] statusBarFrame].size.height-self.navigationController.navigationBar.frame.size.height-30) collectionViewLayout:flowLayout];
        _collection.dataSource = self;
        _collection.delegate = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.backgroundColor = [UIColor whiteColor];
        
        [_collection registerClass:[DatePickerCell class] forCellWithReuseIdentifier:datePickerCellReuse];
        [_collection registerClass:[DatePickerHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:datePickerHeaderReuse];
        [_collection registerClass:[DatePickerFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:datePickerFooterReuse];
    }
    
    return _collection;
}

-(void)setSelectIndex:(NSIndexPath *)selectIndex
{
    _selectIndex = selectIndex;
    
    if (selectBlock) {
        selectBlock();
    }
}

-(NSString *)selectDate
{
    if (_selectIndex == nil) {
        return @"";
    }
    
    NSDate *selectDate = [NSDate dateFromSelectIndex:_selectIndex];
    
    return [NSString stringWithFormat:@"%@ %@",selectDate.dateString,selectDate.weekdayString];
}

-(double)selectIntervel
{
    if (_selectIndex == nil) {
        return 0.f;
    }
    
    NSDate *selectDate = [NSDate dateFromSelectIndex:_selectIndex];
    
    return [selectDate timeIntervalSince1970];
}

@end
