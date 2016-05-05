//
//  MergerSecondCell.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-10-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "MergerSecondCell.h"

@implementation MergerSecondCell
@synthesize phoneNumberTextField = _phoneNumberTextField;
@synthesize firstCellLable = _firstCellLable;
@synthesize selectButton = _selectButton;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

//- (void)setItem:(CardNoListDTO *)item isSelect:(BOOL)isSelect
//{
//    _item = item;
//    self.selectButton.selected = isSelect;
//    self.firstCellLable.text = _item.ecoType;    
//}


- (void)setItem:(CardNoListDTO *)item
{
    _item = item;
//    self.selectButton.selected = _item.isSelected;
    self.firstCellLable.text = [NSString stringWithFormat:@"%@%@：%@",_item.ecoType,L(@"LBCellphoneNumber"),_item.cardNo];
//    self.phoneNumberTextField.text = _item.cardNo;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.selectButton.frame = CGRectMake(5, 10, 20, 20);
    self.firstCellLable.frame = CGRectMake(15, 5, 260, 30);
//    self.phoneNumberTextField.frame = CGRectMake(self.firstCellLable.right+10, 5, self.contentView.width-80, 34.);
}

-(UIButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc]init];
        _selectButton.frame = CGRectMake(5, 10, 20, 20);
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"payment_type_unselect.png"] forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"payment_type_selected.png"] forState:UIControlStateSelected];
        _selectButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_selectButton];
        
    }
    return _selectButton;
}



-(UILabel *)firstCellLable
{
    if (!_firstCellLable) {
        _firstCellLable = [[UILabel alloc]init];
        _firstCellLable.backgroundColor = [UIColor clearColor];
        _firstCellLable.textColor = [UIColor colorWithRGBHex:0x444444];
        _firstCellLable.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_firstCellLable];
    }
    return _firstCellLable;
}

- (UITextField *)phoneNumberTextField {
	if (!_phoneNumberTextField) {
		_phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.firstCellLable.right+10, 5, self.contentView.width-80, 34.)];
		_phoneNumberTextField.delegate = self;
        _phoneNumberTextField.userInteractionEnabled = NO;
        _phoneNumberTextField.font = [UIFont boldSystemFontOfSize:14];
		_phoneNumberTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumberTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _phoneNumberTextField.enablesReturnKeyAutomatically = YES;
        _phoneNumberTextField.textColor = [UIColor colorWithRGBHex:0x999081];
        [self.contentView addSubview:_phoneNumberTextField];
	}
	return _phoneNumberTextField;
}




@end
