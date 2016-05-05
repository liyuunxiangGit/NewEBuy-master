//
//  GBRefundCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBRefundCell.h"

#define UIBeginX 10

@implementation GBRefundCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initReasonView:(float)y{
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    for (int i=0; i<4; i++) {
        
        float x = 0;
        if(i==0){
            x=21;
        }
        else if(i==1){
            x=13;
        }
        else if(i==2){
            x=29;
        }
        else if(i==3){
            x=5;
        }
        
        SingleBtn *btn = [[SingleBtn alloc] initWithFrame:CGRectMake(x-5, y+i*35, 160, 25)];
        
        btn.btnValue = [self.keyArray objectAtIndex:i];
        [btn setTitle:[self.infoDic valueForKey:[self.keyArray objectAtIndex:i]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        if (0 == i) {
            
            btn.selected = YES;
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"checkbox_unselect.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"shop_cart_unchecked.png"] forState:UIControlStateDisabled];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectSingleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
        
        [btnArray addObject:btn];
        
    }
    
    self.singleBtn.btnArray = btnArray;
}
-(void)selectSingleBtnAction:(SingleBtn *)btn{
    
    
    [self.singleBtn touchbtn:btn];
    
    _refundInfo.refundReason = [self.singleBtn singleValue];
}

-(void)initCellView:(ReFundInfoDto *)dto{
    
    self.refundInfo = dto;
    [self.contentView removeAllSubviews];
    
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.refundPriceLab];
    [self.contentView addSubview:self.priceDesLab];
    [self.contentView addSubview:self.refundReasonLab];
    
    
    self.refundPriceLab.text = [NSString stringWithFormat:@"%@%d",L(@"LBRefundCount"),0];
    
    int max = 5;
    
    if (self.refundInfo.maxCount < 5
        && 0 < self.refundInfo.maxCount) {
        
        max = self.refundInfo.maxCount;
    }
    
    self.accountDesLab.text = [NSString stringWithFormat:@"%@%d%@",L(@"GBTheMost"),max,L(@"GBNumber")];//@"最多退款多少";
    
    int y=0;
    if (2 == [self.refundInfo.vouncherType intValue]) {
        
        [self.contentView addSubview:self.refundAccountLab];
        [self.contentView addSubview:self.refundAccountTF];
        [self.contentView addSubview:self.accountDesLab];
        self.refundAccountLab.frame = CGRectMake(UIBeginX, 10,80, 22);
        self.refundAccountTF.frame = CGRectMake(UIBeginX +80, 10, 50, 23);
        self.refundAccountTF.text = @"1";
        self.refundPriceLab.text =  [NSString stringWithFormat:@"%@%.02f",L(@"LBRefundCount2"),_refundInfo.price];
        self.accountDesLab.frame = CGRectMake(UIBeginX, 30, 200, 22);
        y=50;
        
        self.lineView.frame = CGRectMake(10, y+60, 300, 300-y);
    }
    else{
        
        int number = [_refundInfo.orderItemIdArray count];
        
        self.refundPriceLab.text =  [NSString stringWithFormat:@"%@%.02f",L(@"LBRefundCount2"),_refundInfo.price*number];
        
        self.lineView.frame = CGRectMake(10, y+60, 300, 300-y-60);
    }
    
    self.refundPriceLab.frame = CGRectMake(UIBeginX, y+10, 200, 22);
    self.priceDesLab.frame = CGRectMake(UIBeginX, y+30, 200, 22);
    self.refundReasonLab.frame = CGRectMake(UIBeginX+25, y+70, 200, 22);
    
    [self initReasonView:y+100];
    
    self.refundInfo.refundReason = [self.singleBtn singleValue];
}

-(NSArray *)keyArray{
    
    if (!_keyArray) {
        _keyArray = @[@"1001",@"1002",@"1003",@"1004"];
    }
    
    return _keyArray;
}

-(NSDictionary *)infoDic{
    
    if (!_infoDic) {
        
        _infoDic = @{@"1001" : L(@"PVDoNotWantToBuyNow"),
        @"1002":L(@"PVPriseIsSoHigh"),
        @"1003":L(@"PVErrorOrOrderRecur"),
        @"1004":L(@"PVOtherReason")};
    }
    return _infoDic;
}
-(SSBtnService *)singleBtn{
    
    
    if (!_singleBtn) {
        
        _singleBtn = [[SSBtnService alloc] init];
    }
    
    return _singleBtn;
}
-(UILabel *)refundAccountLab{
    
    if (!_refundAccountLab) {
        
        _refundAccountLab = [[UILabel alloc] init];
        _refundAccountLab.text = L(@"LBRefundNumber");
        _refundAccountLab.textAlignment = UITextAlignmentLeft;
        _refundAccountLab.backgroundColor = [UIColor clearColor];
        _refundAccountLab.font = [UIFont boldSystemFontOfSize:16];
    }
    return _refundAccountLab;
}

-(keyboardNumberPadReturnTextField *)refundAccountTF{
    
    if (!_refundAccountTF) {
        
        _refundAccountTF = [[keyboardNumberPadReturnTextField alloc] init];
        _refundAccountTF.backgroundColor = [UIColor whiteColor];
        _refundAccountTF.doneButtonDelegate = self;
        _refundAccountTF.delegate = self;
        _refundAccountTF.font = [UIFont boldSystemFontOfSize:17];
        _refundAccountTF.textAlignment = UITextAlignmentCenter;
       // _refundAccountTF.borderStyle = UITextBorderStyleRoundedRect;
        _refundAccountTF.layer.borderColor = [UIColor colorWithRed:190.0/255
                                                             green:190.0/255
                                                              blue:190.0/255
                                                             alpha:1.0].CGColor;
        _refundAccountTF.layer.borderWidth = 1;
    }
    
    return _refundAccountTF;
}

-(UILabel *)accountDesLab{
    
    if (!_accountDesLab) {
        
        _accountDesLab = [[UILabel alloc] init];
        _accountDesLab.textColor = [UIColor grayColor];
        _accountDesLab.textAlignment = UITextAlignmentLeft;
        _accountDesLab.backgroundColor = [UIColor clearColor];
        _accountDesLab.font = [UIFont systemFontOfSize:14];
    }
    return _accountDesLab;
}

-(UILabel *)refundPriceLab{
    
    if (!_refundPriceLab) {
        
        _refundPriceLab = [[UILabel alloc] init];
        _refundPriceLab.text = L(@"LBRefundCount3");
        _refundPriceLab.backgroundColor = [UIColor clearColor];
        _refundPriceLab.font = [UIFont boldSystemFontOfSize:16];
    }
    return _refundPriceLab;
}

-(UILabel *)priceDesLab{
    
    if (!_priceDesLab) {
        
        _priceDesLab = [[UILabel alloc] init];
        _priceDesLab.text = L(@"GBFundBackToOriginalAccount");
        _priceDesLab.backgroundColor = [UIColor clearColor];
        _priceDesLab.textColor = [UIColor grayColor];
        _priceDesLab.font = [UIFont systemFontOfSize:12];
    }
    return _priceDesLab;
}

-(UILabel *)refundReasonLab{
    
    if (!_refundReasonLab) {
        
        _refundReasonLab = [[UILabel alloc] init];
        _refundReasonLab.text = L(@"GBPleaseChooseReasonOfRefund");
        _refundReasonLab.backgroundColor = [UIColor clearColor];
        _refundReasonLab.font = [UIFont boldSystemFontOfSize:16];
    }
    return _refundReasonLab;
}

-(UIImageView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GB_voucherInfo_bg.png"]];
    }
    return _lineView;
}

-(void)dealloc{
    
    TT_RELEASE_SAFELY(_refundAccountLab);
    TT_RELEASE_SAFELY(_refundAccountTF);
    TT_RELEASE_SAFELY(_accountDesLab);
    TT_RELEASE_SAFELY(_refundPriceLab);
    TT_RELEASE_SAFELY(_priceDesLab);
    TT_RELEASE_SAFELY(_refundReasonLab);
    TT_RELEASE_SAFELY(_lineView);
    TT_RELEASE_SAFELY(_singleBtn);
//    TT_RELEASE_SAFELY(_infoDic);
}


- (void)doneTapped:(id)sender{
    
    int maxRefund = _refundInfo.maxCount>5?5:_refundInfo.maxCount;
    if ([_refundAccountTF.text isEqualToString:@"5"]
        ||[_refundAccountTF.text isEqualToString:@"1"]
        ||[_refundAccountTF.text isEqualToString:@"2"]
        ||[_refundAccountTF.text isEqualToString:@"3"]
        ||[_refundAccountTF.text isEqualToString:@"4"]){
        
        
        int number = [_refundAccountTF.text intValue];
        
        if (number > maxRefund) {
            
            _refundAccountTF.text = @"1";

        }
        
        
    }
    else{
        
        _refundAccountTF.text = @"1";

    }

    float totalPrice = [_refundAccountTF.text intValue] * _refundInfo.price;
    
    self.refundPriceLab.text = [NSString stringWithFormat:@"%@%0.2f",L(@"LBRefundCount2"),totalPrice];
    
    self.refundInfo.refundCount = _refundAccountTF.text;
    [_refundAccountTF resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

        
    NSString *changedStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    int maxRefund = _refundInfo.maxCount>5?5:_refundInfo.maxCount;
    if ([changedStr isEqualToString:@"5"]
        ||[changedStr isEqualToString:@"1"]
        ||[changedStr isEqualToString:@"2"]
        ||[changedStr isEqualToString:@"3"]
        ||[changedStr isEqualToString:@"4"]){
        
        
        int number = [changedStr intValue];
        
        if (number > maxRefund) {
            
            //_refundAccountTF.text = @"1";
            [self insertErrorMsg:L(@"Number wrong,please enter again")];
            return NO;
        }
        
        
    }
    else if(0 != [changedStr length]){
                
        [self insertErrorMsg:L(@"Number wrong,please enter again")];
        return NO;
    }
    

    float totalPrice = [changedStr intValue] * _refundInfo.price;
    
    self.refundPriceLab.text = [NSString stringWithFormat:@"%@%0.2f",L(@"LBRefundCount2"),totalPrice];
    
    self.refundInfo.refundCount = changedStr;
    
    return YES;
}

-(void)insertErrorMsg:(NSString *)msg{
    
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(insertErrorMsg:)]) {
        
        [_myDelegate insertErrorMsg:msg];
    }
}

@end
