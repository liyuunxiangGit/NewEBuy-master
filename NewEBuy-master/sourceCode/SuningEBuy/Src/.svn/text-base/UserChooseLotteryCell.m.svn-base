//
//  UserChooseLotteryCell.m
//  SuningEBuy
//
//  Created by david david on 12-6-29.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "UserChooseLotteryCell.h"
#import "NSAttributedString+Attributes.h"


#define COMMON_FONT_SIZE 14.0

@implementation UserChooseLotteryCell


@synthesize lotteryData = _lotteryData;
@synthesize separatorLineImageView = _separatorLineImageView;
@synthesize codeLabel  = _codeLabel;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize isBottomItem = _isBottomItem;
@synthesize desLabel = _desLabel;
@synthesize lotteryNo = _lotteryNo;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_lotteryData);
    TT_RELEASE_SAFELY(_separatorLineImageView);
    TT_RELEASE_SAFELY(_codeLabel);
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_desLabel);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}


-(void)setItem:(NSString *)string indexRow:(int)indexRow{
    
    if (string == nil) {
        
        return;
    }
    
    self.lotteryData = string;
    
    NSArray *array = [string componentsSeparatedByString:@"|"];
    
    if (array && [array count]>1) {
        
        self.backgroundImageView.frame = CGRectMake(8, 0, 300, 70);
        
        if (indexRow % 2 == 0) {
            self.backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_1.png"];
        }else{
            self.backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_2.png"];
        }
        
        
        NSString *redString = [array objectAtIndex:0];
        
        NSString *blueString = [array objectAtIndex:1];
        
        NSString *tempString = [NSString stringWithFormat:@"%@|%@",redString,blueString];
        
        NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:tempString];
        
        [mutaString setFont:[UIFont systemFontOfSize:COMMON_FONT_SIZE]];
        
        [mutaString setTextColor:[UIColor darkBlueColor]];
        
        [mutaString setTextColor:[UIColor darkRedColor] range:[tempString rangeOfString:redString]];
        
        self.codeLabel.attributedText = mutaString;
        
        TT_RELEASE_SAFELY(mutaString);
        
        if (self.lotteryNo > 1) {
            
            self.desLabel.text = [NSString stringWithFormat:L(@"LOPluralLottery"),self.lotteryNo];
            
        }else{
            
            self.desLabel.text = [NSString stringWithFormat:L(@"LOSingleLottery"),self.lotteryNo];
            
        }
        
        if ([tempString length] > 42) {
            
            self.codeLabel.frame = CGRectMake(10, 5, 280, 35);
            
            self.desLabel.frame = CGRectMake(10, self.codeLabel.bottom, 280, 25);
            
        }else{
            
            self.codeLabel.frame = CGRectMake(10, 10, 280, 25);
            
            self.desLabel.frame = CGRectMake(10, self.codeLabel.bottom, 280, 25);
        }
    }
    [self separatorLineImageView];
}

#pragma mark - UIView

- (OHAttributedLabel *)codeLabel
{
    if (!_codeLabel)
    {
        _codeLabel = [[OHAttributedLabel alloc] init];
        
        _codeLabel.backgroundColor = [UIColor clearColor];
        
        _codeLabel.numberOfLines = 0;
        
        _codeLabel.textAlignment = (UITextAlignmentCenter+1) % 4;
        
        [self.contentView addSubview:_codeLabel];
        
    }
    
    return _codeLabel;
}

-(UIImageView *)separatorLineImageView{
    
    if (_separatorLineImageView == nil) {
        
        _separatorLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 69, 320, 1)];
        
        UIImage *image = [UIImage imageNamed:@"category_cellSeparatorLine.png"];
        
        _separatorLineImageView.image = image;
        
        [self.contentView addSubview:_separatorLineImageView];
    }
    
    return _separatorLineImageView;
}


-(UIImageView *)backgroundImageView{
    
    if (_backgroundImageView == nil) {
        
        _backgroundImageView = [[UIImageView alloc]init];
        
       // [self.contentView addSubview:_backgroundImageView];
    }
    
    return _backgroundImageView;
}

-(UILabel *)desLabel{
    
    if (_desLabel == nil) {
        
        _desLabel = [[UILabel alloc]init];
        
        _desLabel.backgroundColor = [UIColor clearColor];
        
        _desLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE];
        
        _desLabel.textColor =  RGBCOLOR(51.0, 0, 0);
        
        [self.contentView addSubview:_desLabel];
        
    }
    return _desLabel;
}

-(CGFloat)width:(NSString *)string{
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:COMMON_FONT_SIZE] constrainedToSize:CGSizeMake(315, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    return size.width;
}

@end
