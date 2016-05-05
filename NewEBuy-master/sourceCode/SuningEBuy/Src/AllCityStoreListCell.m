//
//  NearbySuningShopListCell.m
//  SuningEBuy
//
//  Created by JackyWu on 14-7-31.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityStoreListCell.h"

@implementation AllCityStoreListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backView.frame = CGRectMake(10, 0, 300, self.height-10);
    self.shopNameLbl.frame = CGRectMake(22, 0, 190, (self.height-10)/2);
    self.addressLbl.frame = CGRectMake(22, self.shopNameLbl.bottom, 190, (self.height-10)/2);
    self.distanceLbl.frame = CGRectMake(255, ((self.height-10)/2-20)/2, 50, 20);
//    self.collectBtn.frame = CGRectMake(260, 34, 40, 40);
    self.positionImage.frame = CGRectMake(237, ((self.height-10)/2-16)/2, 13, 16);
    self.collectHeart.frame = CGRectMake(283, (self.height-10)/2+((self.height-10)/2-17)/2, 17, 17);
}

- (void)setItem:(SuningStoreDTO *)dto
{
    self.allCitySuningDto = dto;
    self.shopNameLbl.text = !IsStrEmpty(dto.name)?dto.name:@"--";
    self.addressLbl.text = !IsStrEmpty(dto.address)?dto.address:@"--";
    
    if ([dto.distance floatValue] <= 0.0){
        self.distanceLbl.text = @"";
        self.positionImage.image = [UIImage imageNamed:@""];
    }else if ([dto.distance doubleValue] > 9999.99){
        self.distanceLbl.text = @"";
        self.positionImage.image = [UIImage imageNamed:@""];
    }else if ([dto.distance doubleValue] > 999.99){
        self.distanceLbl.text = dto.distance?[NSString stringWithFormat:@"%dkm",[dto.distance intValue]]:@"--";
        self.positionImage.image = [UIImage imageNamed:@"suning_icon_dingwei.png"];
    }else if ([dto.distance doubleValue] > 99.99){
        self.distanceLbl.text = dto.distance?[NSString stringWithFormat:@"%0.1fkm",[dto.distance doubleValue]]:@"--";
        self.positionImage.image = [UIImage imageNamed:@"suning_icon_dingwei.png"];
    }else{
        self.distanceLbl.text = dto.distance?[NSString stringWithFormat:@"%0.2fkm",[dto.distance doubleValue]]:@"--";
        self.positionImage.image = [UIImage imageNamed:@"suning_icon_dingwei.png"];
    }
    
//    self.collectBtn.tag = [dto.isFavo intValue];
//    
//    self.collectBtn.titleLabel.text = dto.storeId;
//    
//    [self.collectBtn setAlpha:1.0];
//    
//    [self.collectBtn setEnabled:YES];
    
    //首先判断登录状态，如果是登录的，判断门店是否收藏情况
//    if (![UserCenter defaultCenter].isLogined)
//    {
//        [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"suning_button_shoucan_default.png"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        //判断门店是否收藏情况
//        if ([dto.isFavo isEqualToString:@"0"])
//        {
//            
//            [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"suning_button_shoucan_default.png"] forState:UIControlStateNormal];
//            
//        }
//        else
//        {
//            
//            [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"suning_button_shoucan_selected.png"] forState:UIControlStateNormal];
//            
//        }
//    }
    //首先判断登录状态，如果是登录的，判断门店是否收藏情况
    if (![UserCenter defaultCenter].isLogined) {
        self.collectHeart.image = [UIImage imageNamed:@""];
    }else{
        //判断门店是否收藏情况
        if ([dto.isFavo isEqualToString:@"0"]){
            self.collectHeart.image = [UIImage imageNamed:@""];
        }
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

- (UIImageView *)collectHeart
{
    if (!_collectHeart)
    {
        _collectHeart = [[UIImageView alloc] init];
        
        _collectHeart.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_collectHeart];
    }
    
    return  _collectHeart;
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
        
        _distanceLbl.textAlignment = UITextAlignmentRight;
        
        [self.contentView addSubview:_distanceLbl];
    }
    
    return _distanceLbl;
}

//- (UIButton *)collectBtn
//{
//    
//    if (_collectBtn == nil)
//    {
//        _collectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        
//        [_collectBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        
//        [_collectBtn.layer setMasksToBounds:YES];
//        
//        [_collectBtn.layer setCornerRadius:20.0];
//        
//        [_collectBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
//        
//        [_collectBtn addTarget:self action:@selector(changeCollect:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.contentView addSubview:_collectBtn];
//    }
//    
//    return _collectBtn;
//}

//- (void)changeCollect:(UIButton *)sender
//{
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(changeCollectOrNot:)]) {
//        [_delegate changeCollectOrNot:sender];
//    }
//    
//}

+ (CGFloat)heightOfCell:(SuningStoreDTO *)storeDto
{
    if (storeDto) {
        CGSize size1 = [storeDto.address sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(190, 100)];
        CGSize size2 = [storeDto.name sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(190, 100)];
        CGFloat height1 =size1.height + size2.height + 10;
        CGFloat height =height1>90?height1:90;
        return height;
    }
    return 0.0;
}


@end
