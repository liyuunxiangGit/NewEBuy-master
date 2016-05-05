//
//  ProductNumberCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-11-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductNumberCell.h"

@implementation ProductNumberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self numberLab];
        
        [self btnDelete];
        
        [self btnAdd];
        
        [self numberTF];
        
        [self limitLbl];
        
        self.contentView.backgroundColor = RGBCOLOR(239, 239, 239);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel*)numberLab{
    
    if (!_numberLab) {
        
        _numberLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 40, 20)];
        
        _numberLab.text = L(@"Count");
        
        _numberLab.textColor = RGBCOLOR(102, 102, 102);
        
        _numberLab.font = [UIFont systemFontOfSize:13];
        
        _numberLab.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_numberLab];
    }
    
    return _numberLab;
}

- (UILabel *)limitLbl
{
    if (!_limitLbl) {
        
        _limitLbl = [[UILabel alloc] initWithFrame:CGRectMake(190, 20, 120, 20)];
        
        _limitLbl.backgroundColor = [UIColor clearColor];
        
        _limitLbl.font = [UIFont systemFontOfSize:14];
        
        _limitLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        
        [self.contentView addSubview:_limitLbl];
    }
    return _limitLbl;
}

-(UIButton *)btnAdd{
    
    if (!_btnAdd) {
        _btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, 44, 40)];
        _btnAdd.backgroundColor = [UIColor clearColor];
        
        [_btnAdd setImage:[UIImage imageNamed:@"productDetail_add_enabled.png"] forState:UIControlStateNormal];
        [_btnAdd setImage:[UIImage imageNamed:@"productDetail_add_disabled.png"] forState:UIControlStateDisabled];
        [_btnAdd setImage:[UIImage imageNamed:@"productDetail_add_clicked.png"] forState:UIControlStateHighlighted];
        [_btnAdd addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_btnAdd];
    }
    
    return _btnAdd;
}

- (DataProductBasic *)productBase
{
    if (!_productBase) {
        _productBase = [[DataProductBasic alloc] init];
    }
    return _productBase;
}

-(UIButton *)btnDelete{
    
    if (!_btnDelete) {
        _btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(50, 10, 44, 40)];
        _btnDelete.backgroundColor = [UIColor clearColor];
        
        [_btnDelete setImage:[UIImage imageNamed:@"productDetail_delete_enabled.png"] forState:UIControlStateNormal];
        [_btnDelete setImage:[UIImage imageNamed:@"productDetail_delete_disabled.png"] forState:UIControlStateDisabled];
        [_btnDelete setImage:[UIImage imageNamed:@"productDetail_delete_clicked.png"] forState:UIControlStateHighlighted];
        [_btnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_btnDelete];
    }
    
    return _btnDelete;
}
-(keyboardNumberPadReturnTextField *)numberTF{
    
    if (!_numberTF) {
        
        _numberTF = [[keyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(89, 19, 35,22)];
        
        _numberTF.text = @"1";
        
        //_numberTF.backgroundColor = [UIColor grayColor];
        _numberTF.textAlignment = UITextAlignmentCenter;
        
        _numberTF.textColor = RGBCOLOR(102, 102, 102);
        
        _numberTF.font = [UIFont systemFontOfSize:15];
        
        _numberTF.clearButtonMode = UITextFieldViewModeNever;
        
        _numberTF.delegate = self;
        
        //_numberTF.enabled = NO;
        
        _numberTF.doneButtonDelegate = self;
        _numberTF.keyboardType = UIKeyboardTypeNumberPad;
        
        _numberTF.background = [UIImage imageNamed:@"productDetail_productNum.png"];
        
        [self.contentView addSubview:_numberTF];
    }
    
    return _numberTF;
}
-(void)addAction:(UIButton *)sender{
    
    
   // NSUInteger currentNum = [self.numberTF.text integerValue];
    
    NSString *changedStr = self.numberTF.text;
    NSInteger limitNum = [self limitBuyNum];
    
    if ([self isAllNumber:changedStr]
        && [changedStr integerValue] < limitNum
        && [changedStr integerValue] > 0)
    {
        
        self.numberTF.text = [NSString stringWithFormat:@"%d",[changedStr integerValue]+1];
        
        if ([self.numberTF.text integerValue] == limitNum) {
            self.btnAdd.enabled = NO;
        }
        if ([self.numberTF.text integerValue] > 1) {
            self.btnDelete.enabled = YES;
        }
    }
    else{
        
        if ([_mydelegate respondsToSelector:@selector(overSide)]) {
            
            [_mydelegate overSide];
        }
    }
    
   // self.numberTF.text = [NSString stringWithFormat:@"%d",currentNum+1];
    
    if ([_mydelegate respondsToSelector:@selector(valueChange:)]) {
        
        [_mydelegate valueChange:[self.numberTF.text integerValue]];
    }
}
-(void)deleteAction:(UIButton *)sender{
    
    
    NSString *changedStr = self.numberTF.text;
    
    NSInteger limitNum = [self limitBuyNum];
    
    if ([self isAllNumber:changedStr]
        && [changedStr integerValue] < (limitNum + 1)
        && [changedStr integerValue] >1 )
    {
        
        self.numberTF.text = [NSString stringWithFormat:@"%d",[changedStr integerValue]-1];
        
        if ([self.numberTF.text integerValue] == 1) {
            self.btnDelete.enabled = NO;
        }
        if ([self.numberTF.text integerValue] < limitNum) {
            self.btnAdd.enabled = YES;
        }
    }
    else{
        if ([_mydelegate respondsToSelector:@selector(overSide)]) {
            
            [_mydelegate overSide];
        }
    }
    
    if ([_mydelegate respondsToSelector:@selector(valueChange:)]) {
        
        [_mydelegate valueChange:[self.numberTF.text integerValue]];
    }
}
- (void)doneTapped:(id)sender
{
    [self numberDidChanged];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self numberDidChanged];
}

