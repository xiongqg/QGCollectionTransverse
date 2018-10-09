//
//  PackagesDetailHeaderCell.m
//  CDC
//
//  Created by cdc on 2018/9/28.
//  Copyright © 2018年 CDC. All rights reserved.
//

#import "PackagesDetailHeaderCell.h"
#import "Header.h"
@implementation PackagesDetailHeaderCell
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
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, BXScreenW-20, (BXScreenW-20)/4*3)];
//    [img setBackgroundColor:[UIColor redColor]];
    [img setImage:[UIImage imageNamed:@"test.jpg"]];
    [self.contentView addSubview:img];
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, QGViewYH(img)+10, BXScreenW-100, 20)];
    //    [titleLab setBackgroundColor:TEXTCOLOR_RED];
    [titleLab setFont:[UIFont boldSystemFontOfSize:17]];
    [titleLab setTextColor:TEXTCOLOR51];
    [titleLab setText:@"套餐标题套餐标题套餐标题"];
    [self.contentView addSubview:titleLab];
    //    self.titleLab=titleLab;
    UILabel *detailLab=[[UILabel alloc]initWithFrame:CGRectMake(QGViewX(titleLab), QGViewYH(titleLab), QGViewW(titleLab), 30)];
    [detailLab setFont:[UIFont systemFontOfSize:14]];
    [detailLab setTextColor:TEXTCOLOR102];
    [detailLab setText:@"套餐简介套餐简介套餐简介套餐简介"];
    [self.contentView addSubview:detailLab];
}

@end
