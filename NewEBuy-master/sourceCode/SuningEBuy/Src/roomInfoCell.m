//
//  roomInfoCell.m
//  SuningEBuy
//
//  Created by shasha on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "roomInfoCell.h"

#define  RoomPriceLabel_Width   110
#define  RoomOffRateLabel_Width 100
#define  RoomLine1_Height       30
#define  RoomLine2_height       20

@implementation roomInfoCell
@synthesize priceLable = _priceLable;
@synthesize discountLabel = _discountLabel;
@synthesize ticketLabel = _ticketLabel;
@synthesize item = _item;
@synthesize offRateLabel = _offRateLabel;
@synthesize roomStyleLabel = _roomStyleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
                
    }
    return self;
}


- (void)dealloc {
    TT_RELEASE_SAFELY(_priceLable);
    TT_RELEASE_SAFELY(_discountLabel);
    TT_RELEASE_SAFELY(_ticketLabel);
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_offRateLabel);
    TT_RELEASE_SAFELY(_roomStyleLabel);
}


+ (CGFloat)height:(FlightListDetailDTO *)flightInfoDto
{
    return 70;
}


- (void)setItem:(FlightListDetailDTO *)aItem 
{
    if (aItem != _item)
    {
        TT_RELEASE_SAFELY(_item);
        
        _item = aItem;  
        
        if ([self.item.offRate integerValue]>=10) {
            self.priceLable.text = [NSString stringWithFormat:@"￥%@ ",self.item.roomPrice];
        }else{
            self.priceLable.text = [NSString stringWithFormat:@"￥%@ (%@%@)",self.item.roomPrice,self.item.offRate,L(@"BTSale")];
        }
        
        self.roomStyleLabel.text = [NSString stringWithFormat:@"%@ %@",L(self.item.roomB),self.item.room];
        //Kristopher
        if ([self.item.offPrice isEqualToString:@"0"]) {
            self.discountLabel.hidden = YES;
        }else{
            self.discountLabel.hidden = NO;
            self.discountLabel.text = [NSString stringWithFormat:@"%@￥%@",L(@"BTEbuyPriceReduction"),self.item.offPrice];
        }
        
        if ([self.item.retPrice isEqualToString:@"0"]) {
            
            self.ticketLabel.text = L(@"BTReturnTicket");
            
        }else{
            
            self.ticketLabel.text = [NSString stringWithFormat:@"%@￥%@",L(@"BTReturnTicket1"),self.item.retPrice];
            
        }
        
        [self setNeedsLayout];
        
    }
    
}


-(void) layoutSubviews{
	
	[super layoutSubviews];    
    
    self.priceLable.frame = CGRectMake(10,20, self.priceLable.width, self.priceLable.height);
        
    if ([self.item.retPrice isEqualToString:@"0"]) {
        
        if (self.ticketLabel.superview != nil) {
            
            [self.ticketLabel removeFromSuperview];
        }
                
        self.discountLabel.frame = CGRectMake(self.priceLable.right, 20, self.discountLabel.width, self.discountLabel.height);
        
    }else{
        
    
        if (self.ticketLabel.superview ==nil) {
            
            [self.contentView addSubview:self.ticketLabel];
        }
        
                
        
        
         self.discountLabel.frame = CGRectMake(self.priceLable.right, 10, self.discountLabel.width, self.discountLabel.height);
        
        if (self.discountLabel.hidden) {//Kristopher
            self.ticketLabel.frame = CGRectMake(self.discountLabel.left, self.discountLabel.bottom-self.ticketLabel.height/2.0, self.ticketLabel.width, self.ticketLabel.height);
        }else{
            self.ticketLabel.frame = CGRectMake(self.discountLabel.left, self.discountLabel.bottom, self.ticketLabel.width, self.ticketLabel.height);
        }
    
    }
    
        self.roomStyleLabel.frame = CGRectMake(self.discountLabel.right - 10,20,self.roomStyleLabel.width,self.roomStyleLabel.height);
	
}


- (UILabel *)priceLable
{
    if (nil == _priceLable) 
    {
        _priceLable = [[UILabel alloc]init];
        _priceLable.backgroundColor = [UIColor clearColor];
        _priceLable.font = [UIFont boldSystemFontOfSize:16.0];
        _priceLable.textAlignment = UITextAlignmentLeft;
        _priceLable.size = CGSizeMake(RoomPriceLabel_Width, RoomLine2_height);
        _priceLable.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_priceLable];
    } 
    return _priceLable;
}


- (UILabel *)discountLabel
{
    if (nil == _discountLabel) 
    {
        _discountLabel = [[UILabel alloc]init];
        _discountLabel.backgroundColor = [UIColor clearColor];
        _discountLabel.font = [UIFont systemFontOfSize:14.0];
        _discountLabel.textAlignment = UITextAlignmentLeft;
        _discountLabel.size = CGSizeMake(RoomPriceLabel_Width, RoomLine2_height);
        _discountLabel.textColor = [UIColor orange_Light_Color];
        [self.contentView addSubview:_discountLabel];
    } 
    return _discountLabel;
}



- (UILabel *)ticketLabel
{
    if (nil == _ticketLabel) 
    {
        _ticketLabel = [[UILabel alloc]init];
        _ticketLabel.backgroundColor = [UIColor clearColor];
        _ticketLabel.font = [UIFont systemFontOfSize:14.0];
        _ticketLabel.textAlignment = UITextAlignmentLeft;
        _ticketLabel.size = CGSizeMake(RoomOffRateLabel_Width, RoomLine1_Height);
        _ticketLabel.textColor = RGBCOLOR(207, 9, 9);
        [self.contentView addSubview:_ticketLabel];
    } 
    return _ticketLabel;
}


- (UILabel *)offRateLabel
{
    if (nil == _offRateLabel) 
    {
        _offRateLabel = [[UILabel alloc]init];
        _offRateLabel.backgroundColor = [UIColor clearColor];
        _offRateLabel.font = [UIFont systemFontOfSize:14.0];
        _offRateLabel.textAlignment = UITextAlignmentLeft;
        _offRateLabel.size = CGSizeMake(RoomOffRateLabel_Width, RoomLine1_Height);
        _offRateLabel.textColor = RGBCOLOR(207, 9, 9);
        [self.contentView addSubview:_offRateLabel];
    } 
    return _offRateLabel;
}

- (UILabel *)roomStyleLabel{
    
    if (nil == _roomStyleLabel) 
    {
        _roomStyleLabel = [[UILabel alloc]init];
        _roomStyleLabel.backgroundColor = [UIColor clearColor];
        _roomStyleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _roomStyleLabel.textAlignment = UITextAlignmentLeft;
        _roomStyleLabel.size = CGSizeMake(RoomPriceLabel_Width, RoomLine2_height);
        _roomStyleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_roomStyleLabel];
    } 
    return _roomStyleLabel;
    
}

@end
