//
//  ChooseSearchTypeView.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ChooseSearchTypeView.h"

@implementation ChooseSearchTypeView
+ (ChooseSearchTypeView *)sharedInstance
{
    static ChooseSearchTypeView *v = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v = [[ChooseSearchTypeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    
    return v;
}

+ (void)showOnWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:[ChooseSearchTypeView sharedInstance]];
    [window bringSubviewToFront:[ChooseSearchTypeView sharedInstance]];
}

+ (void)hide
{
    [[ChooseSearchTypeView sharedInstance] disappear];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(disappear)];
        ges.delegate = self;
        [self addGestureRecognizer:ges];
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint pt = [gestureRecognizer locationInView:self];
    if (CGRectContainsPoint(self.tableView.frame, pt))
        return NO;
    return YES;
}

- (void)disappear
{
    [self removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SEARCHTYPE_CHANGED object:nil];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 64, 105, 80) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self addSubview:_tableView];
    }
    
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCellIndi = @"typeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellIndi];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellIndi];
        
        UIView *vSepline = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
        vSepline.backgroundColor = RGBACOLOR(236, 236, 236, 1);
        [cell.contentView addSubview:vSepline];
        
        cell.contentView.backgroundColor = [UIColor colorWithRGBHex:0xf2f2f2];
        
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(7, 13, 14, 14)];
        logo.tag = 100;
        [cell.contentView addSubview:logo];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 50, 14)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = RGBCOLOR(112, 112, 112);
        label.tag = 101;
        [cell.contentView addSubview:label];
    }
    
    UIImageView *logo = (UIImageView *)[cell viewWithTag:100];
    UILabel *label = (UILabel *)[cell viewWithTag:101];
    
    if (indexPath.row == 0)
    {
        label.text = L(@"Search_Goods");
        logo.image = [UIImage imageNamed:@"shopSearchLogo_Product.png"];
    }
    else if (indexPath.row == 1)
    {
        label.text = L(@"Search_Store");
        logo.image = [UIImage imageNamed:@"shopSearchLogo_Shop.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row)
    {
        case 0:
        {
            [Config currentConfig].searchType = [NSNumber numberWithInt:0];
            break;
        }
        case 1:
        {
            [Config currentConfig].searchType = [NSNumber numberWithInt:1];
            break;
        }
        default:
            break;
    }
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"84050%d",indexPath.row +1], nil]];
    [[NSNotificationCenter defaultCenter] postNotificationName:SEARCHTYPE_CHANGED object:nil];
    [self disappear];
}
@end
