//
//  DetailAchievementCell.m
//  ;
//
//  Created by lanfeng on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailAchievementCell.h"

@implementation DetailAchievementCell


@synthesize productNameLabel = _productNameLabel;

@synthesize typeLabel = _typeLabel;

@synthesize typeValueLabel = _typeValueLabel;

@synthesize achievementChangeLabel = _achievementChangeLabel;

@synthesize achievementChangeValueLabel = _achievementChangeValueLabel;

@synthesize exchangeDto = _exchangeDto;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;		
        
        self.backgroundColor = [UIColor clearColor];//cellBackViewColor
    }
    return self;
}

-(void)dealloc{
    
    
    TT_RELEASE_SAFELY(_productNameLabel);
    TT_RELEASE_SAFELY(_typeLabel);
    TT_RELEASE_SAFELY(_typeValueLabel);
    TT_RELEASE_SAFELY(_achievementChangeLabel);
    TT_RELEASE_SAFELY(_achievementChangeValueLabel);
}




-(void)setItem:(AchievementExchangeDTO *)item
{
    
    if (item == nil) {
            return;
    }
    
    
    if (CellPositionSingle == self.cellP ) {
        
        self.timeLine.hidden = YES;
        
        self.timePoint.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Hollow_Point.png"];
//        imgPoint = [UIImage imageNamed:@"Service_Detail_List_Cell_Hollow_Point.png"];
//        imgLine = [UIImage imageNamed:@"Service_Detail_List_Cell_Line.png"];
    }
    else if(CellPositionTop == self.cellP){
        
        self.timeLine.hidden = NO;
        
        self.timeLine.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Line.png"];
        
        self.timeLine.frame = CGRectMake(25, 19, 5, 41);
        
        self.timePoint.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Hollow_Point.png"];
    }
    else if(CellPositionCenter == self.cellP){
        
        self.timeLine.hidden = NO;
        
        self.timeLine.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Line.png"];
        
        self.timeLine.frame = CGRectMake(25, 0, 5, 60);
        
        self.timePoint.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Point.png"];
    }
    else if(CellPositionBottom == self.cellP){
        
        self.timeLine.hidden = NO;
        
        self.timeLine.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Line.png"];
        
        self.timeLine.frame = CGRectMake(25, 0, 5, 7);
        
        self.timePoint.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Point.png"];
    }
    
    self.exchangeDto = item;

    NSString *_billType = (self.exchangeDto.billType == nil || [self.exchangeDto.billType  isEqualToString:@""]) ?L(@"billType"):self.exchangeDto.billType;
    NSString *_batchPoint = self.exchangeDto.batchPoint == nil ?@"0":[NSString stringWithFormat:@"%d",[self.exchangeDto.batchPoint intValue]];
    
    if (self.exchangeDto.commodityName == nil || [self.exchangeDto.commodityName isEqualToString:@""]) {
        //isProductNameEmpty = YES;
        self.productNameLabel.text = self.exchangeDto.billType;
    }else{
        //isProductNameEmpty = NO;
        self.productNameLabel.text = self.exchangeDto.commodityName;    

    }
    self.typeLabel.text = [self changeType:self.exchangeDto.processTime];//self.exchangeDto.processTime;
    self.typeValueLabel.text = _billType;
    
    self.achievementChangeValueLabel.text = _batchPoint;
    
    [super setNeedsLayout];
    
    
}

