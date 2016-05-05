//
//  ExpressListFirstCell.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ExpressListFirstCell.h"
#define   DefaultFont            [UIFont boldSystemFontOfSize:15.0]

@implementation ExpressListFirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
		self.autoresizesSubviews = YES;

        
    }
    return self;
}


- (UILabel *)expressName
{
    
    if (!_expressName)
    {
        _expressName = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 25)];
        
        _expressName.backgroundColor = [UIColor whiteColor];
        
        _expressName.font = [UIFont systemFontOfSize:16];
        _expressName.text = [NSString stringWithFormat:@"%@：",L(@"MyEBuy_ExpressName")];
        
        _expressName.textColor = [UIColor colorWithRGBHex:0x313131];
        
        
        [self.contentView addSubview:_expressName];
    }
    
    return _expressName;
}

- (UIButton *)tiaoXingMaBtn
{
    if (!_tiaoXingMaBtn)
    {
        _tiaoXingMaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _tiaoXingMaBtn.frame = CGRectMake(275 , 10, 35, 35);
        
        [_tiaoXingMaBtn setImage:[UIImage imageNamed:@"newSearch_SnReaderBtnIcon"] forState:UIControlStateNormal];
            
        _tiaoXingMaBtn.hidden = NO;
        [self.contentView addSubview:_tiaoXingMaBtn];

    }
    return _tiaoXingMaBtn;
}

- (UILabel *)expressNumber
{
    
    if (!_expressNumber)
    {
        _expressNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 25)];
        
        _expressNumber.backgroundColor = [UIColor clearColor];
        
        _expressNumber.font = [UIFont systemFontOfSize:16];
        _expressNumber.text = [NSString stringWithFormat:@"%@：",L(@"MyEBuy_ExpressNumber")];
        
        _expressNumber.textColor = [UIColor colorWithRGBHex:0x313131];
        
        [self.contentView addSubview:_expressNumber];
    }
    
    return _expressNumber;
}

- (UILabel *)detailDescribe
{
    
    if (!_detailDescribe)
    {
        _detailDescribe = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 25)];
        
        _detailDescribe.backgroundColor = [UIColor clearColor];
        
        _detailDescribe.font = [UIFont systemFontOfSize:16];
        _detailDescribe.text = [NSString stringWithFormat:@"%@：",L(@"MyEBuy_DetailDescription")];
        
        _detailDescribe.textColor = [UIColor colorWithRGBHex:0x313131];
        
        [self.contentView addSubview:_detailDescribe];
    }
    
    return _detailDescribe;
}



- (CommonTextField *)expressNumberTextView
{
    if (!_expressNumberTextView)
    {
        _expressNumberTextView = [[CommonTextField alloc] init];
        
        _expressNumberTextView.frame = CGRectMake(10, 8, 280, 60);
        
        _expressNumberTextView.placeholder = [NSString stringWithFormat:@"%@",L(@"MyEBuy_PleaseInputExpressNumber")];
        
        _expressNumberTextView.textColor = [UIColor dark_Gray_Color];
        _expressNumberTextView.font = [UIFont systemFontOfSize:16.0];
        _expressNumberTextView.backgroundColor = [UIColor clearColor];
        _expressNumberTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _expressNumberTextView.keyboardType = UIKeyboardTypeASCIICapable;
        _expressNumberTextView.returnKeyType = UIReturnKeyDefault;
        _expressNumberTextView.delegate = self;
        _expressNumberTextView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _expressNumberTextView.leftPadding = 7;
        //_expressNumberTextView.editable = YES;
//        _expressNumberTextView.layer.cornerRadius = 5.0f;
//        _expressNumberTextView.layer.borderColor = k233TextBorderColor.CGColor;
//        _expressNumberTextView.layer.borderWidth = 0.5;
        
        [self.contentView addSubview:_expressNumberTextView];
    }
    return _expressNumberTextView;
}

- (PlaceholderTextView *)detailDescribeTextView
{
    if (!_detailDescribeTextView)
    {
        _detailDescribeTextView = [[PlaceholderTextView alloc] init];
        
        _detailDescribeTextView.frame = CGRectMake(10, 8, 280, 60);
        
        _detailDescribeTextView.placeholder = [NSString stringWithFormat:@"%@",L(@"MyEBuy_PleaseInputDetailDescription_NotRequired")];
        
        _detailDescribeTextView.textColor = [UIColor colorWithRGBHex:0xcbcaca];
        _detailDescribeTextView.font = [UIFont systemFontOfSize:13.0];
        _detailDescribeTextView.backgroundColor = [UIColor whiteColor];
        _detailDescribeTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _detailDescribeTextView.editable = YES;
        _detailDescribeTextView.layer.cornerRadius = 8.0f;
        _detailDescribeTextView.layer.borderColor = k233TextBorderColor.CGColor;
        _detailDescribeTextView.layer.borderWidth = 0.5;
        // _detailDescribeTextView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        
        //   _detailDescribeTextView
        
        _detailDescribeTextView.keyboardType = UIKeyboardTypeDefault;
        
        _detailDescribeTextView.delegate = self;
        [self.contentView addSubview:_detailDescribeTextView];
    }
    return _detailDescribeTextView;
}


@end
