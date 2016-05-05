//
//  GBOrderShopInfo.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBOrderShopInfoCell.h"

@implementation GBOrderShopInfoCell
@synthesize item= _item;
@synthesize shopNameLbl = _shopNameLbl;
@synthesize areaLbl = _areaLbl;
@synthesize addressLbl = _addressLbl;
@synthesize telLbl = _telLbl;
@synthesize seperatorView = _seperatorView;
@synthesize callBtn = _callBtn;
-(void)dealloc{
    
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_shopNameLbl);
    TT_RELEASE_SAFELY(_areaLbl);
    TT_RELEASE_SAFELY(_addressLbl);
    TT_RELEASE_SAFELY(_telLbl);
    TT_RELEASE_SAFELY(_callBtn);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (UILabel *)shopNameLbl{
    if(!_shopNameLbl){
        _shopNameLbl = [[UILabel alloc]init];
        _shopNameLbl.font = kGBOrderShopInfoCell_name_font;
        _shopNameLbl.backgroundColor = [UIColor clearColor];
        _shopNameLbl.numberOfLines = 0;
        [self.contentView addSubview:_shopNameLbl];
    }
    return _shopNameLbl;
}

- (UILabel *)areaLbl{
    if(!_areaLbl){
        _areaLbl = [[UILabel alloc]init];
        _areaLbl.font = kGBOrderShopInfoCell_label_font;
        _areaLbl.backgroundColor = [UIColor clearColor];
        _areaLbl.numberOfLines =0;
        [self.contentView addSubview:_areaLbl];
    }
    return _areaLbl;
}

- (UILabel *)addressLbl{
    if(!_addressLbl){
        _addressLbl = [[UILabel alloc]init];
        _addressLbl.font = kGBOrderShopInfoCell_label_font;
        _addressLbl.backgroundColor = [UIColor clearColor];
        _addressLbl.numberOfLines = 0 ;
        [self.contentView addSubview:_addressLbl];
    }
    return _addressLbl;
}

- (UILabel *)telLbl{
    if(!_telLbl){
        _telLbl = [[UILabel alloc]init];
        _telLbl.font = kGBOrderShopInfoCell_label_font;
        _telLbl.backgroundColor = [UIColor clearColor];
        _telLbl.numberOfLines = 0 ;
        [self.contentView addSubview:_telLbl];
    }
    return _telLbl;
}

- (UIImageView *)seperatorView
{
    if (!_seperatorView)
    {
        _seperatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
        
        _seperatorView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_seperatorView];
    }
    return _seperatorView;
}


- (UIButton *)callBtn
{
    if (!_callBtn)
    {
        _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _callBtn.backgroundColor = [UIColor clearColor];
        
        [_callBtn setBackgroundImage:[UIImage imageNamed:@"telephone-orange@2x.png"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_callBtn];
    }
    return _callBtn;
}

- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

- (void)setItem:(GBShopDTO *)item{
    if (_item != item) {
        TT_RELEASE_SAFELY(_item);
        _item = item;
    self.shopNameLbl.text = _item.name;
//    self.areaLbl.text = [NSString stringWithFormat:@"商业区：%@",_item.area];
    self.addressLbl.text =  [NSString stringWithFormat:@"%@%@",L(@"GBAddress"),_item.address];
    self.telLbl.text =  [NSString stringWithFormat:@"%@%@",L(@"GBAppointment"),_item.tel];
    [super setNeedsLayout];
    }
}
+(CGFloat)height:(GBShopDTO *)item{
    NSString *str_name = item.name == nil ? @"":item.name;
    CGSize size_name = returnTextFrame(returnRightString(str_name), kGBOrderShopInfoCell_name_font, kGBOrderShopInfoCell_name_width, UILineBreakModeCharacterWrap);
    
//    NSString *str_area = [NSString stringWithFormat:@"商业区：%@",item.area];
//    CGSize size_area = returnTextFrame(returnRightString(str_area), kGBOrderShopInfoCell_label_font, kGBOrderShopInfoCell_label_width, UILineBreakModeCharacterWrap);
    
    NSString *str_address = [NSString stringWithFormat:@"%@%@",L(@"GBAddress"),item.address];
    CGSize size_address = returnTextFrame(returnRightString(str_address), kGBOrderShopInfoCell_label_font, kGBOrderShopInfoCell_label_width, UILineBreakModeCharacterWrap);
    
    NSString *str_tel = [NSString stringWithFormat:@"%@%@",L(@"GBAppointment"),item.tel];
    CGSize size_tel = returnTextFrame(returnRightString(str_tel), kGBOrderShopInfoCell_label_font, kGBOrderShopInfoCell_label_width, UILineBreakModeCharacterWrap);
    if (size_tel.height >30) {
        return  size_name.height+size_address.height +size_tel.height +70;

//        return  size_name.height + size_area.height +size_address.height +size_tel.height +70;
    }
    else{
        return  size_name.height+size_address.height +size_tel.height +100;

//    return  size_name.height + size_area.height +size_address.height +size_tel.height +100;
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size_name = returnTextFrame(returnRightString(self.shopNameLbl.text), kGBOrderShopInfoCell_name_font, kGBOrderShopInfoCell_name_width, UILineBreakModeCharacterWrap);
    
//    CGSize size_area = returnTextFrame(returnRightString(self.areaLbl.text), kGBOrderShopInfoCell_label_font, kGBOrderShopInfoCell_label_width, UILineBreakModeCharacterWrap);
    
    CGSize size_address = returnTextFrame(returnRightString(self.addressLbl.text), kGBOrderShopInfoCell_label_font, kGBOrderShopInfoCell_label_width, UILineBreakModeCharacterWrap);
    
    CGSize size_tel = returnTextFrame(returnRightString(self.telLbl.text), kGBOrderShopInfoCell_label_font, kGBOrderShopInfoCell_telephone_width, UILineBreakModeCharacterWrap);
    self.shopNameLbl.frame = CGRectMake(15, 20, size_name.width, size_name.height);
//    self.areaLbl.frame = CGRectMake(20, self.shopNameLbl.bottom+20, size_area.width, size_area.height);
    self.addressLbl.frame = CGRectMake(15, self.shopNameLbl.bottom+10, size_address.width, size_address.height);
    self.telLbl.frame = CGRectMake(15, self.addressLbl.bottom+10, size_tel.width, size_tel.height);
    self.callBtn.frame = CGRectMake(self.telLbl.right + 10, self.addressLbl.bottom+10 , 50, 30);
//    self.seperatorView.frame = CGRectMake(0, self.bounds.size.height - 2, 320, 2);
    
    self.lineView.frame = CGRectMake(15, self.shopNameLbl.bottom+4.5, 305, 0.5);


}
@end
