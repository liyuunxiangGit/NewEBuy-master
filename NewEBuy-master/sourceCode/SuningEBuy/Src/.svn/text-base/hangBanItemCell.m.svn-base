//
//  hangBanItemCell.m
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "hangBanItemCell.h"
#define  leftPadding    15

@implementation hangBanItemCell

@synthesize quFanHangBanLbl = _quFanHangBanLbl;
@synthesize hanBanRiQiLbl = _hanBanRiQiLbl;
@synthesize qiFeiLbl = _qiFeiLbl;
@synthesize jiangLuoLbl = _jiangLuoLbl;
@synthesize jiPiaoDanJiaLbl = _jiPiaoDanJiaLbl;
@synthesize jiPiaoDanJiaValLbl = _jiPiaoDanJiaValLbl;
@synthesize jiJianRanYouFeiLbl = _jiJianRanYouFeiLbl;
@synthesize jiJianRanYouFeiValLbl = _jiJianRanYouFeiValLbl;

@synthesize hangBanImage = _hangBanImage;
@synthesize FlightInfoDto = _FlightInfoDto;
@synthesize FlightRoomInfoDto = _FlightRoomInfoDto;
@synthesize refundBtn = _refundBtn;
@synthesize delegate;
@synthesize quFanCheng = _quFanCheng;

//初始化
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = nil;
    }
	return self;
}


-(void)dealloc{
    
    TT_RELEASE_SAFELY(_quFanHangBanLbl);
	TT_RELEASE_SAFELY(_hanBanRiQiLbl);
	TT_RELEASE_SAFELY(_qiFeiLbl);
	TT_RELEASE_SAFELY(_jiangLuoLbl);
	TT_RELEASE_SAFELY(_jiPiaoDanJiaLbl);
    TT_RELEASE_SAFELY(_jiPiaoDanJiaValLbl);
    TT_RELEASE_SAFELY(_jiJianRanYouFeiValLbl);
	TT_RELEASE_SAFELY(_jiJianRanYouFeiLbl);
    TT_RELEASE_SAFELY(_hangBanImage);
	TT_RELEASE_SAFELY(_FlightInfoDto);
    TT_RELEASE_SAFELY(_FlightRoomInfoDto);
    TT_RELEASE_SAFELY(_refundBtn);
    TT_RELEASE_SAFELY(_quFanCheng);

}


-(void) setHanBanInfoItem:(FlightInfoDTO *)aFlightInfoDto{
	
	if (aFlightInfoDto != _FlightInfoDto) {
		
		
		_FlightInfoDto = aFlightInfoDto;
        
        
        NSString *quFanHangBan = [NSString stringWithFormat:@"%@: %@ %@",_quFanCheng?_quFanCheng:L(@"BTOneWay"),
                                 _FlightInfoDto.companyName?_FlightInfoDto.companyName:@"",
                                 _FlightInfoDto.fNo?_FlightInfoDto.fNo:@""];
		self.quFanHangBanLbl.text = quFanHangBan;//中国国航 CA1861
		
        NSString *hanbanriqi = [NSString stringWithFormat:@"%@%@",
                                L(@"BTFlightDate"),_FlightInfoDto.fDate?_FlightInfoDto.fDate:@""];
		self.hanBanRiQiLbl.text = hanbanriqi;
        
        NSString *qifei = [NSString stringWithFormat:@"%@%@ %@",
                                  L(@"BTFly"),_FlightInfoDto.fTime?_FlightInfoDto.fTime:@"",
                                  _FlightInfoDto.oaFullName?_FlightInfoDto.oaFullName:@""];		
		self.qiFeiLbl.text = qifei;//09:05 北京首都国际机场
        
        NSString *jiangluo = [NSString stringWithFormat:@"%@%@ %@",L(@"BTLand"),
                           _FlightInfoDto.aTime?_FlightInfoDto.aTime:@"",
                           _FlightInfoDto.aaFullName?_FlightInfoDto.aaFullName:@""];		
		self.jiangLuoLbl.text = jiangluo;
        
        if ([_FlightInfoDto.roomList count]!=0) {
      
            self.FlightRoomInfoDto = [_FlightInfoDto.roomList objectAtIndex:0];
        
            NSString *eprice = [NSString stringWithFormat:@"%.2f", [_FlightRoomInfoDto.sysPrice?_FlightRoomInfoDto.sysPrice:0 doubleValue] - [_FlightRoomInfoDto.offPrice?_FlightRoomInfoDto.offPrice:0 doubleValue]];
            self.jiPiaoDanJiaLbl.text = L(@"BTAirTicketPrice");
            self.jiPiaoDanJiaValLbl.text = [NSString stringWithFormat:@"￥%@",eprice];
            
        }
        
        NSString *jijianPrice = [NSString stringWithFormat:@"%.2f", [_FlightInfoDto.aptA?_FlightInfoDto.aptA:0 doubleValue]];
        NSString *ranyouPrice = [NSString stringWithFormat:@"%.2f", [_FlightInfoDto.aotA?_FlightInfoDto.aotA:0 doubleValue]];        
		self.jiJianRanYouFeiLbl.text = L(@"BTBunkerSurcharge");
        self.jiJianRanYouFeiValLbl.text = [NSString stringWithFormat:@"￥%@/￥%@",jijianPrice,ranyouPrice];
		
	}
    
    [self setNeedsLayout];
    
    
}



