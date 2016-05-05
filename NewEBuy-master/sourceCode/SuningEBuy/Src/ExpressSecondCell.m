//
//  ExpressSecondCell.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ExpressSecondCell.h"

@implementation ExpressSecondCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor cellBackViewColor];
		self.autoresizesSubviews = YES;
      
        
    }
    return self;
}

+ (CGFloat)height:(ReturnGoodsQueryDTO *)prepareDto;
{
    NSString *orderNumLblT = [NSString stringWithFormat:@"%@： %@\n\n%@： %@\n\n%@： %@",L(@"MyEBuy_ReturnAddress"),prepareDto.address?prepareDto.address:@"",L(@"MyEBuy_ContactWay"),prepareDto.telephone?prepareDto.telephone:@"",L(@"MyEBuy_Consignee"),prepareDto.receiver?prepareDto.receiver:@""];
    CGSize size = [orderNumLblT sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(280,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
    return size.height + 73;
    
}

- (UILabel *)returnGoodsAddress
{
    
    if (!_returnGoodsAddress)
    {
        _returnGoodsAddress = [[UILabel alloc]init];
        
        _returnGoodsAddress.backgroundColor = [UIColor clearColor];
        
        _returnGoodsAddress.font = [UIFont systemFontOfSize:13];
        
        _returnGoodsAddress.textColor = RGBCOLOR(46, 46, 46);
        _returnGoodsAddress.numberOfLines = 0;
        
        [self.contentView addSubview:_returnGoodsAddress];
    }
    
    return _returnGoodsAddress;
}

- (UILabel *)remark
{
    
    if (!_remark)
    {
        _remark = [[UILabel alloc]init];
        
        _remark.backgroundColor = [UIColor clearColor];
        
        _remark.font = [UIFont systemFontOfSize:13];
        
        _remark.textColor = RGBCOLOR(137, 137, 137);
        _remark.numberOfLines = 0;
        
        [self.contentView addSubview:_remark];
    }
    
    return _remark;
}


- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_lineView setImage:[UIImage streImageNamed:@"new_order_line.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

- (void)setItem:(ReturnGoodsQueryDTO *)prepareDto
{
    NSString *orderNumLblT = [NSString stringWithFormat:@"%@： %@\n\n%@： %@\n\n%@： %@",L(@"MyEBuy_ReturnAddress"),prepareDto.address?prepareDto.address:@"",L(@"MyEBuy_ContactWay"),prepareDto.telephone?prepareDto.telephone:@"",L(@"MyEBuy_Consignee"),prepareDto.receiver?prepareDto.receiver:@""];
    CGSize size = [orderNumLblT sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(280,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
    self.returnGoodsAddress.frame = CGRectMake(10, 5, size.width, size.height);
    
    self.lineView.frame = CGRectMake(10, self.returnGoodsAddress.size.height+10, 280, 1);
    self.returnGoodsAddress.text = orderNumLblT;
    self.remark.text = prepareDto.reMark;
    self.remark.frame = CGRectMake(10, self.returnGoodsAddress.size.height+10+10, 280, 40);

    
    
}


@end
