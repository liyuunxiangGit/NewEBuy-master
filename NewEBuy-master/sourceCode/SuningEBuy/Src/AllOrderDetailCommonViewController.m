//
//  AllOrderDetailCommonViewController.m
//  SuningEBuy
//
//  Created by xmy on 10/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllOrderDetailCommonViewController.h"

@interface AllOrderDetailCommonViewController ()

@end

@implementation AllOrderDetailCommonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];

}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
//    [self.view addSubview:self.bottomView];
    
}
//- (UIView*)bottomView
//{
//    if(!_bottomView)
//    {
//        _bottomView = [[UIView alloc] init];
//        
//        _bottomView.backgroundColor = [UIColor whiteColor];
//        
//        _bottomView.frame = CGRectMake(0, self.view.frame.size.height - 48, self.view.frame.size.width, 48);
//        
//        [_bottomView addSubview:self.bottomCell];
//
//    }
//    
//    return _bottomView;
//}


- (void)goToMyEbuy
{
    
    [self orderYiGouBtnShowRightSideView];
    
//    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:4];
//    
//    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:4] popToRootViewControllerAnimated:NO];
    
    
}

- (void)backBtnAction
{
    [self backForePage];
}


- (OrderDetailBottomCell*)bottomCell
{
    static NSString *str = @"OrderDetailBottomCell";
    
    if(!_bottomCell)
    {
        _bottomCell = [[OrderDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        _bottomCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 48);

        _bottomCell.userInteractionEnabled = YES;
        
        _bottomCell.contentView.userInteractionEnabled = YES;
        
        [_bottomCell.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomCell.yiGouBtn addTarget:self action:@selector(goToMyEbuy) forControlEvents:UIControlEventTouchUpInside];
        
        _bottomCell.yiGouBtn.hidden = YES;
        _bottomCell.backBtn.hidden = YES;

    }
    
    return _bottomCell;
}

- (CGRect)setViewFrame:(BOOL)hasNav
{
    CGRect newframe = self.view.frame;
    
    if(hasNav == NO)
    {
//        origin=(x=0, y=0) size=(width=320, height=548)
        newframe = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
    }
    else
    {
//        origin=(x=0, y=0) size=(width=320, height=504)
     CGRect  frame = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
        
        return frame;
    }
    
    
    return newframe;
}

//tab，有bottomview但不展示hastab为Yes no则展示
- (CGRect)setCommonViewFrame:(BOOL)hasNav WithTab:(BOOL)hastab
{
    CGRect newframe = self.view.frame;
    
    if(hastab == YES)
    {
        return newframe;
        
    }
    else
    {
        if(hasNav == NO)
        {
            //        origin=(x=0, y=0) size=(width=320, height=548)
            newframe = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
        }
        else
        {
            //        origin=(x=0, y=0) size=(width=320, height=504)
            CGRect  frame = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
            
            return frame;
        }
    }
    
    
    return newframe;
}

@end
