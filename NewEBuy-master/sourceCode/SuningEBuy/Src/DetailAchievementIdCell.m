//
//  DetailAchievementIdCell.m
//  SuningEBuy
//
//  Created by lanfeng on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailAchievementIdCell.h"

@implementation DetailAchievementIdCell

@synthesize billNoLabel = _billNoLabel;

@synthesize processTimeLabel = _processTimeLabel;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;		
        
        self.backgroundColor = [UIColor cellBackViewColor];
    }
    return self;}


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_billNoLabel);
    TT_RELEASE_SAFELY(_processTimeLabel);
    
}

- (void)setItem:(AchievementExchangeDTO *)aItem{
   
    if (nil == aItem) {
        return;
    }
    
    self.billNoLabel.text = aItem.billNo;
    self.processTimeLabel.text = aItem.processTime;
    
}


-(UILabel *)billNoLabel{
    
    if (nil == _billNoLabel) {
        
		_billNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 125, 40)];
        
        _billNoLabel.textAlignment = UITextAlignmentLeft;
		
		_billNoLabel.backgroundColor = [UIColor clearColor];
        
        _billNoLabel.textColor = [UIColor colorWithRGBHex:0x444444];//[UIColor skyBlueColor];
        
		_billNoLabel.font = [UIFont systemFontOfSize:16.0];
		
		_billNoLabel.autoresizingMask = UIViewAutoresizingNone;
        
		[self.contentView addSubview:_billNoLabel];
	}
	
	return _billNoLabel;
}


-(UILabel *)processTimeLabel{
    
    if (nil == _processTimeLabel) {
        
		_processTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 160, 40)];
        
        _processTimeLabel.textAlignment = UITextAlignmentRight;
		
		_processTimeLabel.backgroundColor = [UIColor clearColor];
        
        _processTimeLabel.textColor = [UIColor colorWithRGBHex:0x999081];//[UIColor grayColor];
        
		_processTimeLabel.font = [UIFont systemFontOfSize:16.0];
		
		_processTimeLabel.autoresizingMask = UIViewAutoresizingNone;
        
		[self.contentView addSubview:_processTimeLabel];
	}
	
	return _processTimeLabel;
}


+ (CGFloat)height:(AchievementExchangeDTO *)item{
    
    return 40;

}



@end
