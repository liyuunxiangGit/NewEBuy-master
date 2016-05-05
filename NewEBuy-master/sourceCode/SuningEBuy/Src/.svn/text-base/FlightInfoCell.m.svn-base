//
//  FlightInfoCell.m
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightInfoCell.h"

#define  NameLabel_Width    175
#define  PriceLabel_Width   115
#define  Line1_Height       25
#define  Line2_height       20
#define  Line3_height       15



@implementation FlightInfoCell
@synthesize item = _item;
@synthesize airportImageView = _airportImageView;
@synthesize airportNameLabel = _airportNameLabel;
@synthesize startNameLabel = _startNameLabel;
@synthesize stopNameLabel = _stopNameLabel;
@synthesize priceLable = _priceLable;
@synthesize discountLabel = _discountLabel;
@synthesize ticketLabel = _ticketLabel;
@synthesize roomStyleLabel = _roomStyleLabel;
@synthesize isExpanded = _isExpanded;
@synthesize expandIconView = _expandIconView;
@synthesize lineView = _lineView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}


- (void)dealloc {
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_airportImageView);
    TT_RELEASE_SAFELY(_startNameLabel);
    TT_RELEASE_SAFELY(_stopNameLabel);
    TT_RELEASE_SAFELY(_priceLable);
    TT_RELEASE_SAFELY(_discountLabel);
    TT_RELEASE_SAFELY(_ticketLabel);
    TT_RELEASE_SAFELY(_expandIconView);
}


+ (CGFloat)height:(FlightListDetailDTO *)flightInfoDto
{
    return 80;
}


- (void)setItem:(FlightListDetailDTO *)aItem 
{
    if (aItem != _item)
    {
        TT_RELEASE_SAFELY(_item);
        
        _item = aItem;  
                        
        self.airportImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://image.suning.cn/images/advertise/hjc123/hkgs516/%@.png",self.item.company]];
        
        self.airportNameLabel.text = [NSString stringWithFormat:@"%@%@",self.item.companyName,self.item.fNo];
        
        self.roomStyleLabel.text = [NSString stringWithFormat:@"%@ %@",L(self.item.roomB),self.item.room];
        
        if ([self.item.offRate integerValue]>=10) {
            self.priceLable.text = [NSString stringWithFormat:@"￥%@ ",self.item.roomPrice];
        }else{
            self.priceLable.text = [NSString stringWithFormat:@"￥%@ (%@%@)",self.item.roomPrice,self.item.offRate,L(@"BTSale")];
        }
        
        self.startNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.item.fTime ,self.item.oaFullName];
        
        self.stopNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.item.aTime,self.item.aaFullName];
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

-(void)setIsExpanded:(BOOL)isExpanded{

    if (isExpanded == YES) {
        UIImage *image = [UIImage imageNamed:@"home_purchase_left_mark_enable.png"];
         UIImage *rotated = [image imageRotatedByDegrees:90];
        self.expandIconView.image = rotated;
        
    }else{
        
        UIImage *image = [UIImage imageNamed:@"home_purchase_left_mark_enable.png"];
        UIImage *rotated = [image imageRotatedByDegrees:270];
        self.expandIconView.image = rotated;
    
    }


}


-(void) layoutSubviews{
	
	[super layoutSubviews];
    
    self.airportNameLabel.frame = CGRectMake(self.airportImageView.right + 10, 5, self.airportNameLabel.width, self.airportNameLabel.height);
    
    self.startNameLabel.frame = CGRectMake(self.airportNameLabel.left - 20, self.airportNameLabel.bottom + 5, self.startNameLabel.width, self.startNameLabel.height);
        
    if ([self.item.retPrice isEqualToString:@"0"]) {
        
        if (self.ticketLabel.superview != nil) {
            
            [self.ticketLabel removeFromSuperview];
        }
        
        self.priceLable.frame = CGRectMake(self.startNameLabel.right, self.airportNameLabel.bottom+7, self.priceLable.width, self.priceLable.height);
        
        self.discountLabel.frame = CGRectMake(self.priceLable.left, self.priceLable.bottom+2, self.discountLabel.width, self.discountLabel.height);
        
        
    }else{
        
        
        if (self.ticketLabel.superview ==nil) {
            
            [self.contentView addSubview:self.ticketLabel];
        }
        
        self.priceLable.frame = CGRectMake(self.startNameLabel.right, self.airportNameLabel.bottom, self.priceLable.width, self.priceLable.height);
        
        self.discountLabel.frame = CGRectMake(self.priceLable.left, self.priceLable.bottom+2, self.discountLabel.width, self.discountLabel.height);
        
        if (self.discountLabel.hidden) {//Kristopher
            self.ticketLabel.frame = CGRectMake(self.discountLabel.left, self.discountLabel.bottom-self.ticketLabel.height/2.0, self.ticketLabel.width, self.ticketLabel.height);
        }else{
            self.ticketLabel.frame = CGRectMake(self.discountLabel.left, self.discountLabel.bottom, self.ticketLabel.width, self.ticketLabel.height);
        }
        
    }
    
    self.roomStyleLabel.frame = CGRectMake(self.priceLable.left, self.airportNameLabel.top, self.roomStyleLabel.width, self.roomStyleLabel.height);

    self.stopNameLabel.frame = CGRectMake(self.startNameLabel.left, self.startNameLabel.bottom , self.stopNameLabel.width, self.stopNameLabel.height); 
    
    self.lineView.frame = CGRectMake(0,self.bottom - 1, 320, 1);
	
}

