//
//  ManInfoCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ManInfoCell.h"

@implementation ManInfoCell

@synthesize dto=_dto;
@synthesize liveMan=_liveMan;
@synthesize contactMan=_contactMan;
@synthesize erliestCome=_erliestCome;
@synthesize latestCome=_latestCome;
@synthesize liveNamesLbl=_liveNamesLbl;
@synthesize contactLbl=_contactLbl;
@synthesize erliestLbl=_erliestLbl;
@synthesize latestLbl=_latestLbl;

@synthesize liveManLine=_liveManLine;
@synthesize contactManLine=_contactManLine;

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
-(UILabel*)liveMan{
    if (_liveMan==nil) {
        _liveMan=[[UILabel alloc] initWithFrame:CGRectMake(15,10,80, 20)];
        _liveMan.backgroundColor=[UIColor clearColor];
        _liveMan.textColor=[UIColor light_Black_Color];
        _liveMan.font=[UIFont systemFontOfSize:15];
        _liveMan.text =  L(@"liveingInfo");
        [self.contentView addSubview:_liveMan];
    }
    return _liveMan;
}
-(UILabel*)liveNamesLbl{
    if (_liveNamesLbl==nil) {
        _liveNamesLbl=[[UILabel alloc] initWithFrame:CGRectMake(110,10,195, 20)];
        _liveNamesLbl.backgroundColor=[UIColor clearColor];
        _liveNamesLbl.textColor=[UIColor light_Black_Color];
        _liveNamesLbl.font=[UIFont systemFontOfSize:15];
        _liveNamesLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_liveNamesLbl];
    }
    return _liveNamesLbl;
}
-(UILabel*)contactMan{
    if (_contactMan==nil) {
        _contactMan=[[UILabel alloc] initWithFrame:CGRectMake(15,10,80, 20)];
        _contactMan.backgroundColor=[UIColor clearColor];
        _contactMan.textColor=[UIColor light_Black_Color];
        _contactMan.font=[UIFont systemFontOfSize:15];
        _contactMan.text =L(@"ContactInfo");
        [self.contentView addSubview:_contactMan];
    }
    return _contactMan;
}
-(UILabel*)contactLbl{
    if (_contactLbl==nil) {
        _contactLbl=[[UILabel alloc] initWithFrame:CGRectMake(110,10,195, 20)];
        _contactLbl.backgroundColor=[UIColor clearColor];
        _contactLbl.textColor=[UIColor light_Black_Color];
        _contactLbl.font=[UIFont systemFontOfSize:15];
        _contactLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_contactLbl];
    }
    return _contactLbl;
}
-(UILabel*)erliestCome{
    if (_erliestCome==nil) {
        _erliestCome=[[UILabel alloc] initWithFrame:CGRectMake(15,10,140, 20)];
        _erliestCome.backgroundColor=[UIColor clearColor];
        _erliestCome.textColor=[UIColor dark_Gray_Color];
        _erliestCome.font=[UIFont systemFontOfSize:13];
        _erliestCome.text =  L(@"liveingEarliestTimer");;
        [self.contentView addSubview:_erliestCome];
    }
    return _erliestCome;
}
-(UILabel*)erliestLbl{
    if (_erliestLbl==nil) {
        _erliestLbl=[[UILabel alloc] initWithFrame:CGRectMake(170,10,135, 20)];
        _erliestLbl.backgroundColor=[UIColor clearColor];
        _erliestLbl.textColor=[UIColor orange_Red_Color];
        _erliestLbl.font=[UIFont systemFontOfSize:13];
        _erliestLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_erliestLbl];
    }
    return _erliestLbl;
}
-(UILabel*)latestCome{
    if (_latestCome==nil) {
        _latestCome=[[UILabel alloc] initWithFrame:CGRectMake(15,10,140, 20)];
        _latestCome.backgroundColor=[UIColor clearColor];
        _latestCome.textColor=[UIColor dark_Gray_Color];
        _latestCome.font=[UIFont systemFontOfSize:13];
        _latestCome.text = L(@"liveingLatestTimer");
        [self.contentView addSubview:_latestCome];
    }
    return _latestCome;
}
-(UILabel*)latestLbl{
    if (_latestLbl==nil) {
        _latestLbl=[[UILabel alloc] initWithFrame:CGRectMake(170,10,135, 20)];
        _latestLbl.backgroundColor=[UIColor clearColor];
        _latestLbl.textColor=[UIColor orange_Red_Color];
        _latestLbl.font=[UIFont systemFontOfSize:13];
        _latestLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_latestLbl];
    }
    return _latestLbl;
}

-(UIImageView*)liveManLine
{
    if (_liveManLine==nil) {
        _liveManLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_liveManLine setImage:img];
        
        [self.contentView addSubview:_liveManLine];
    }
    return _liveManLine;
}

-(UIImageView*)contactManLine
{
    if (_contactManLine==nil) {
        _contactManLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_contactManLine setImage:img];
        
        [self.contentView addSubview:_contactManLine];
    }
    return _contactManLine;
}

-(void)setManInfoCellWithDto:(HotelOrderDetailDTO*)dto
{

    if (dto==nil) {
        return;
    }
    self.dto=dto;
    
    self.liveMan.top=10;
    self.liveNamesLbl.top=10;
    
    NSMutableString* liveNamesString=[[NSMutableString alloc] init];
    for (NSInteger index = 0; index < [_dto.liveingCountArr count]; index++) {
        
        [liveNamesString appendString:[_dto.liveingCountArr objectAtIndex:index]];
        if (index==[_dto.liveingCountArr count]-1) {
        }else{
            [liveNamesString appendString:@";"];
        }
    }
    self.liveNamesLbl.text=liveNamesString;
    
    self.liveManLine.top=self.liveNamesLbl.bottom+10;
    
    self.contactMan.top=self.liveMan.bottom+20;
    self.contactLbl.top=self.contactMan.top;
    
    self.contactManLine.top=self.contactMan.bottom+10;
    
    NSString* contactString=[NSString stringWithFormat:@"%@(%@)",_dto.contactName,_dto.phoneNumber];
    self.contactLbl.text=contactString;
    
    self.erliestCome.top=self.contactMan.bottom+20;
    self.erliestLbl.top=self.erliestCome.top;
    self.erliestLbl.text=_dto.liveEarliestTimer;
    
    self.latestCome.top=self.erliestCome.bottom+5;
    self.latestLbl.top=self.latestCome.top;
    self.latestLbl.text=_dto.liveLatestTimer;
    
}
@end
