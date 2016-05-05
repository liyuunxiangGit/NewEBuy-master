//
//  NewProductConsultantViewController.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NewProductConsultantViewController.h"

@implementation NewProductConsultantViewController

@synthesize askTextView = _askTextView;

@synthesize askLayer = _askLayer;

@synthesize product = _product;

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    TT_RELEASE_SAFELY(_askTextView);
    
    TT_RELEASE_SAFELY(_askLayer);
    
    TT_RELEASE_SAFELY(service);
    
}

- (id)initWithDTO:(DataProductBasic *)dto {
    self = [super init];
    if (self) {
        
        self.title = L(@"New advisory");
        self.pageTitle = L(@"show_productDetail_productConsult");
        
//        UIBarButtonItem  *commit = [[UIBarButtonItem alloc]initWithTitle:L(@"Commit") style:UIBarButtonItemStylePlain target:self action:@selector(commitAsk)];
//        
//        self.navigationItem.rightBarButtonItem = commit;
//        
//        TT_RELEASE_SAFELY(commit);

        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Commit")];

        //注册键盘通知
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        
#ifdef __IPHONE_5_0
        
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        
        if (version >= 5.0)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        }
        
#endif
        
        self.product =dto;
        
        service = [[NewProductConsultantService alloc]init];
        
        service.delegate = self;
    }
    return self;
}

- (void)righBarClick
{
    [self commitAsk];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    
    //get the origin of the keyboard when it's displayed
    
    NSDictionary *userInfo =[notification userInfo];
    
    NSValue  *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboarRect = [aValue CGRectValue];
    
    CGFloat height = self.view.frame.size.height - keyboarRect.size.height+49 -10;
   
    CGRect layerFrame = self.askLayer.frame;
    
    [self.askLayer setFrame:CGRectMake(layerFrame.origin.x, layerFrame.origin.y, layerFrame.size.width, height)];

    CGRect textFrame = self.askTextView.frame;
    
    [self.askTextView setFrame:CGRectMake(textFrame.origin.x, textFrame.origin.y, textFrame.size.width, height)];
}  

//点击商品咨询发送按钮，发送发表商品咨询请求
- (void)commitAsk{
    
    if (self.askTextView.text == nil || [self.askTextView.text isEqualToString:@""]) {
        
        [self presentSheet:L(@"Please input your question") posY:80];
    }
    
    [self.askTextView resignFirstResponder];
    
    [self displayOverFlowActivityView];
    
    [service  beginSendNewProductConsultantHttpRequest:_product text:self.askTextView.text];
}

- (void)loadView{
    
    [super loadView];
    
    [self.view.layer addSublayer:self.askLayer];
    
    [self.view addSubview:self.askTextView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.askTextView becomeFirstResponder];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
}

- (void)viewDidUnload{
    
    [super viewDidUnload];
}

- (PlaceholderTextView *)askTextView{
    
    if (!_askTextView) {
        
        _askTextView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(10, 5, 310, 127)];
   
        _askTextView.backgroundColor = [UIColor clearColor];
        
        _askTextView.font = [UIFont systemFontOfSize:16.0];
        
        _askTextView.userInteractionEnabled = YES;
        
        _askTextView.placeholder =  L(@"Please input your question here");
    }
    
    return  _askTextView;
}

- (CALayer*)askLayer{
    if (!_askLayer) {
        
        _askLayer = [[CALayer alloc]init];
        
        _askLayer.frame = CGRectMake(5, 5, 310, 137);
        
        _askLayer.backgroundColor = [UIColor whiteColor].CGColor;
        
        _askLayer.borderColor = [UIColor grayColor].CGColor;
        
        _askLayer.borderWidth =1.0f;
        
        _askLayer.cornerRadius = 10;
        
        _askLayer.masksToBounds =YES;
    }
    
    return _askLayer;
}

//发表商品咨询请求成功后处理
//1.成功返回商品咨询页面
//2.显示失败信息
- (void) newProductConsultantCompleted:(BOOL)isSuccess errorMsg:(NSString*)errorMsg{
    
    [self  removeOverFlowActivityView];
    
    if (isSuccess == NO) {
        
        [self presentSheet:L(@"Sorry loading failed") posY:80];
        
    }
    else{
        
        if ([errorMsg isEqualToString:@"Advisory success"]) {
             
            [self backToProductConsultant];
            
        }
        else{
            
            [self presentSheet:L(@"Advisory failed") posY:80];
        }
    }
    
}


//返回商品咨询页面
- (void)backToProductConsultant{
    
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil message:L(@"Advisory success") delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];
    alert.tag = 226;
    [alert show];
    
}


#pragma mark - AlertMessageViewDelegate
-(void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 226) {
        
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
    
}

@end
