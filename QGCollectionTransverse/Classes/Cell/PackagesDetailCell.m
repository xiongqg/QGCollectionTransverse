//
//  PackagesDetailCell.m
//  CDC
//
//  Created by cdc on 2018/9/28.
//  Copyright © 2018年 CDC. All rights reserved.
//

#import "PackagesDetailCell.h"
#import "PackagesDetailCCell.h"
#import "Header.h"
@implementation PackagesDetailCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initCustomView
{
//    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BXScreenW, 140)];
//    [self.contentView addSubview:scrollView];
//    self.scrollView=scrollView;
//    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.showsHorizontalScrollIndicator = NO;
    
    _collectionView = ({
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(130, 130);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 2;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, BXScreenW,138) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[PackagesDetailCCell class] forCellWithReuseIdentifier:@"PackagesDetailCCell"];        
        [self.contentView addSubview:collectionView];
        collectionView;
    });
    self.selectArr=[NSMutableArray array];
    self.selectIndex=0;
}

-(void)setSelectType:(NSInteger)selectIdx
{
    self.selectIndex=selectIdx;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PackagesDetailCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PackagesDetailCCell" forIndexPath:indexPath];
    if (indexPath.item==self.selectIndex) {
        [cell.maskImg setHidden:NO];
    }else{
        [cell.maskImg setHidden:YES];
    }
    
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-  (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    PackagesDetailCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PackagesDetailCCell" forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    [cell.nameLab setBackgroundColor:TEXTCOLOR_RED];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    PackagesDetailCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PackagesDetailCCell" forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor whiteColor]];
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    //    [(MyCollectionViewCell *)cell configureCellWithPostURL:@"postImage.jpg"];
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){135,138};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectIndexBlock) {
        self.selectIndexBlock(indexPath.item);
    }
}
@end
