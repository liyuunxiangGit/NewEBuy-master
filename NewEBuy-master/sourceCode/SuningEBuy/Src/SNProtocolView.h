//
//  SNProtocolView.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-11-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNProtocolView : UIView



@property(nonatomic,strong)NSString *pTitle;

@property(nonatomic,strong)NSString *pValue;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UITextView *valueTextView;
@property (nonatomic, strong) UIButton                  *deleteBtn;


-(void)showProtocol;

-(void)hideProtocol;

@end
