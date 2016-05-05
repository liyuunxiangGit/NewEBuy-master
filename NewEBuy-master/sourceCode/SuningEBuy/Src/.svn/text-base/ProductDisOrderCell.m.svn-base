//
//  ProductDisOrderCell.m
//  SuningEBuy
//
//  Created by caowei on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProductDisOrderCell.h"


@implementation ProductDisOrderCell

@synthesize titleLabel = _titleLabel;

@synthesize nickNameLabel = _nickNameLabel;

@synthesize createTimeLabel = _createTimeLabel;

@synthesize dataSource = _dataSource;

@synthesize cellSeperater = _cellSeperater;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_cellSeperater);
    
    TT_RELEASE_SAFELY(_titleLabel);
    
    TT_RELEASE_SAFELY(_nickNameLabel);
    
    TT_RELEASE_SAFELY(_createTimeLabel);
    
    TT_RELEASE_SAFELY(_dataSource);
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
                
    }
    return self;
}

- (UIImageView *)cellSeperater
{
    if (!_cellSeperater) {
        _cellSeperater = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSeparatorLine.png"]];
        _cellSeperater.contentMode = UIViewContentModeScaleAspectFill;
        _cellSeperater.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_cellSeperater];
    }
    return _cellSeperater;
}

- (BOOL) validateMobileNo: (NSString *) mobileNo {
    NSString *mobileNoRegex = @"1[0-9]{10,10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex]; 
	
    return [mobileNoTest evaluateWithObject:mobileNo];
}

- (void)setItem:(DisProductDetailsDTO *)aItem
{
    if (aItem == nil)
    {
        return;
    }
    
    self.dataSource = aItem; 
    
    NSString *str_title = (aItem.title == nil || [aItem.title  isEqualToString:@""]) ?@"title":aItem.title;
    
    NSString *str_time = (aItem.createTime == nil || [aItem.createTime  isEqualToString:@""])?@"no time":aItem.createTime;
    NSString *str_name = (aItem.nickName == nil||(NSNull *)aItem.nickName == [NSNull null]) ?L(@"Display Order No name"):aItem.nickName;
    
    if([self validateMobileNo:str_name]){
        NSString *string1=[str_name substringWithRange:NSMakeRange(0, 3)];
        NSString *string2=[str_name substringWithRange:NSMakeRange(7, 4)];
        str_name=[NSString stringWithFormat:@"%@****%@",string1,string2];
        
        
    }
    self.nickNameLabel.text=str_name;
    
    
    self.titleLabel.text = str_title;
    
    self.createTimeLabel.text = str_time;
    
    //    self.nickNameLabel.text = str_name;
    
    [super setNeedsLayout];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize titleSize = [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(315, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize nickNameSize = [self.nickNameLabel.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(155, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize createTimeSize = [self.createTimeLabel.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(160, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    self.titleLabel.frame = CGRectMake(5, 0, 315, titleSize.height+15);
    
    self.nickNameLabel.frame = CGRectMake(5, titleSize.height+10, 155, nickNameSize.height+15);
    
    self.createTimeLabel.frame = CGRectMake(160, titleSize.height+10, 155, createTimeSize.height+15);
    
    self.cellSeperater.frame = CGRectMake(0, self.bounds.size.height - 2, 320, 2);
}

- (UILabel *)titleLabel{
    if (nil == _titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.textAlignment = UITextAlignmentLeft;
        
        _titleLabel.font = [UIFont systemFontOfSize:16];
        
        _titleLabel.textColor = [UIColor blackColor];
        
        _titleLabel.tag = 1;
        
        _titleLabel.numberOfLines = 0; 
        
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        _titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_titleLabel];
    }
    return  _titleLabel;
}
- (UILabel *)nickNameLabel{
    if (nil == _nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc]init];
     	
        _nickNameLabel.textAlignment = UITextAlignmentLeft;
        
        _nickNameLabel.font = [UIFont systemFontOfSize:16];
        
        _nickNameLabel.textColor = [UIColor skyBlueColor];
        
        _nickNameLabel.tag = 2;
        
        [_nickNameLabel setAdjustsFontSizeToFitWidth:NO];
        
        [_nickNameLabel setNumberOfLines:0];
        
        _nickNameLabel.backgroundColor = [UIColor clearColor];
        
        _nickNameLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_nickNameLabel];
    }    
    return _nickNameLabel;
}

- (UILabel *)createTimeLabel{
    if (nil == _createTimeLabel) {
        
        _createTimeLabel = [[UILabel alloc]init];
     	
        _createTimeLabel.textAlignment = UITextAlignmentRight;
        
        _createTimeLabel.font = [UIFont systemFontOfSize:16];
        
        _createTimeLabel.textColor = [UIColor grayColor];
        
        _createTimeLabel.tag = 3;   
        
        [_createTimeLabel setAdjustsFontSizeToFitWidth:NO];
        
        [_createTimeLabel setNumberOfLines:0];
        
        _createTimeLabel.backgroundColor = [UIColor clearColor];
        
        _createTimeLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_createTimeLabel];
    }    
    return _createTimeLabel;
}

+ (CGFloat)height:(DisProductDetailsDTO *)item
{
    if (item == nil)
    {
        return 0.0;
    }
    
    NSString *str_title = (item.title == nil || [item.title  isEqualToString:@""]) ?@"title":item.title;
    
    NSString *str_time = (item.createTime == nil || [item.createTime  isEqualToString:@""])?@"no time":item.createTime;
    
    NSString *str_name = (item.nickName == nil||(NSNull *)item.nickName == [NSNull null]) ?L(@"Display Order No name"):item.nickName;
    
    CGSize titleSize = [str_title sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(315, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize nickNameSize = [str_name sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(155, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize createTimeSize = [str_time sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(160, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGFloat temp = 0.0f;
    
    if(nickNameSize.height>createTimeSize.height){
        
        temp = titleSize.height+nickNameSize.height+25;
        
    }else{
        
        temp =  titleSize.height+createTimeSize.height+25;
    }
    
    return temp;
}

@end
