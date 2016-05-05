//
//  yuDingRenItemCell.m
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "yuDingRenItemCell.h"
#define  leftPadding    15
#define kLeftMargin         98.0
#define kTopMargin          8.0
#define kTextFieldWidth     188.0
#define kTextFieldHeight    30.0
#define kTextFieldFontSize  15.0


@implementation yuDingRenItemCell

@synthesize yudingrenLbl = _yudingrenLbl;
@synthesize whiteBackView = _whiteBackView;
@synthesize yuDingNameFld = _yuDingNameFld;
@synthesize yuDingPhoneFld = _yuDingPhoneFld;
@synthesize yuDingNameLbl = _yuDingNameLbl;
@synthesize yuDingPhoneLbl = _yuDingPhoneLbl;
@synthesize yuDingDelegate = _yuDingDelegate;


//初始化
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        
    }
	return self;

}


-(void)dealloc{
    
    TT_RELEASE_SAFELY(_yudingrenLbl);
    TT_RELEASE_SAFELY(_whiteBackView);
	TT_RELEASE_SAFELY(_yuDingNameFld);
	TT_RELEASE_SAFELY(_yuDingPhoneFld);
    TT_RELEASE_SAFELY(_yuDingNameLbl);
	TT_RELEASE_SAFELY(_yuDingPhoneLbl);
   
}


-(void) setItem:(NSString *)name andPhone:(NSString *)phone{
    
    if (name == nil || [name isEqualToString:@""]) {
        self.yuDingNameFld.text = @"";

    }else{
        self.yuDingNameFld.text = name;
    }
    
    if (phone == nil || [phone isEqualToString:@""]) {
        self.yuDingPhoneFld.text = @"";
    }else{
        self.yuDingPhoneFld.text = phone;
    }

    [self setNeedsLayout];
    
}



-(void) layoutSubviews{
	
	[super layoutSubviews];
    
    self.yudingrenLbl.frame = CGRectMake(leftPadding, 10, 200, 25);
    self.whiteBackView.frame = CGRectMake(0, 40, 320, 90);
	self.yuDingNameLbl.frame = CGRectMake(leftPadding, 50, 70, 30);
    self.yuDingNameFld.frame = CGRectMake(70, 50, 215, 30);
	self.yuDingPhoneLbl.frame = CGRectMake(leftPadding, 90, 70, 30);
    self.yuDingPhoneFld.frame = CGRectMake(70, 90, 215, 30);
    
    [self.contentView sendSubviewToBack:self.whiteBackView];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.yuDingNameFld) {
        
        if ([self.yuDingDelegate conformsToProtocol:@protocol(yuDingCellDelegate)])
        {
            if ([self.yuDingDelegate respondsToSelector:@selector(sendName:)])
            {
                [self.yuDingDelegate sendName:self.yuDingNameFld.text];
            }
        }
    }
    if (textField == self.yuDingPhoneFld) {
        
        if ([self.yuDingDelegate conformsToProtocol:@protocol(yuDingCellDelegate)])
        {
            if ([self.yuDingDelegate respondsToSelector:@selector(sendPhone:)])
            {
                [self.yuDingDelegate sendPhone:self.yuDingPhoneFld.text];
            }
        }
    }
}

- (void)prepareForReuse
{
    UIImageView *separatorLine = (UIImageView *)[self.contentView viewWithTag:9528];
    
    [separatorLine removeFromSuperview];
}


#pragma mark -
#pragma mark UIView

-(UILabel *)yudingrenLbl{
    if (_yudingrenLbl == nil) {
        _yudingrenLbl = [[UILabel alloc]init];
        _yudingrenLbl.backgroundColor = [UIColor clearColor];
        _yudingrenLbl.font = [UIFont systemFontOfSize:14.0];
        _yudingrenLbl.text = L(@"BTSchedulePeopleInfo");
        [self.contentView addSubview:_yudingrenLbl];
    }
    return _yudingrenLbl;
}

-(UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackView];
    }
    return _whiteBackView;
}

-(UITextField *) yuDingNameFld{
	
	if (!_yuDingNameFld) {
    
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        _yuDingNameFld = [[UITextField alloc] initWithFrame:frame];
        _yuDingNameFld.placeholder = L(@"Please input your name");
        _yuDingNameFld.textColor = [UIColor blackColor];
        _yuDingNameFld.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _yuDingNameFld.backgroundColor = [UIColor whiteColor];
        _yuDingNameFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _yuDingNameFld.autocorrectionType = UITextAutocorrectionTypeNo;
        _yuDingNameFld.keyboardType = UIKeyboardTypeDefault;
        _yuDingNameFld.returnKeyType = UIReturnKeyDone;
        _yuDingNameFld.clearButtonMode = UITextFieldViewModeWhileEditing;
        _yuDingNameFld.delegate =self;
        
        _yuDingNameFld.layer.borderColor = RGBCOLOR(230, 230, 230).CGColor;
        _yuDingNameFld.layer.borderWidth = 1;
        [self.contentView addSubview:_yuDingNameFld];
	}	
	return _yuDingNameFld;
}

-(keyboardNumberPadReturnTextField *) yuDingPhoneFld{
	
	if (!_yuDingPhoneFld) {
		
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        _yuDingPhoneFld = [[keyboardNumberPadReturnTextField alloc] initWithFrame:frame];
        _yuDingPhoneFld.placeholder = L(@"Please input phone number");
        _yuDingPhoneFld.textColor = [UIColor blackColor];
        _yuDingPhoneFld.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _yuDingPhoneFld.backgroundColor = [UIColor whiteColor];
        _yuDingPhoneFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _yuDingPhoneFld.keyboardType = UIKeyboardTypePhonePad;
        _yuDingPhoneFld.returnKeyType = UIReturnKeyDone;
        _yuDingPhoneFld.delegate = self;
        
        _yuDingPhoneFld.layer.borderColor = RGBCOLOR(230, 230, 230).CGColor;
        _yuDingPhoneFld.layer.borderWidth = 1;

        [self.contentView addSubview:_yuDingPhoneFld];	
    }	
	return _yuDingPhoneFld;
}

-(UILabel *)yuDingNameLbl{
	
	if (!_yuDingNameLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:15];
		
		CGSize size = [@"a" sizeWithFont:font];
        
		_yuDingNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_yuDingNameLbl.backgroundColor = [UIColor clearColor];
		
		_yuDingNameLbl.font = font;
		        
        _yuDingNameLbl.text = L(@"BTName");
		
		[self.contentView addSubview:_yuDingNameLbl];
	}
    
	return _yuDingNameLbl;
}

-(UILabel *) yuDingPhoneLbl{
	
	if (!_yuDingPhoneLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:15];
		
		CGSize size = [@"a" sizeWithFont:font];
        
		_yuDingPhoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_yuDingPhoneLbl.backgroundColor = [UIColor clearColor];
		
		_yuDingPhoneLbl.font = font;
		
		_yuDingPhoneLbl.autoresizingMask = UIViewAutoresizingNone;
		
        _yuDingPhoneLbl.text = L(@"tel");
        
		[self.contentView addSubview:_yuDingPhoneLbl];
	}	
	return _yuDingPhoneLbl;
}

#pragma mark -
#pragma mark text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
