//
//  ViewController.m
//  QGCollectionTransverse
//
//  Created by cdc on 2018/10/9.
//  Copyright © 2018年 QG. All rights reserved.
//

#import "ViewController.h"
#import "PackagesDetailHeaderCell.h"
#import "PackagesDetailCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView *navBarHairlineImageView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *goodsArr;
@property(nonatomic,assign)NSUInteger page;
@property(nonatomic,strong)NSMutableArray *selectArr;


@property (strong, nonatomic) UILabel *goodsNumLabel;
@property (strong, nonatomic) UIView *cartView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initNav];
    [self initView];
}

-(void)initData{
    _page=0;
    _goodsArr=[NSMutableArray array];
    _selectArr=[NSMutableArray array];
    [_selectArr addObjectsFromArray:@[@"0",@"0",@"0",@"0",@"0"]];
}
-(void)initView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH) style:UITableViewStyleGrouped];
    //    [tableView setBackgroundColor:[UIColor redColor]];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tableView];
    tableView.sectionIndexColor = [UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:1];
    tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
   
    
    UIView *cartView=[[UIView alloc]initWithFrame:CGRectMake(BXScreenW-70, ViewHeight1-70-kTabBarHeight, 70, 70)];
    [cartView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:cartView];
    self.cartView=cartView;
    UIButton *cartBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [cartBtn setFrame:CGRectMake(10, 10, 50, 50)];
    [cartBtn setBackgroundColor:[UIColor greenColor]];
    [cartBtn addTarget:self action:@selector(bayCerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cartView addSubview:cartBtn];
    UILabel *goodsNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, 20, 20)];
    [goodsNumLabel setText:@"0"];
    [goodsNumLabel setFont:[UIFont boldSystemFontOfSize:11]];
    [goodsNumLabel setBackgroundColor:TEXTCOLOR_RED];
    [goodsNumLabel setTextColor:RGB(255, 255, 255)];
    [goodsNumLabel setTextAlignment:NSTextAlignmentCenter];
    [cartView addSubview:goodsNumLabel];
    self.goodsNumLabel=goodsNumLabel;
    [self setRoundedCorners:goodsNumLabel size:CGSizeMake(20/2, 20/2)];
    [self setRoundedCorners:goodsNumLabel size:CGSizeMake(20/2, 20/2)];
    UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [panRcognize setMinimumNumberOfTouches:1];
    [panRcognize setEnabled:YES];
    [panRcognize delaysTouchesEnded];
    [panRcognize cancelsTouchesInView];
    [cartView addGestureRecognizer:panRcognize];
    
}
//设置圆角
-(void)setRoundedCorners:(UIView*)view size:(CGSize)szie
{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:szie];
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
-(void)loadNewData
{
    self.page=0;
    [self getList];
}
-(void)initNav{
    
}
#pragma mark -- 手势
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer{    //移动状态
    UIGestureRecognizerState recState =  recognizer.state;
    switch (recState) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.navigationController.view];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
            
        }            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint stopPoint = CGPointMake(0, QGViewH(self.tableView) / 2.0);
            if (recognizer.view.center.x < BXScreenW / 2.0) {
                stopPoint = CGPointMake(self.cartView.frame.size.width/2.0, recognizer.view.center.y);
            }else{
                stopPoint = CGPointMake(BXScreenW - self.cartView.frame.size.width/2.0, recognizer.view.center.y);
            }                        //如果按钮超出屏幕边缘
            if (stopPoint.y + self.cartView.frame.size.width>= (BXScreenH)) {
                stopPoint = CGPointMake(stopPoint.x, (BXScreenH-[[UIApplication sharedApplication] statusBarFrame].size.height) - self.cartView.frame.size.width/2.0);
                NSLog(@"超出屏幕下方了！！"); //这里注意iphoneX的适配。。X的SCREEN高度算法有变化。
            }
            if (stopPoint.x - self.cartView.frame.size.width/2.0 <= 0) {
                stopPoint = CGPointMake(self.cartView.frame.size.width/2.0, stopPoint.y);
            }
            if (stopPoint.x + self.cartView.frame.size.width/2.0 >= BXScreenW) {
                stopPoint = CGPointMake(BXScreenW - self.cartView.frame.size.width/2.0, stopPoint.y);
            }
            if (stopPoint.y - self.cartView.frame.size.width/2.0 <= 0) {
                stopPoint = CGPointMake(stopPoint.x, self.cartView.frame.size.width/2.0+0);
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
        default:
            break;
            
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}
#pragma mark - UIButton Action
-(void)bayCerBtnAction:(UIButton*)btn
{
    
}
-(void)joinBtnAction:(id)sender
{
    
}
-(void)buyBtnAction:(id)sender
{
    
}
-(void)loginAction
{
  
}
#pragma mark - Connect
-(void)getList
{
    
}
#pragma mark -- tableviewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return (BXScreenW-20)/4*3+65;
    }
    return 140;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.001;
    }
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView *view=[UIView new];
        [view setBackgroundColor:[UIColor whiteColor]];
        return view;
    }
    UIView *view=[UIView new];
    [view setBackgroundColor:RGBA(240, 243, 245, 1)];
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 30)];
    [titleLab setFont:[UIFont systemFontOfSize:14]];
    [titleLab setTextColor:[UIColor blackColor]];
    [titleLab setText:@"滋补汤（五选一）"];
    [view addSubview:titleLab];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[UIView new];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        static NSString *identifierstring = @"PackagesDetailHeaderCell";
        PackagesDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierstring];
        if (cell == nil) {
            cell = [[PackagesDetailHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierstring];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else{
        static NSString *identifierstring = @"PackagesDetailCell";
        PackagesDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierstring];
        if (cell == nil) {
            cell = [[PackagesDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierstring];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        [cell setSelectType:[[_selectArr objectAtIndex:indexPath.section-1]integerValue]];
        if (self.goodsArr.count>0) {
            
        }
        cell.selectIndexBlock = ^(NSInteger index) {
            [self.selectArr replaceObjectAtIndex:indexPath.section-1 withObject:[NSString stringWithFormat:@"%d",index]];
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            //            [self.tableView reloadData];
        };
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIImage*) createImageWithColor: (UIColor*) color

{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

@end
