//
//  GBGoodsShopListCell.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBGoodsShopListCell.h"

#define defaultFont   [UIFont systemFontOfSize:15.0]

@interface GBGoodsShopListCell(){
    
}

@property (nonatomic, strong) UILabel                   *shopName;
@property (nonatomic, strong) UILabel                   *address;
@property (nonatomic, strong) UILabel                   *addressLbl;
@property (nonatomic, strong) UILabel                   *telephone;
@property (nonatomic, strong) UILabel                   *trafficTips;
@property (nonatomic, strong) UIImageView               *seperatorView;
@property (nonatomic, strong) UIImageView               *seperatorView1;
@property (nonatomic, strong) UIImageView               *seperatorView2;

@end

@implementation GBGoodsShopListCell

@synthesize tuanType                            = _tuanType;
@synthesize gbShopsListDTO                      = _gbShopsListDTO;
@synthesize shopName                            = _shopName;
@synthesize address                             = _address;
@synthesize telephone                           = _telephone;
@synthesize trafficTips                         = _trafficTips;
@synthesize seperatorView                       = _seperatorView;
@synthesize callBtn                             = _callBtn;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_tuanType);
    TT_RELEASE_SAFELY(_callBtn);
    TT_RELEASE_SAFELY(_seperatorView);
    TT_RELEASE_SAFELY(_gbShopsListDTO);
    TT_RELEASE_SAFELY(_shopName);
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_telephone);
    TT_RELEASE_SAFELY(_trafficTips);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (CGFloat)height:(GBShopsListDTO *)dto withTuanType:(NSString *)tuanType{
  
    CGSize shopName = [dto.shopName sizeWithFont:defaultFont constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    NSString *addressString = [NSString stringWithFormat:@"%@",dto.address];
    CGSize address = [addressString sizeWithFont:defaultFont constrainedToSize:CGSizeMake(245, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    NSString *teleString = [NSString stringWithFormat:@"%@%@",L(@"GBTelephone"),dto.telephone];
    CGSize telephone = [teleString sizeWithFont:defaultFont constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
//    NSString *trafString = [NSString stringWithFormat:@"交通提醒 : %@",dto.trafficTips];
//    CGSize trafficTips = [trafString sizeWithFont:defaultFont constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeCharacterWrap];

//    if (![tuanType isEqualToString:@"1"]) { //1表示酒店
//        return shopName.height + address.height + telephone.height + trafficTips.height + 60;
//    }
//    else
//    {
//        return shopName.height + address.height + telephone.height + 60;
//    }
     return shopName.height + address.height + telephone.height + 63;
}

- (void)setGbShopsListDTO:(GBShopsListDTO *)gbShopsListDTO
{
    if (_gbShopsListDTO != gbShopsListDTO) {
        _gbShopsListDTO = gbShopsListDTO;
        self.shopName.text = _gbShopsListDTO.shopName;
        CGSize shopName = [_gbShopsListDTO.shopName sizeWithFont:defaultFont constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        self.shopName.frame = CGRectMake(20, 5, 280, shopName.height);

        NSString *addressString = [NSString stringWithFormat:@"%@",_gbShopsListDTO.address];
        CGSize address = [addressString sizeWithFont:defaultFont constrainedToSize:CGSizeMake(245, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        
        NSString *teleString = [NSString stringWithFormat:@"%@%@",L(@"GBTelephone"),_gbShopsListDTO.telephone];
        CGSize telephone = [teleString sizeWithFont:defaultFont constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        
        NSString *trafString = [NSString stringWithFormat:@"%@%@",L(@"GBTrafficRemind"),_gbShopsListDTO.trafficTips];
        CGSize trafficTips = [trafString sizeWithFont:defaultFont constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeCharacterWrap];

        self.addressLbl.text = L(@"GBAddress2");
        self.address.text = addressString;
        self.address.frame = CGRectMake(15, self.shopName.bottom, 245, address.height);
        self.telephone.text = teleString;
        self.telephone.frame = CGRectMake(15, self.address.bottom, 220, telephone.height);
        self.trafficTips.text = trafString;
        self.trafficTips.frame = CGRectMake(20, self.telephone.bottom, 280, trafficTips.height);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.shopName.frame = CGRectMake(15, 10, 280, self.shopName.height);
    self.seperatorView1.frame = CGRectMake(15, self.shopName.bottom + 10, 305, 0.5);
    self.addressLbl.frame = CGRectMake(15, self.shopName.bottom + 20, 45, 15);
    self.address.frame = CGRectMake(55, self.shopName.bottom + 20, 245, self.address.height);
    self.seperatorView2.frame = CGRectMake(15, self.address.bottom + 10, 305, 0.5);
    self.telephone.frame = CGRectMake(15, self.address.bottom + 20, 220, self.telephone.height);
    self.callBtn.frame = CGRectMake(self.telephone.right + 35, 15 + self.address.bottom , 50, 30);
    self.trafficTips.frame = CGRectMake(20, self.telephone.bottom + 10, 280, self.trafficTips.height);
    self.seperatorView.frame = CGRectMake(0, self.bounds.size.height - 0.5, 320, 0.5);
}

- (UILabel *)shopName
{
    if (!_shopName) {
        _shopName = [[UILabel alloc] init];

        _shopName.backgroundColor = [UIColor clearColor];
        
        _shopName.font = defaultFont;
        
        _shopName.numberOfLines = 0;
        
        [self.contentView addSubview:_shopName];
    }
    return _shopName;
}

- (UILabel *)address
{
    if (!_address) {
        _address = [[UILabel alloc] init];
        
        _address.backgroundColor = [UIColor clearColor];
        
        _address.font = defaultFont;
        
        _address.numberOfLines = 0;
        
        [self.contentView addSubview:_address];
    }
    return _address;
}

- (UILabel *)addressLbl
{
    if (!_addressLbl) {
        _addressLbl = [[UILabel alloc] init];
        
        _addressLbl.backgroundColor = [UIColor clearColor];
        
        _addressLbl.font = defaultFont;
        
        [self.contentView addSubview:_addressLbl];
    }
    return _addressLbl;
}


- (UILabel *)telephone
{
    if (!_telephone) {
        _telephone = [[UILabel alloc] init];
        
        _telephone.backgroundColor = [UIColor clearColor];
        
        _telephone.font = defaultFont;
        
        _telephone.numberOfLines = 0;
        
        [self.contentView addSubview:_telephone];
    }
    return _telephone;
}


- (UILabel *)trafficTips
{
    if (!_trafficTips) {
        _trafficTips = [[UILabel alloc] init];
        
        _trafficTips.backgroundColor = [UIColor clearColor];
        
        _trafficTips.numberOfLines = 0;
        
        _trafficTips.font = defaultFont;
        
//        if (![self.tuanType isEqualToString:@"1"]) { //1表示酒店
//            [self.contentView addSubview:_trafficTips];
//        }
    }
    return _trafficTips;
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

- (UIImageView *)seperatorView1
{
    if (!_seperatorView1)
    {
        _seperatorView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
        
        _seperatorView1.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_seperatorView1];
    }
    return _seperatorView1;
}

- (UIImageView *)seperatorView2
{
    if (!_seperatorView2)
    {
        _seperatorView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
        
        _seperatorView2.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_seperatorView2];
    }
    return _seperatorView2;
}

- (UIButton *)callBtn
{
    if (!_callBtn)
    {
        _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       
        _callBtn.backgroundColor = [UIColor clearColor];
                
        [_callBtn setImage:[UIImage imageNamed:@"GroupBuy_telephone-orange.png"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_callBtn];
    }
    return _callBtn;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