- (void)numberDidChanged
{
    [self.numberTF resignFirstResponder];
    
    NSString *changedStr = self.numberTF.text;
    NSInteger limitNum = [self limitBuyNum];
    
    if (![self isAllNumber:changedStr]
        || [changedStr integerValue] > limitNum
        || [changedStr integerValue] < 1)
    {
        self.numberTF.text = @"1";
        
        if ([_mydelegate respondsToSelector:@selector(overSide)]) {
            
            [_mydelegate overSide];
        }
    }
    
    if ([changedStr integerValue] == 1) {
        self.btnDelete.enabled = NO;
        self.btnAdd.enabled = YES;
    }
    if ([changedStr integerValue] == limitNum) {
        self.btnAdd.enabled = NO;
        self.btnDelete.enabled = YES;
    }
    if ([changedStr integerValue] > 1&& [changedStr integerValue] < limitNum)
    {
        self.btnAdd.enabled = YES;
        self.btnDelete.enabled = YES;
    }
    
    if ([_mydelegate respondsToSelector:@selector(valueChange:)]) {
        
        [_mydelegate valueChange:[self.numberTF.text integerValue]];
    }

}

//没人限购数量
- (NSInteger)limitBuyNum
{
    NSInteger limitNum;
    if (IsStrEmpty(self.productBase.limitBuyNum)) {
        limitNum = 99;
    }
    else
    {
        if ([self.productBase.limitBuyNum integerValue] > 99) {
            limitNum = 99;
        }else
        {
            limitNum = [self.productBase.limitBuyNum integerValue];
        }
    }
    return limitNum;
}

- (BOOL)isAllNumber:(NSString *)checkStr{
    
    NSString *ruleNumber = @"0123456789";
    
    for (int i=0; i<[checkStr length]; i++) {
        
        BOOL isNumber = NO;
        for (int j=0; j<10; j++) {
            
            if ([ [checkStr substringWithRange:NSMakeRange(i, 1)] isEqualToString:[ruleNumber substringWithRange:NSMakeRange(j, 1)]]) {
                
                isNumber = YES;
                break;
            }
        }
        
        if (NO == isNumber) {
            
            return isNumber;
        }
    }
    
    return YES;
}

- (void)setProductInfo:(DataProductBasic *)dto
{
    self.productBase = dto;
    
    if (IsStrEmpty(dto.limitBuyNum)) {
        self.limitLbl.hidden = YES;
    }
    else
    {
        self.limitLbl.hidden = NO;
        self.limitLbl.text = [NSString stringWithFormat:@"%@%@%@",L(@"Product_LimitAmount"),dto.limitBuyNum,L(@"Purchase_Jian")];
    }
}
@end
