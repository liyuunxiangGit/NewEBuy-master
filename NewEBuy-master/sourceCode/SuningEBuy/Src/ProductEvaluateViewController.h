//
//  ProductEvaluateViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-9.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import "TPKeyboardAvoidingTableView.h"
#import "DLStarRatingControl.h"
#import "PlaceholderTextView.h"
#import "DataProductBasic.h"
#import "EvaluateService.h"

@interface ProductEvaluateViewController : CommonViewController <DLStarRatingDelegate, UITextFieldDelegate, UITextViewDelegate,EvaluateServiceDelegate>
{
    TPKeyboardAvoidingTableView         *_peTableView;
    
    UITextField                         *_titleTextField;
    
    PlaceholderTextView                 *_contentTextView;
    
    NSString                            *_rating;
    
    DataProductBasic                    *_dataSource;
    
    ASIFormDataRequest                  *productEvaASIHTTPRequest;
    
    UILabel                             *_mesLabel;
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *peTableView;

@property (nonatomic, strong) UITextField *titleTextField;

@property (nonatomic, strong) PlaceholderTextView *contentTextView;

@property (nonatomic, strong) NSString    *rating;

@property (nonatomic, strong) DataProductBasic *dataSource;

@property (nonatomic, strong) UILabel *mesLabel;

@property (nonatomic, strong) EvaluateService *EvaluateService; 


@end
