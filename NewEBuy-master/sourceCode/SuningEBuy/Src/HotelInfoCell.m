//
//  HotelInfoCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelInfoCell.h"
#define Label_Width 290

@implementation HotelInfoCell

@synthesize dto=_dto;

@synthesize nameLabel=_nameLabel;
@synthesize addressLabel=_addressLabel;
@synthesize starView=_starView;
@synthesize roomType=_roomType;
@synthesize typeLbl=_typeLbl;
@synthesize roomNum=_roomNum;
@synthesize roomTime=_roomTime;
@synthesize timeLbl=_timeLbl;

@synthesize starLineView=_starLineView;
@synthesize addressLineView=_addressLineView;

-(void)dealloc
{
    TT_RELEASE_SAFELY(_nameLabel);
    TT_RELEASE_SAFELY(_addressLabel);
    TT_RELEASE_SAFELY(_starView);
    TT_RELEASE_SAFELY(_roomType);
    TT_RELEASE_SAFELY(_typeLbl);
    TT_RELEASE_SAFELY(_roomNum);
    TT_RELEASE_SAFELY(_roomTime);
    TT_RELEASE_SAFELY(_timeLbl);
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel*)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(15,10,Label_Width, 20)];
        _nameLabel.backgroundColor=[UIColor clearColor];
        _nameLabel.textColor=[UIColor light_Black_Color];
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.numberOfLines=0;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}
-(HotelStarView*)starView{
    if (!_starView) {
        
        _starView = [[HotelStarView alloc] init];
        
        _starView.backgroundColor = [UIColor clearColor];
        
        _starView.frame = CGRectMake(15, 58, 80, 20);
        
        [self.contentView addSubview:_starView];
    }
    return _starView;
    
}
-(UILabel*)addressLabel{
    if (_addressLabel==nil) {
        _addressLabel=[[UILabel alloc] initWithFrame:CGRectMake(15,10,Label_Width, 20)];
        _addressLabel.backgroundColor=[UIColor clearColor];
        _addressLabel.textColor=[UIColor dark_Gray_Color];
        _addressLabel.font=[UIFont systemFontOfSize:13];
        _addressLabel.numberOfLines=0;
        [self.contentView addSubview:_addressLabel];
    }
    return _addressLabel;
}

-(UILabel*)roomType
{
    if (_roomType==nil) {
        _roomType=[[UILabel alloc] initWithFrame:CGRectMake(15,5,100, 20)];
        _roomType.backgroundColor=[UIColor clearColor];
        _roomType.textColor=[UIColor light_Black_Color];
        _roomType.font=[UIFont systemFontOfSize:13];
        _roomType.text =  L(@"hotelRoomType");
        [self.contentView addSubview:_roomType];
    }
    return _roomType;

}
-(UILabel*)typeLbl
{
    if (_typeLbl==nil) {
        _typeLbl=[[UILabel alloc] initWithFrame:CGRectMake(130,5,175, 20)];
        _typeLbl.backgroundColor=[UIColor clearColor];
        _typeLbl.textColor=[UIColor light_Black_Color];
        _typeLbl.font=[UIFont systemFontOfSize:13];
        _typeLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_typeLbl];
    }
    return _typeLbl;
}
-(UILabel*)roomNum
{
    if (_roomNum==nil) {
        _roomNum=[[UILabel alloc] initWithFrame:CGRectMake(15,5,100, 20)];
        _roomNum.backgroundColor=[UIColor clearColor];
        _roomNum.textColor=[UIColor light_Black_Color];
        _roomNum.font=[UIFont systemFontOfSize:13];
        _roomNum.text =  L(@"bookRoomCount");
        [self.contentView addSubview:_roomNum];
    }
    return _roomNum;
    
}
-(UILabel*)numLbl
{
    if (_numLbl==nil) {
        _numLbl=[[UILabel alloc] initWithFrame:CGRectMake(130,5,175, 20)];
        _numLbl.backgroundColor=[UIColor clearColor];
        _numLbl.textColor=[UIColor light_Black_Color];
        _numLbl.font=[UIFont systemFontOfSize:13];
        _numLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_numLbl];
    }
    return _numLbl;
}
-(UILabel*)roomTime
{
    if (_roomTime==nil) {
        _roomTime=[[UILabel alloc] initWithFrame:CGRectMake(15,5,100, 20)];
        _roomTime.backgroundColor=[UIColor clearColor];
        _roomTime.textColor=[UIColor light_Black_Color];
        _roomTime.font=[UIFont systemFontOfSize:13];
        _roomTime.text =  L(@"starLiveTimer");

        [self.contentView addSubview:_roomTime];
    }
    return _roomTime;
    
}
-(UILabel*)timeLbl
{
    if (_timeLbl==nil) {
        _timeLbl=[[UILabel alloc] initWithFrame:CGRectMake(130,5,175, 20)];
        _timeLbl.backgroundColor=[UIColor clearColor];
        _timeLbl.textColor=[UIColor light_Black_Color];
        _timeLbl.font=[UIFont systemFontOfSize:13];
        _timeLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_timeLbl];
    }
    return _timeLbl;
}

-(UIImageView*)starLineView
{
    if (_starLineView==nil) {
        _starLineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_starLineView setImage:img];
        
        [self.contentView addSubview:_starLineView];
    }
    return _starLineView;
}
-(UIImageView*)addressLineView
{
    if (_addressLineView==nil) {
        _addressLineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_addressLineView setImage:img];
        
        [self.contentView addSubview:_addressLineView];
    }
    return _addressLineView;
}
+(float)nameLabelHeightWithString:(NSString*)string{
    CGSize size=[string sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(Label_Width,40) lineBreakMode:UILineBreakModeCharacterWrap];
    if (size.height<20) {
        return 20;
    }
    return size.height;
}
+(float)addressLabelHeightWithString:(NSString*)string{
    CGSize size=[string sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(Label_Width,40) lineBreakMode:UILineBreakModeCharacterWrap];
    if (size.height<20) {
        return 20;
    }
    return size.height;
}

+(float)cellHeightWithDto:(HotelOrderDetailDTO*)dto
{
    return [self nameLabelHeightWithString:dto.name]+20+30+[self addressLabelHeightWithString:dto.address]+20+30*3;
}


-(void)setHotelInfoCellWithDto:(HotelOrderDetailDTO*)dto
{
    if (!dto) {
        return;
    }
    self.dto=dto;
    
    self.nameLabel.text=_dto.name;
    self.nameLabel.height=[HotelInfoCell nameLabelHeightWithString:_dto.name];
    
    self.starView.top=self.nameLabel.bottom+10;
    [self.starView setStarsImages:_dto.statLevel];
    
    self.starLineView.top=self.starView.bottom+10;
    
    self.addressLabel.top=self.starView.bottom+20;
    self.addressLabel.height=[HotelInfoCell addressLabelHeightWithString:_dto.address];
    self.addressLabel.text=_dto.address;
    
    self.addressLineView.top=self.addressLabel.bottom+10;
    
    self.typeLbl.text=_dto.roomType;
    self.numLbl.text=_dto.bookingRoomCount;
    self.timeLbl.text=_dto.startLiveTimer;
    
    self.typeLbl.top=self.addressLabel.bottom+15;
    self.numLbl.top=self.typeLbl.bottom+5;
    self.timeLbl.top=self.numLbl.bottom+5;
    
    self.roomType.top=self.typeLbl.top;
    self.roomNum.top=self.numLbl.top;
    self.roomTime.top=self.timeLbl.top;

}
@end
