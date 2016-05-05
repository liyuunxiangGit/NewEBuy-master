//
//  HotSaleViewController.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-8-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "HotSaleViewController.h"
#import "HotSalePreviewView.h"
#import "HotSaleThumbnailsView.h"
#import "DataProductBasic.h"
#import "ProductDetailViewController.h"

#define ThumbnailsIcon       [UIImage imageNamed:@"hotSaleThumbnailsIcon.png"]
#define PreviewImgIcon       [UIImage imageNamed:@"hotSalePreviewIcon.png"]


@interface HotSaleViewController ()

@property (nonatomic, strong) InterestProductService                *service;
    
@property (nonatomic, strong)NSArray                        *hotSaleProductList;
 
@property (nonatomic, strong)UIButton                       *navItemButton;

@property (nonatomic, strong) HotSalePreviewView            *previewView;

@property (nonatomic, strong) HotSaleThumbnailsView         *thumbnailsView;

@end


@implementation HotSaleViewController

@synthesize service= _service;

@synthesize hotSaleProductList=_hotSaleProductList;

@synthesize navItemButton =_navItemButton;

@synthesize previewView = _previewView;
@synthesize thumbnailsView =_thumbnailsView;


- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_hotSaleProductList);
    TT_RELEASE_SAFELY(_navItemButton);
    TT_RELEASE_SAFELY(_previewView);
    TT_RELEASE_SAFELY(_thumbnailsView);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (id)init
{
    if (self = [super init]) 
    {
        self.title = L(@"top recomment");
        self.pageTitle = L(@"sale_hotSale");
        // 注册进入详情通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushProductDetailAction:) name:HOTSALE_TO_PRODUCTDETAIL_NOTIFICATION object:nil];
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    //self.view.frame = CGRectMake(0, 0, 320, 367);
    
    CGRect frame = self.view.bounds;
    frame.size.height -= 92;
    self.thumbnailsView.frame = frame;
    
    [self.view addSubview:self.thumbnailsView];
    
    _service = [[InterestProductService alloc]init];
    
    _service.delegate = self;
        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isHotSaleLoaded) {
        
        [self displayOverFlowActivityView];

        [self.service beginGetIntrestProductsIsLimit21:NO];
    }
}

- (HotSaleThumbnailsView *)thumbnailsView
{
    if (!_thumbnailsView) 
    {
        _thumbnailsView = [[HotSaleThumbnailsView alloc] initWithFrame:self.view.bounds];
    }
    
    return _thumbnailsView;
}

- (HotSalePreviewView *)previewView
{
    if (!_previewView)
    {
        _previewView = [[HotSalePreviewView alloc] initWithFrame:self.view.bounds];
    }
    
    return _previewView;
}

- (UIButton *)navItemButton
{
    if (!_navItemButton) 
    {
        _navItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_navItemButton setImage:PreviewImgIcon forState:UIControlStateNormal];
        
        _navItemButton.size = PreviewImgIcon.size;
        
        [_navItemButton addTarget:self action:@selector(viewSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _navItemButton;
}

#pragma mark -
#pragma mark View Switch Method
- (void)viewSwitchAction:(id)sender
{
    
    [self.view removeAllSubviews];
    
    //提示无数据
    if ([self.hotSaleProductList count] == 0)
    {
        [self presentSheet:L(@"PRNoProductInfo")];
        
        return;
    }
    
    
    if (_isShowThumbnails)
    {
        [self.view addSubview:self.previewView];
        
        self.previewView.hotSaleProductList = self.hotSaleProductList;
        
    }
    else
    {
        [self.view addSubview:self.thumbnailsView];
        
        self.thumbnailsView.hotSaleProductList = self.hotSaleProductList;
        
    }
    
    _isShowThumbnails = !_isShowThumbnails;
    
    UIBarButtonItem *viewSwitchItem = self.navigationItem.rightBarButtonItem;
    UIButton *rightItem = (UIButton *)viewSwitchItem.customView;
    
    UIImage *rightItemIcon = (!_isShowThumbnails ? ThumbnailsIcon : PreviewImgIcon);
    [rightItem setImage:rightItemIcon forState:UIControlStateNormal];
    
}

#pragma mark -
#pragma mark HotSaleProductDelegate 

- (void)getIntrestProductsComplete:(BOOL)isSuccess errorMsg:(NSString *)errorMsg productList:(NSArray *)list
{
    [self removeOverFlowActivityView];
    
    if (!isSuccess) {
        
        [self presentSheet:L(errorMsg)];
        
        return;
    }
    else
    {
        isHotSaleLoaded = YES;
        
        self.hotSaleProductList = list;
        
        if (!self.navigationItem.rightBarButtonItem) {
            
            _isShowThumbnails = YES;
            
            UIBarButtonItem *viewSwitchItem = [[UIBarButtonItem alloc] initWithCustomView:self.navItemButton];
            
            self.navigationItem.rightBarButtonItem = viewSwitchItem;
            
            TT_RELEASE_SAFELY(viewSwitchItem);  
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:HOTSALE_LOADED_NOTIFICATION object:self.hotSaleProductList];
        
        //提示无数据
        if ([self.hotSaleProductList count] == 0)
        {
            [self presentSheet:L(@"PRNoProductInfo")];
        }
        
        return;
    }
}

#pragma mark -
#pragma mark Go Product Detail
- (void)pushProductDetailAction:(NSNotification *)notification
{
    DataProductBasic *productDto = [notification object];
    
    ProductDetailViewController *_ProductViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:productDto];
    
    [self.navigationController pushViewController:_ProductViewController animated:YES];
    
    TT_RELEASE_SAFELY(_ProductViewController);
}

@end

