//
//  ProductNumberCell.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-11-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "keyboardNumberPadReturnTextField.h"
#import "DataProductBasic.h"

@protocol ProductNumberCellDelegate <NSObject>


@optional

-(void)valueChange:(NSUInteger)number;
-(void)overSide;
@end
@interface ProductNumberCell : UITableViewCell<KeyboardDoneTappedDelegate,UITextFieldDelegate>


@property(nonatomic,strong)UILabel *numberLab;
@property(nonatomic,strong)UIButton *btnAdd;
@property(nonatomic,strong)UIButton *btnDelete;
@property(nonatomic,strong)UILabel *limitLbl;   //限购
@property(nonatomic,strong)keyboardNumberPadReturnTextField *numberTF;

@property(nonatomic,assign)id<ProductNumberCellDelegate> mydelegate;

@property(nonatomic, strong) DataProductBasic *productBase;

- (void)setProductInfo:(DataProductBasic *)dto;

@end
