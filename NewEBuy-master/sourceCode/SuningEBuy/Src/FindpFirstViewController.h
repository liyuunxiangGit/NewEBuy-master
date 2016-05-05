//
//  FindpFirstViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindPasswordService.h"
#import "FindPasswordDTO.h"

#import "SNUITableViewCell.h"

@interface FindpFirstViewController : CommonViewController<FindPasswordServiceDelegate,EGOImageViewDelegate,EGOImageViewExDelegate,UITextFieldDelegate>
{
    
}

@property (nonatomic, strong) UITextField               *phoneNumTextField;
@property (nonatomic, strong) UITextField               *codeTextField;
@property (nonatomic, strong) EGOImageViewEx            *codeImageView;

@property (nonatomic, strong) FindPasswordService       *findPasswordService;
@property (nonatomic, strong) FindPasswordDTO           *findPasswordDto;

@property (nonatomic, strong) UIView                    *footView;

@end
