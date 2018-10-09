//
//  PackagesDetailCell.h
//  CDC
//
//  Created by cdc on 2018/9/28.
//  Copyright © 2018年 CDC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface PackagesDetailView:UIView
-(void)setViewDataWithDic:(NSDictionary*)dic;
@end
@interface PackagesDetailCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *selectArr;

@property(nonatomic,copy)void(^selectIndexBlock)(NSInteger index);

-(void)setCellDataArr:(NSArray*)arr;
-(void)setSelectType:(NSInteger)selectIdx;
@end

NS_ASSUME_NONNULL_END
