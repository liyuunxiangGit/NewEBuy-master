//
//  UserConsultantViewController.h
//  SuningEBuy
//
//  Created by xingxuewei on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "PlaceholderTextView.h"
#import "DataProductBasic.h"
#import "NewEvalutionService.h"
#import "ToolBarButton.h"

@interface UserConsultantViewController : CommonViewController<UITextViewDelegate,ToolBarButtonDelegate,UIPickerViewDelegate,UIPickerViewDataSource,NewEvalutionServiceDelegate>
{
    NSArray         *_categoryList;
}

@property (nonatomic, strong)   UILabel             *categoryLbl;

@property (nonatomic, strong)   ToolBarButton       *categoryTypeBtn;

@property (nonatomic, strong)   UIPickerView        *pickView;

@property (nonatomic, strong)   UILabel             *contentLbl;

@property (nonatomic, strong)   PlaceholderTextView         *contentTFd;

@property (nonatomic, strong)   UILabel             *wordCountLbl;

@property (nonatomic ,strong)   DataProductBasic    *product;

@property (nonatomic, strong)   NewEvalutionService *evalutionService;

@property (nonatomic, strong)   NSString            *modelType;


- (id)initWithBasicDTO:(DataProductBasic *)dto;

@end
