//
//  CommodityReviewViewController.m
//  SuningEBuy
//
//  Created by blues on 13-10-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommodityReviewViewController.h"

@interface CommodityReviewViewController ()

@end

@implementation CommodityReviewViewController

- (UIBarButtonItem *)baskBtn
{
    if (!_baskBtn)
    {
        _baskBtn = [[UIBarButtonItem alloc] init];
        _baskBtn.title = L(@"Product_EvaluateAndDisOrder");
    }
    
    return _baskBtn;
}

- (UIBarButtonItem *)submitBtn
{
    if (_submitBtn)
    {
        _submitBtn = [[UIBarButtonItem alloc] init];
        _submitBtn.title = L(@"CommitBtn");
    }
    
    return _submitBtn;
}

- (UIImageView *)commodityImgView
{
    if (!_commodityImgView)
    {
        _commodityImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.commodityNameLbl.text]];
        _commodityImgView.frame = CGRectMake(20, 15, 80, 100);
        _commodityImgView.backgroundColor = [UIColor clearColor];
    }
    
    return _commodityImgView;
}

- (UILabel *)commodityNameLbl
{
    if (!_commodityNameLbl)
    {
        _commodityNameLbl = [[UILabel alloc] init];
        _commodityNameLbl.frame = CGRectMake(120, 15,160,70);
        _commodityNameLbl.backgroundColor = [UIColor clearColor];
    }
    
    return _commodityNameLbl;
}

- (UILabel *)storeNameLbl
{
    if (!_storeNameLbl)
    {
        _storeNameLbl = [[UILabel alloc] init];
        _storeNameLbl.frame = CGRectMake(120, 85, 160, 30);
        _storeNameLbl.backgroundColor = [UIColor clearColor];
    }
    
    return _storeNameLbl;
}

- (UILabel *)satisfyLbl
{
    if (!_satisfyLbl)
    {
        _satisfyLbl = [[UILabel alloc] init];
        _satisfyLbl.frame = CGRectMake(10, 15, 100, 50);
        _satisfyLbl.backgroundColor = [UIColor clearColor];
        _satisfyLbl.textAlignment = NSTextAlignmentLeft;
        _satisfyLbl.font = [UIFont systemFontOfSize:40];
    }
    
    return _satisfyLbl;
}

- (UIImageView *)starImgView
{
    if (!_starImgView)
    {
        _starImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:L(@"Product_Star")]];
        _starImgView.frame = CGRectMake(0, 0, 30, 30);
        _starImgView.backgroundColor = [UIColor clearColor];
    }
    
    return _starImgView;
}

- (UITextField *)appraiseTextView
{
    if (!_appraiseTextView)
    {
        _appraiseTextView = [[UITextField alloc] init];
        _appraiseTextView.frame = CGRectMake(10, 80, 300, 140);
        _appraiseTextView.backgroundColor = [UIColor clearColor];
        _appraiseTextView.placeholder = L(@"Product_InputIdea");
    }
    
    return _appraiseTextView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"我要评价";
    self.navigationItem.leftBarButtonItem = self.baskBtn;
    self.navigationItem.rightBarButtonItem = self.submitBtn;
    
    UIView *upView = [[UIView alloc] init];
    upView.frame = CGRectMake(0, 0, 320, 130);
    [self.view addSubview:upView];
    
    [upView addSubview:self.commodityImgView];
    [upView addSubview:self.commodityNameLbl];
    [upView addSubview:self.storeNameLbl];
    
    UIView *downView = [[UIView alloc] init];
    downView.frame = CGRectMake(0, 130, 320, 286);
    [self.view addSubview:downView];
    
    [downView addSubview:self.satisfyLbl];
    [downView addSubview:self.appraiseTextView];
    for (int i = 0; i < 5; i++)
    {
        self.starImgView.frame = CGRectMake(170 + 35*i, 25, 30, 30);
        [downView addSubview:self.starImgView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
