//
//  PackagesDetailCCell.h
//  CDC
//
//  Created by cdc on 2018/10/9.
//  Copyright © 2018年 CDC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackagesDetailCCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UIImageView *maskImg;
@property(nonatomic,strong)UILabel *nameLab;

-(void)updateSelect:(BOOL)isSelect;
@end

NS_ASSUME_NONNULL_END
