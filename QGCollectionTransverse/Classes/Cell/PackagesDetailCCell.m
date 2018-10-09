//
//  PackagesDetailCCell.m
//  CDC
//
//  Created by cdc on 2018/10/9.
//  Copyright © 2018年 CDC. All rights reserved.
//
#import "Header.h"
#import "PackagesDetailCCell.h"

@implementation PackagesDetailCCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    
    return self;
}
-(void)initView
{
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 115, 88)];
//    [img setBackgroundColor:[UIColor blueColor]];
    [img setImage:[UIImage imageNamed:@"123.jpg"]];

    [self addSubview:img];
    UIImageView *maskImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 115, 88)];
    [maskImg setBackgroundColor:RGBA(255, 255, 255, 0.5)];
    [self addSubview:maskImg];
    self.maskImg=maskImg;
    [self.maskImg setHidden:YES];
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(10, QGViewYH(img), 115, 30)];
    [nameLab setText:@"name-name"];
    [nameLab setFont:[UIFont systemFontOfSize:14]];
    [nameLab setTextColor:[UIColor blackColor]];
    [nameLab setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:nameLab];
    self.nameLab=nameLab;
}
-(void)updateSelect:(BOOL)isSelect
{
    if (isSelect) {
        [self.maskImg setHidden:NO];
    }else{
        [self.maskImg setHidden:YES];
    }
}
@end