-(NSString *)changeType:(NSString *)time{
    //yyyy-MM-dd  ->  yyyy/MM/dd
    
    if (!IsStrEmpty(time) && [time length]>=10) {
        
        NSString *timeStr = [time substringWithRange:NSMakeRange(0, 10)];
        
        return [timeStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
    
    return @"///";
}


-(UILabel *)productNameLabel{
    
    if (nil == _productNameLabel) {
        
		_productNameLabel = [[UILabel alloc] init];
        
        _productNameLabel.textAlignment = UITextAlignmentLeft;
		
		_productNameLabel.backgroundColor = [UIColor clearColor];
        
		_productNameLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		_productNameLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _productNameLabel.textColor = [UIColor light_Black_Color];
        
//		[self.contentView addSubview:_productNameLabel];
	}
	
	return _productNameLabel;
}

-(UILabel *)typeLabel{
    
    if (nil == _typeLabel) {
        
		_typeLabel = [[UILabel alloc] init];
        
        _typeLabel.textAlignment = UITextAlignmentRight;
		
		_typeLabel.backgroundColor = [UIColor clearColor];
        
        _typeLabel.text = L(@"billType");
        
        _typeLabel.textColor = [UIColor grayColor];
        
		_typeLabel.font = [UIFont boldSystemFontOfSize:10.0];
		
		_typeLabel.autoresizingMask = UIViewAutoresizingNone;
        _typeLabel.textColor = [UIColor dark_Gray_Color];
        
	}
	
	return _typeLabel;
}

-(UILabel *)typeValueLabel{
    
    if (nil == _typeValueLabel) {
        
		_typeValueLabel = [[UILabel alloc] init];
        
        _typeValueLabel.textAlignment = UITextAlignmentLeft;
		
		_typeValueLabel.backgroundColor = [UIColor clearColor];
        
		_typeValueLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		_typeValueLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _typeValueLabel.textColor = [UIColor dark_Gray_Color];
        
//		[self.contentView addSubview:_typeValueLabel];
	}
	
	return _typeValueLabel;
}

-(UILabel *)achievementChangeLabel{
    
    if (nil == _achievementChangeLabel) {
        
		_achievementChangeLabel = [[UILabel alloc] init];
        
        _achievementChangeLabel.textAlignment = UITextAlignmentLeft;
		
		_achievementChangeLabel.backgroundColor = [UIColor clearColor];
        
        _achievementChangeLabel.text = L(@"batchPoint");
        
        _achievementChangeLabel.textColor = [UIColor colorWithRGBHex:0x999081];//[UIColor grayColor];
        
		_achievementChangeLabel.font = [UIFont systemFontOfSize:16.0];
		
		_achievementChangeLabel.autoresizingMask = UIViewAutoresizingNone;
        
//		[self.contentView addSubview:_achievementChangeLabel];
	}
	
	return _achievementChangeLabel;
}


-(UILabel *)achievementChangeValueLabel{
    
    if (nil == _achievementChangeValueLabel) {
        
		_achievementChangeValueLabel = [[UILabel alloc] init];
        
        _achievementChangeValueLabel.textAlignment = UITextAlignmentRight;
		
		_achievementChangeValueLabel.backgroundColor = [UIColor clearColor];
        
		_achievementChangeValueLabel.font = [UIFont boldSystemFontOfSize:12];
		
		_achievementChangeValueLabel.autoresizingMask = UIViewAutoresizingNone;
        _achievementChangeValueLabel.textColor = [UIColor orange_Light_Color];
        
//		[self.contentView addSubview:_achievementChangeValueLabel];
	}
	
	return _achievementChangeValueLabel;
}
- (UIImageView *)timePoint
{
    if (!_timePoint) {
        _timePoint = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 15, 15)];
        _timePoint.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Hollow_Point.png"];
    }
    return _timePoint;
}

- (UIImageView *)timeLine
{
    if (!_timeLine) {
        _timeLine = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, 5, 27)];
        _timeLine.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Line.png"];
    }
    return _timeLine;
}
+ (CGFloat)height:(AchievementExchangeDTO *)item{
    
    if (item.commodityName == nil || [item.commodityName isEqualToString:@""]) {
        
        return 62;
    }
    
    return 90;
    
}



- (void)layoutSubviews{
    
    [super layoutSubviews];

    [self timeLine];
    [self timePoint];
    [self.contentView removeAllSubviews];
    

    
        self.productNameLabel.frame = CGRectMake(55, 5, 190, 15);
        
    
        self.typeValueLabel.frame = CGRectMake(55, 23, 190, 15);
        
       // self.achievementChangeLabel.frame = CGRectMake(10, 56, 80, 30);
        
        self.achievementChangeValueLabel.frame = CGRectMake(245, 5, 60, 15);
    
        self.typeLabel.frame = CGRectMake(245, 23, 60, 15);
        
        [self.contentView addSubview:self.productNameLabel];
        
        [self.contentView addSubview:self.typeLabel];
        
        [self.contentView addSubview:self.typeValueLabel];
        
      //  [self.contentView addSubview:self.achievementChangeLabel];
        
        [self.contentView addSubview:self.achievementChangeValueLabel];
        

    [self.contentView addSubview:self.timePoint];
    [self.contentView addSubview:self.timeLine];
    

    
}

@end