-(UIImageView *)expandIconView{

    if (!_expandIconView) {
        
        _expandIconView = [[UIImageView alloc] init];
        
        _expandIconView.backgroundColor = [UIColor clearColor];
        
        _expandIconView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_expandIconView];
        
    }

    return _expandIconView;
}

- (EGOImageView *)airportImageView
{
    if (!_airportImageView) {
		        
		_airportImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(10, 5, 22, 22)];
        
        _airportImageView.placeholderImage = [UIImage imageNamed:@""];
        
		_airportImageView.backgroundColor =[UIColor clearColor];
        
        _airportImageView.contentMode = UIViewContentModeScaleAspectFit;
                
        [self.contentView addSubview:_airportImageView];
        
	}
	
	return _airportImageView;
    
}

- (UILabel *)airportNameLabel
{
    if (nil == _airportNameLabel) 
    {
        _airportNameLabel = [[UILabel alloc]init];
        _airportNameLabel.backgroundColor = [UIColor clearColor];
        _airportNameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _airportNameLabel.textAlignment = UITextAlignmentLeft;
        _airportNameLabel.size = CGSizeMake(NameLabel_Width, Line1_Height);
        _airportNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_airportNameLabel];
    } 
    return _airportNameLabel;
}


- (UILabel *)roomStyleLabel{
    
    if (nil == _roomStyleLabel) 
    {
        _roomStyleLabel = [[UILabel alloc]init];
        _roomStyleLabel.backgroundColor = [UIColor clearColor];
        _roomStyleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _roomStyleLabel.textAlignment = UITextAlignmentLeft;
        _roomStyleLabel.size = CGSizeMake(NameLabel_Width, Line1_Height);
        _roomStyleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_roomStyleLabel];
    } 
    return _roomStyleLabel;

}

- (UILabel *)startNameLabel
{
    if (nil == _startNameLabel) 
    {
        _startNameLabel = [[UILabel alloc]init];
        _startNameLabel.backgroundColor = [UIColor clearColor];
        _startNameLabel.font = [UIFont systemFontOfSize:14.0];
        _startNameLabel.textAlignment = UITextAlignmentLeft;
        _startNameLabel.size = CGSizeMake(NameLabel_Width, Line1_Height);
        _startNameLabel.textColor = RGBCOLOR(161, 161, 161);
        _startNameLabel.userInteractionEnabled = NO;
        [self.contentView addSubview:_startNameLabel];
    } 
    return _startNameLabel;
}

- (UILabel *)stopNameLabel
{
    if (nil == _stopNameLabel) 
    {
        _stopNameLabel = [[UILabel alloc]init];
        _stopNameLabel.backgroundColor = [UIColor clearColor];
        _stopNameLabel.font = [UIFont systemFontOfSize:14.0];
        _stopNameLabel.textAlignment = UITextAlignmentLeft;
        _stopNameLabel.size = CGSizeMake(NameLabel_Width, Line1_Height);
        _stopNameLabel.textColor = RGBCOLOR(161, 161, 161);
        _stopNameLabel.userInteractionEnabled = NO;
        [self.contentView addSubview:_stopNameLabel];
    } 
    return _stopNameLabel;
}



- (UILabel *)priceLable
{
    if (nil == _priceLable) 
    {
        _priceLable = [[UILabel alloc]init];
        _priceLable.backgroundColor = [UIColor clearColor];
        _priceLable.font = [UIFont boldSystemFontOfSize:16.0];
        _priceLable.textAlignment = UITextAlignmentLeft;
        _priceLable.size = CGSizeMake(PriceLabel_Width, Line1_Height);
        _priceLable.textColor = [UIColor orange_Red_Color];
        _priceLable.userInteractionEnabled = NO;
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
        _discountLabel.font = [UIFont systemFontOfSize:12.0];
        _discountLabel.textAlignment = UITextAlignmentLeft;
        _discountLabel.size = CGSizeMake(PriceLabel_Width, Line3_height);
        _discountLabel.textColor = [UIColor orange_Light_Color];
        _discountLabel.userInteractionEnabled = NO;
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
        _ticketLabel.font = [UIFont systemFontOfSize:12.0];
        _ticketLabel.textAlignment = UITextAlignmentLeft;
        _ticketLabel.size = CGSizeMake(PriceLabel_Width, Line3_height);
        _ticketLabel.textColor = RGBCOLOR(207, 9, 9);
        _ticketLabel.userInteractionEnabled = NO;
        [self.contentView addSubview:_ticketLabel];
    } 
    return _ticketLabel;
}


-(UIImageView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_cellSeparatorLine.png"]];
        
        _lineView.userInteractionEnabled = YES;
    
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;


}



@end
