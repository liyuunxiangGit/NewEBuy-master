//
//  SingelImageCell.m
//  SuningEBuy
//
//  Created by xingxianping on 13-7-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SingelImageCell.h"

@implementation SingelImageCell
@synthesize titleLabel=_titleLabel;
@synthesize timeLabel=_timeLabel;
@synthesize bigImage=_bigImage;
@synthesize summaryLabel=_summaryLabel;
@synthesize separateLine=_separateLine;
@synthesize moreLabel=_moreLabel;
@synthesize right=_right;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_bigImage);
    TT_RELEASE_SAFELY(_summaryLabel);
    
    TT_RELEASE_SAFELY(_separateLine);
    TT_RELEASE_SAFELY(_moreLabel);
    TT_RELEASE_SAFELY(_right);
    
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.lineBreakMode=UILineBreakModeTailTruncation;
        _titleLabel.contentMode=UIViewContentModeLeft;
        _titleLabel.textAlignment=UITextAlignmentLeft;
        _titleLabel.textColor=[UIColor light_Black_Color];
        _titleLabel.font=[UIFont boldSystemFontOfSize:13];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.userInteractionEnabled=YES;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.lineBreakMode=UILineBreakModeWordWrap;
        _timeLabel.contentMode=UIViewContentModeLeft;
        _timeLabel.textAlignment=UITextAlignmentLeft;
        _timeLabel.font=[UIFont systemFontOfSize:12];
        _timeLabel.backgroundColor=[UIColor clearColor];
        _timeLabel.userInteractionEnabled=YES;
        _timeLabel.textColor=[UIColor dark_Gray_Color];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (EGOImageView *)bigImage
{
    if (!_bigImage) {
        _bigImage=[[EGOImageView alloc]init];
        _bigImage.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        _bigImage.userInteractionEnabled = YES;
        _bigImage.backgroundColor=[UIColor clearColor];
        
        _bigImage.userInteractionEnabled=YES;
        [self.contentView addSubview:_bigImage];
    }
    return _bigImage;
}

- (UILabel *)summaryLabel
{
    if (!_summaryLabel) {
        _summaryLabel=[[UILabel alloc]init];
        _summaryLabel.numberOfLines=0;
        _summaryLabel.lineBreakMode=UILineBreakModeTailTruncation;
        _summaryLabel.contentMode=UIViewContentModeCenter;
        _summaryLabel.textAlignment=UITextAlignmentLeft;
        _summaryLabel.font=[UIFont systemFontOfSize:12];
        _summaryLabel.backgroundColor=[UIColor clearColor];
        _summaryLabel.userInteractionEnabled=YES;
        _summaryLabel.textColor=[UIColor dark_Gray_Color];
        [self.contentView addSubview:_summaryLabel];
    }
    return _summaryLabel;
}


- (UIImageView *)separateLine
{
    if (!_separateLine) {
        _separateLine=[[UIImageView alloc]init];
        [_separateLine setImage:[UIImage imageNamed:@"line.png"]];
        [self.contentView addSubview:_separateLine];
    }
    return _separateLine;
}

- (UIImageView *)separateLine2
{
    if (!_separateLine2) {
        _separateLine2=[[UIImageView alloc]init];
        [_separateLine2 setImage:[UIImage imageNamed:@"line.png"]];
        [self.contentView addSubview:_separateLine2];
    }
    return _separateLine2;
}

- (UIImageView *)right
{
    if (!_right) {
        _right=[[UIImageView alloc]init];
        [_right setImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
        [self.contentView addSubview:_right];
    }
    return _right;
}

- (UILabel *)moreLabel
{
    if (!_moreLabel) {
        _moreLabel=[[UILabel alloc]init];
        _moreLabel.lineBreakMode=UILineBreakModeWordWrap;
        _moreLabel.contentMode=UIViewContentModeLeft;
        _moreLabel.textAlignment=UITextAlignmentLeft;
        _moreLabel.font=[UIFont boldSystemFontOfSize:13];
        _moreLabel.backgroundColor=[UIColor clearColor];
        _moreLabel.userInteractionEnabled=YES;
        _moreLabel.textColor=[UIColor light_Black_Color];
        _moreLabel.text=L(@"Imformation_CheckAll");
        _moreLabel.userInteractionEnabled=YES;
        _moreLabel.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:_moreLabel];
    }
    return _moreLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor cellBackViewColor];
        [self.contentView bringSubviewToFront:self.separateLine];
        [self.contentView bringSubviewToFront:self.separateLine2];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setItem:(BigImageTypeDTO *)item
{
    if (item != nil) {
        
        _item =item;
        
        [self reloadData];
    }
}

- (void)reloadData
{
    self.titleLabel.text = IsStrEmpty(self.item.title)?@"--":self.item.title;
    
    NSString *time=self.item.publishTime;
    NSString *publishTime = [NSString stringWithFormat:@"%i%@%@%@",[[time substringWithRange:NSMakeRange(5, 2)]intValue],L(@"Imformation_Month"),[time substringWithRange:NSMakeRange(8, 2)],L(@"Imformation_Day")];
    
    self.timeLabel.text=IsStrEmpty(publishTime)?@"--":publishTime;
    
    self.bigImage.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.item.imgUrl]];
    
    NSString *summary=self.item.summary;
    if ([summary length]>100) {
        summary=[summary substringToIndex:99];
    }
    self.summaryLabel.text=IsStrEmpty(summary)?@"--":summary ;
    
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIFont *font=[UIFont systemFontOfSize:12];
    
    NSString *summary=_item.summary;
    if ([summary length]>100) {
        summary=[summary substringToIndex:99];
    }
    
    CGSize size=[summary sizeWithFont:font constrainedToSize:CGSizeMake(260, 300000.f) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.titleLabel.frame =CGRectMake(30, 15, 260, 20);
    self.timeLabel.frame =CGRectMake(30, 35, 120, 20);
    self.bigImage.frame =CGRectMake(30, 60, 260, 140);
    self.summaryLabel.frame =CGRectMake(30, 205, 260, size.height);
    
    self.separateLine.frame =CGRectMake(0, self.summaryLabel.bottom +5, 320, 1);
    self.moreLabel.frame =CGRectMake(30, self.separateLine.bottom, 120, 30);
    self.right.frame =CGRectMake(280,self.separateLine.bottom+9  , 8, 12);
    self.separateLine2.frame =CGRectMake(0, self.bottom-1, 320, 1);
}


+ (CGFloat)height:(BigImageTypeDTO *)item
{
    if (item) {
        UIFont *font=[UIFont systemFontOfSize:12];
        
        NSString *summary=item.summary;
        if ([summary length]>100) {
            summary=[summary substringToIndex:99];
        }
        CGSize size=[summary sizeWithFont:font constrainedToSize:CGSizeMake(260, 300000.f) lineBreakMode:NSLineBreakByWordWrapping];
        
        return 240+size.height+5;
    }
    return 100;
}
@end