-(void) layoutSubviews{
	
	[super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    CGSize size = [@"a" sizeWithFont:font];

	self.quFanHangBanLbl.frame = CGRectMake(leftPadding, 15, 300, size.height);	
	self.hanBanRiQiLbl.frame = CGRectMake(leftPadding, 25+size.height, 300, size.height);    
    self.qiFeiLbl.frame = CGRectMake(leftPadding, (10+size.height)*2+15, 300, size.height);
    self.jiangLuoLbl.frame = CGRectMake(leftPadding, (10+size.height)*3+15, 300, size.height);
    
    self.jiPiaoDanJiaLbl.frame = CGRectMake(leftPadding, (10+size.height)*4+15, 80, size.height);
    self.jiPiaoDanJiaValLbl.frame = CGRectMake(_jiPiaoDanJiaLbl.right, _jiPiaoDanJiaLbl.top, 150, size.height);
    
    self.jiJianRanYouFeiLbl.frame = CGRectMake(leftPadding, (10+size.height)*5+15, 110, size.height);
    self.jiJianRanYouFeiValLbl.frame = CGRectMake(_jiJianRanYouFeiLbl.right, _jiJianRanYouFeiLbl.top, 150, size.height);
    
    self.refundBtn.frame = CGRectMake(230, 10, 80, 36);
   
}

-(UIImage *) hangBanImage{

    if (!_hangBanImage)
    {
        

    }
    
    
    return _hangBanImage;
}


- (void)prepareForReuse
{
    UIImageView *separatorLine = (UIImageView *)[self.contentView viewWithTag:9527];
    
    [separatorLine removeFromSuperview];
}


-(UILabel *) quFanHangBanLbl{
	
	if (!_quFanHangBanLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:16];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_quFanHangBanLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_quFanHangBanLbl.backgroundColor = [UIColor clearColor];
		
		_quFanHangBanLbl.font = font;
		
        _quFanHangBanLbl.textColor = [UIColor orange_Red_Color];
        
		_quFanHangBanLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_quFanHangBanLbl];
	}	
	return _quFanHangBanLbl;
}


-(UILabel *) hanBanRiQiLbl{
	
	if (!_hanBanRiQiLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_hanBanRiQiLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_hanBanRiQiLbl.backgroundColor = [UIColor clearColor];
		
		_hanBanRiQiLbl.font = font;
		
		_hanBanRiQiLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_hanBanRiQiLbl];
	}	
	return _hanBanRiQiLbl;
}


