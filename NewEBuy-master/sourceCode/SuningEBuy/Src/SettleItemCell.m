//
//  SettleItemCell.m
//  SuningEBuy
//
//  Created by wangrui on 12/10/11.
//  Copyright (c) 2011 suning. All rights reserved.
//


#import "SettleItemCell.h"

@implementation SettleItemCell
@synthesize leftTextLbl = _leftTextLbl;
@synthesize rightTextLbl = _rightTextLbl;
@synthesize rightTextFld = _rightTextFld;
@synthesize rightNormalBtn = _rightNormalBtn;
@synthesize lineImage = _lineImage;
@synthesize rightImage=_rightImage;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_leftTextLbl);
    
    TT_RELEASE_SAFELY(_rightTextLbl);
    
    TT_RELEASE_SAFELY(_rightTextFld);
    
    TT_RELEASE_SAFELY(_rightNormalBtn);
    
    TT_RELEASE_SAFELY(_lineImage);
    
    TT_RELEASE_SAFELY(_rightImage);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) 
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        self.backgroundView = view;
        
        self.textLabel.font = TableViewCellFont;
        
		self.autoresizesSubviews = YES;
    }
    
    return self;
}

- (UILabel *)leftTextLbl
{
    if (!_leftTextLbl) 
    {
        _leftTextLbl = [[UILabel alloc] init];
        
        _leftTextLbl.frame = CGRectMake(10, 0, 90, 43);
        
        _leftTextLbl.backgroundColor = [UIColor clearColor];
        
        _leftTextLbl.textAlignment = UITextAlignmentLeft;
        
        _leftTextLbl.font = TableViewCellFont;
        
    }
    
    if (_leftTextLbl.superview == nil)
    {
        [self.contentView addSubview:_leftTextLbl];
    }
    
    return _leftTextLbl;
}

- (UILabel *)rightTextLbl
{
    if (!_rightTextLbl) 
    {
        _rightTextLbl = [[UILabel alloc] init];
        
        _rightTextLbl.frame = CGRectMake(115, 0, 180, 43);
        
        _rightTextLbl.backgroundColor = [UIColor clearColor];
        
        _rightTextLbl.textAlignment = UITextAlignmentLeft;
        
        _rightTextLbl.font = TableViewCellFont;
        
    }
    
    if (_rightTextLbl.superview == nil)
    {
        [self.contentView addSubview:_rightTextLbl];
    }
    
    return _rightTextLbl;
}

- (UITextField *)rightTextFld
{
    if (!_rightTextFld)
    {
        _rightTextFld = [[UITextField alloc] init];
        _rightTextFld.frame = CGRectMake(115, 0, 180, 43);
        
        _rightTextFld.borderStyle = UITextBorderStyleNone;
        _rightTextFld.backgroundColor = [UIColor whiteColor];
        _rightTextFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _rightTextFld.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _rightTextFld.keyboardType = UIKeyboardTypeDefault;
        _rightTextFld.returnKeyType = UIReturnKeyDone;
        _rightTextFld.textAlignment = UITextAlignmentLeft;
        
        _rightTextFld.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _rightTextFld.font = TableViewCellFont;

        
    }
    
    if (_rightTextFld.superview == nil)
    {
        [self.contentView addSubview:_rightTextFld];
    }
    
    return _rightTextFld;
}

-(UIImageView *)rightImage{
    
    if(!_rightImage){
        
        _rightImage=[[UIImageView alloc]init];
        
        _rightImage.frame=CGRectMake(265, 9, 25, 25);
        
        _rightImage.backgroundColor=[UIColor clearColor];
        
        [self.contentView addSubview:_rightImage];
        
    }
    return _rightImage;
}

-(UIImageView *)lineImage{
    
    if (!_lineImage) {
        _lineImage = [[UIImageView alloc]init];
        UIImage *image = [UIImage newImageFromResource:@"line.png"];
        _lineImage.image = image;
        [self.contentView addSubview:_lineImage];
    }
    return _lineImage;
}

- (ToolBarButton *)rightNormalBtn
{
    if (!_rightNormalBtn) 
    {
        _rightNormalBtn = [[ToolBarButton alloc] init];
        
        _rightNormalBtn.frame = CGRectMake(115, 5, 180, 33);
        
        _rightNormalBtn.backgroundColor = RGBCOLOR(239, 239, 239);
        
        [_rightNormalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _rightNormalBtn.layer.borderWidth = 0.5f;
        _rightNormalBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _rightNormalBtn.layer.cornerRadius = 9;
        _rightNormalBtn.layer.masksToBounds = YES;
        
        _rightNormalBtn.titleLabel.textAlignment = UITextAlignmentLeft;
        
        _rightNormalBtn.titleLabel.font = TableViewCellFont;
        
    }
    
    if (_rightNormalBtn.superview == nil)
    {
        [self.contentView addSubview:_rightNormalBtn];
    }
    
    return _rightNormalBtn;
}


@end
