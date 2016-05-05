//
//  ProductIntroductionViewController.h
//  SuningEBuy
//
//  Created by  on 12-9-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "DataProductBasic.h"

@interface ProductIntroductionViewController : CommonViewController<UIWebViewDelegate>
{
    UIWebView            *_introduceWebView;
    DataProductBasic *_dataProductBasic;
    BOOL _isNeedData;
    NSURL *_requestURL;         
    NSString *_productName;
}
@property  (nonatomic,strong) UIWebView *introduceWebView; 
@property (nonatomic,strong) DataProductBasic *dataProductBasic;
@property (nonatomic) BOOL isNeedData;
@property (nonatomic,strong) NSURL *requestURL;
@property (nonatomic,strong) NSString *productName;
-(void)initWebView;

@end
