//
//  ReturnGoodsNumberViewCell.m
//  SuningEBuy
//
//  Created by zl on 14-11-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReturnGoodsNumberViewCell.h"

@implementation ReturnGoodsNumberViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.numberLab.text = [NSString stringWithFormat:@"%@ :",L(@"MyEBuy_ReturnsNumber")];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel*)numberLab{
    
    if (!_numberLab) {
        
        _numberLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 40)];
        
        _numberLab.textColor = [UIColor blackColor];
        
        _numberLab.font = [UIFont systemFontOfSize:16];
        
        _numberLab.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_numberLab];
    }
    
    return _numberLab;
}
-(UIButton *)btnDelete
{
    
    if (!_btnDelete) {
        _btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(99+35, 10, 40,20)];
        _btnDelete.backgroundColor = [UIColor clearColor];
        
        [_btnDelete setBackgroundImage:[UIImage imageNamed:@"productDetail_delete_enabled.png"] forState:UIControlStateNormal];
        [_btnDelete setBackgroundImage:[UIImage imageNamed:@"productDetail_delete_disabled.png"] forState:UIControlStateDisabled];
        [_btnDelete setBackgroundImage:[UIImage imageNamed:@"productDetail_delete_clicked.png"] forState:UIControlStateHighlighted];
        [_btnDelete addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_btnDelete];
    }
    
    return _btnDelete;
}

-(UITextField*)textNumber
{
    if (!_textNumber)
    {
        _textNumber = [[UITextField alloc] initWithFrame:CGRectMake(99+35, 10, 20,20)];
        _textNumber.borderStyle = UITextBorderStyleNone;
        _textNumber.enabled = NO;
        _textNumber.font = [UIFont systemFontOfSize:12];
        _textNumber.textAlignment = NSTextAlignmentCenter;
        _textNumber.textColor = RGBCOLOR(102, 102, 102);
        _textNumber.background = [UIImage imageNamed:@"productDetail_productNum.png"];

        [self.contentView addSubview:_textNumber];
    }
    return _textNumber;
}

-(void)deleteAction
{
    if ([_delegate respondsToSelector:@selector(valueChange:)])
    {
        [_delegate valueChange:[self.textNumber.text integerValue]-1];
    }

}

-(UIButton *)btnAdd{
    
    if (!_btnAdd) {
        _btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(134+40, 0, 44, 40)];
        _btnAdd.backgroundColor = [UIColor clearColor];
        
        [_btnAdd setBackgroundImage:[UIImage imageNamed:@"productDetail_add_enabled.png"] forState:UIControlStateNormal];
        [_btnAdd setBackgroundImage:[UIImage imageNamed:@"productDetail_add_disabled.png"] forState:UIControlStateDisabled];
        [_btnAdd setBackgroundImage:[UIImage imageNamed:@"productDetail_add_clicked.png"] forState:UIControlStateHighlighted];
        [_btnAdd addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnAdd];
    }
    
    return _btnAdd;
}

-(void)addAction
{
    if ([_delegate respondsToSelector:@selector(valueChange:)])
    {
        [_delegate valueChange:[self.textNumber.text integerValue]+1];
    }
}
@end
