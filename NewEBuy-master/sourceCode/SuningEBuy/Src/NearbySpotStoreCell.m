//
//  NearbySuningShopListCell.m
//  SuningEBuy
//
//  Created by Kristopher on 14-7-31.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NearbySpotStoreCell.h"

@implementation NearbySpotStoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [self.spotStoreDTO.storeName sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(200, 100)];
    
    self.backView.frame = CGRectMake(10, 0, 300, [NearbySpotStoreCell heightOfCell:self.spotStoreDTO.storeAddress]-10);
    
    self.shopNameLbl.frame = CGRectMake(22, 10, 200, size.height);
    
    self.addressLbl.frame = CGRectMake(22, self.shopNameLbl.bottom, 200, self.height - size.height - 10);
    
    self.distanceLbl.frame = CGRectMake(260, 10, 50, 20);
    
    self.positionImage.frame = CGRectMake(242, 12, 13, 16);
    
    self.pickupBtn.frame = CGRectMake(235, self.shopNameLbl.bottom + 20, 60, 25);
    
}

-(void)setItem:(NearbySpotStoreDTO *)dto
{
    self.spotStoreDTO = dto;
    
    self.shopNameLbl.text = !IsStrEmpty(dto.storeName)?dto.storeName:@"--";
    
    self.addressLbl.text = !IsStrEmpty(dto.storeName)?dto.storeAddress:@"--";
    
    if (!dto.distance||[dto.distance isEqualToString:@""]||([dto.distance floatValue]<=0.0)||([dto.distance doubleValue]>1000.0))
    {
        self.distanceLbl.text = @"";
        
        self.positionImage.image = [UIImage imageNamed:@""];
        
    }else{
        
        self.distanceLbl.text = dto.distance?[NSString stringWithFormat:@"%0.2fkm",[dto.distance doubleValue]]:@"--";
        
        self.positionImage.image = [UIImage imageNamed:@"suning_icon_dingwei.png"];
    }
    
}

- (UIImageView *)positionImage
{
    if (!_positionImage)
    {
        _positionImage = [[UIImageView alloc] init];
        
        _positionImage.backgroundColor = [UIColor clearColor];
        
        //_positionImage.image = [UIImage imageNamed:@"suning_icon_dingwei.png"];
        
        [self.contentView addSubview:_positionImage];
    }
    return _positionImage;
}

- (UIImageView *)backView
{
    if (!_backView)
    {
        _backView = [[UIImageView alloc] init];
        
        _backView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_backView];
    }
    
    return  _backView;
}

- (UILabel *)shopNameLbl
{
    if(_shopNameLbl == nil)
    {
        _shopNameLbl = [[UILabel alloc]init];
        
        _shopNameLbl.font = [UIFont boldSystemFontOfSize:14];
        
        _shopNameLbl.backgroundColor = [UIColor clearColor];
        
        _shopNameLbl.numberOfLines = 0;
        
        _shopNameLbl.textColor = [UIColor whiteColor];
        
        _shopNameLbl.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_shopNameLbl];
    }
    
    return _shopNameLbl;
}

- (UILabel *)addressLbl
{
    if(_addressLbl == nil)
    {
        _addressLbl = [[UILabel alloc]init];
        
        _addressLbl.font = [UIFont systemFontOfSize:13];
        
        _addressLbl.backgroundColor = [UIColor clearColor];
        
        _addressLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        
        _addressLbl.textAlignment = UITextAlignmentLeft;
        
        _addressLbl.numberOfLines = 2;
        
        _addressLbl.lineBreakMode = UILineBreakModeTailTruncation;
        
        [self.contentView addSubview:_addressLbl];
    }
    
    return _addressLbl;
}

- (UILabel *)distanceLbl
{
    if(_distanceLbl == nil)
    {
        _distanceLbl = [[UILabel alloc]init];
        
        _distanceLbl.font = [UIFont systemFontOfSize:12];
        
        _distanceLbl.backgroundColor = [UIColor clearColor];
        
        _distanceLbl.textColor = [UIColor whiteColor];
        
        _distanceLbl.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_distanceLbl];
    }
    
    return _distanceLbl;
}

- (UIButton *)pickupBtn
{
    
    if (_pickupBtn == nil)
    {
        _pickupBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [_pickupBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiu.png"] forState:UIControlStateNormal];
        [_pickupBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"] forState:UIControlStateHighlighted];
        
        [_pickupBtn setTitle:L(@"Product_BuySelfNow") forState:UIControlStateNormal];
        [_pickupBtn setTitle:L(@"Product_BuySelfNow") forState:UIControlStateHighlighted];
        
        _pickupBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [_pickupBtn setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateNormal];
        [_pickupBtn setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
        
        [_pickupBtn addTarget:self action:@selector(pickupClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_pickupBtn];
    }
    
    return _pickupBtn;
}

- (void)pickupClicked:(UIButton *)sender
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(gotoShopCartWithPickupStoreInfo:)]) {
        [_delegate gotoShopCartWithPickupStoreInfo:self.spotStoreDTO];
    }
    
}

+ (CGFloat)heightOfCell:(NSString *)storeAddress
{
    CGSize size = [storeAddress sizeWithFont:[UIFont boldSystemFontOfSize:12.0] constrainedToSize:CGSizeMake(190, 100)];
    
    CGFloat height1 =size.height + 50;
    
    CGFloat height =height1>90?height1:90;
    
    return height;
}


@end