-(UILabel *) qiFeiLbl{
	
	if (!_qiFeiLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_qiFeiLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_qiFeiLbl.backgroundColor = [UIColor clearColor];
		
		_qiFeiLbl.font = font;
		
		_qiFeiLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_qiFeiLbl];
	}	
	return _qiFeiLbl;
}


-(UILabel *) jiangLuoLbl{
	
	if (!_jiangLuoLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_jiangLuoLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_jiangLuoLbl.backgroundColor = [UIColor clearColor];
		
		_jiangLuoLbl.font = font;
		
		_jiangLuoLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_jiangLuoLbl];
	}	
	return _jiangLuoLbl;
}


-(UILabel *) jiPiaoDanJiaLbl{
	
	if (!_jiPiaoDanJiaLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_jiPiaoDanJiaLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_jiPiaoDanJiaLbl.backgroundColor = [UIColor clearColor];
		
		_jiPiaoDanJiaLbl.font = font;
		
		_jiPiaoDanJiaLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_jiPiaoDanJiaLbl];
	}	
	return _jiPiaoDanJiaLbl;
}


-(UILabel *) jiPiaoDanJiaValLbl{
	
	if (!_jiPiaoDanJiaValLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_jiPiaoDanJiaValLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.jiPiaoDanJiaLbl.right, 5, 60, size.height)];
		
		_jiPiaoDanJiaValLbl.backgroundColor = [UIColor clearColor];
		
		_jiPiaoDanJiaValLbl.font = font;
		
		_jiPiaoDanJiaValLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _jiPiaoDanJiaValLbl.textColor = [UIColor orange_Red_Color];
		
		[self.contentView addSubview:_jiPiaoDanJiaValLbl];
	}
	return _jiPiaoDanJiaValLbl;
}


-(UILabel *) jiJianRanYouFeiLbl{
	
	if (!_jiJianRanYouFeiLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_jiJianRanYouFeiLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_jiJianRanYouFeiLbl.backgroundColor = [UIColor clearColor];
		
		_jiJianRanYouFeiLbl.font = font;
		
		_jiJianRanYouFeiLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_jiJianRanYouFeiLbl];
	}	
	return _jiJianRanYouFeiLbl;
}


-(UILabel *) jiJianRanYouFeiValLbl{
	
	if (!_jiJianRanYouFeiValLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_jiJianRanYouFeiValLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.jiJianRanYouFeiLbl.right, 5, 60, size.height)];
		
		_jiJianRanYouFeiValLbl.backgroundColor = [UIColor clearColor];
		
		_jiJianRanYouFeiValLbl.font = font;
		
		_jiJianRanYouFeiValLbl.autoresizingMask = UIViewAutoresizingNone;
		
        _jiJianRanYouFeiValLbl.textColor = [UIColor orange_Red_Color];

		[self.contentView addSubview:_jiJianRanYouFeiValLbl];
	}
	return _jiJianRanYouFeiValLbl;
}


-(UIButton *)refundBtn{

    if (_refundBtn == nil) {
        _refundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _refundBtn.backgroundColor = [UIColor clearColor];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [_refundBtn setBackgroundImage:stretchableButtonImageNormal 
                                  forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"orange_button_clicked.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [_refundBtn setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
        
        
        [_refundBtn setTitle:L(@"BTEndorse") forState:UIControlStateNormal];
        
        [_refundBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _refundBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        
        [_refundBtn addTarget:self action:@selector(refundTicketAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_refundBtn];

    }
    return _refundBtn;
}


-(void)refundTicketAction:(id)sender{

    if ([delegate conformsToProtocol:@protocol(hangBanItemCellDelegate) ]) {
        if ([delegate respondsToSelector:@selector(returnRefundTicketAction:)]) {
            [delegate returnRefundTicketAction:self.FlightInfoDto];
        }
    }
}


@end
