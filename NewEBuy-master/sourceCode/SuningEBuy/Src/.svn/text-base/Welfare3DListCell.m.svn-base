//
//  Welfare3DListCell.m
//  SuningLottery
//
//  Created by jian  zhang on 12-9-26.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "Welfare3DListCell.h"
#import "BallSelectConstant.h"

@implementation Welfare3DListCell


#define COMMON_FONT_SIZE 14.0



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
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)setItem:(NSString *)string indexRow:(int)indexRow{
    
    if (string == nil) {
        
        return;
    }
    
    self.lotteryData = [string substringWithRange:NSMakeRange(0, [string length] - 3)];
    
    if (_lotteryData.trim.length == 0) {
        return;
    }
    self.backgroundImageView.frame = CGRectMake(0, 0, 320, 70);
    
//    if (indexRow % 2 == 0) {
//        
//        self.backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_1.png"];            
//    }else{
//        self.backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_2.png"];            
//    }

    NSString *tempString;
    
    if ([self.lotteryData rangeOfString:@"|"].length > 0) {
        
        tempString = [self.lotteryData stringByReplacingOccurrencesOfString:@" " withString:@""];   
    
        tempString = [tempString stringByReplacingOccurrencesOfString:@"|" withString:@" | "];
    }
    else{
        
        tempString = [self.lotteryData stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
      
//        tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@" | "];
    }
    NSString *ballTypeString = @"";
    
    int ballType = [[string substringWithRange:NSMakeRange([string length] - 3,3)] intValue];
    
    
    switch (ballType) {
        case zhiXuan:
            ballTypeString = L(@"DirectElection");
            break;
        case zuSan:
            ballTypeString = L(@"GroupsOfThree");
            break;
        case zuLiu:
            ballTypeString = L(@"GroupOfSix");
            break;
        case zhiXuanHeZhi:
            ballTypeString = L(@"Direct value");
            break;
        case zuSanHeZhi:
            ballTypeString = L(@"Groups of three and values");
            break;
        case zuLiuHeZhi:
            ballTypeString = L(@"Group six and values");
            break;
            
        default:
            break;
    }
    
    self.codeLabel.text = tempString;//@"%@: %@",L(@"Stop betting"),endTime
    
    if (self.lotteryNo > 1) {
        
        self.desLabel.text = [NSString stringWithFormat:@"%@%@  %0.f%@",ballTypeString,L(@"Duplex"),self.lotteryNo,L(@"Note")];
        
    }else{
        
        self.desLabel.text = [NSString stringWithFormat:@"%@%@  %0.f%@",ballTypeString,L(@"Single entry"),self.lotteryNo,L(@"Note")];
        
    }
    
    if ([tempString length] > 30) {
        
        self.codeLabel.frame = CGRectMake(10, 5, 280, 40);
        
        self.desLabel.frame = CGRectMake(10, self.codeLabel.bottom, 280, 25);
        
    }else{
        
        self.codeLabel.frame = CGRectMake(10, 10, 280, 25);
        
        self.desLabel.frame = CGRectMake(10, self.codeLabel.bottom, 280, 25);
    }
    
    [self separatorLineImageView];
}

#pragma mark - UIView

- (UILabel *)codeLabel
{
    if (!_codeLabel)
    {
        _codeLabel = [[UILabel alloc] init];
        
        _codeLabel.backgroundColor = [UIColor clearColor];
        
        _codeLabel.numberOfLines = 0;
        
        _codeLabel.textColor = [UIColor darkRedColor];
        
        _codeLabel.textAlignment = UITextAlignmentLeft;
        
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
        
        [self.contentView addSubview:_backgroundImageView];
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

