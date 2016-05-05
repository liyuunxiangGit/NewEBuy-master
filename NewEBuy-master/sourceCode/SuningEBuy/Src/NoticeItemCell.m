//
//  NoticeItemCell.m
//  SuningEBuy
//
//  Created by david david on 12-6-28.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "NoticeItemCell.h"
#import "NSAttributedString+Attributes.h"

#define COMMON_FONT_SIZE 13.0
#define LABLENGTH        126.0

@implementation NoticeItemCell

@synthesize backgroundImageView = _backgroundImageView;
@synthesize lotteryImageView = _lotteryImageView;
@synthesize shadowImageView = _shadowImageView;
@synthesize lotteryNameLbl = _lotteryNameLbl;
@synthesize desLbl = _desLbl;
@synthesize redLbl = _redLbl;
@synthesize blueLbl = _blueLbl;
@synthesize hallDto = _hallDto;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_lotteryImageView);
    TT_RELEASE_SAFELY(_shadowImageView);
    TT_RELEASE_SAFELY(_lotteryNameLbl);
    TT_RELEASE_SAFELY(_desLbl);
    TT_RELEASE_SAFELY(_redLbl);
    TT_RELEASE_SAFELY(_blueLbl);
    TT_RELEASE_SAFELY(_hallDto);
    TT_RELEASE_SAFELY(_goHistoryCodeImageView);
}

-(void)setItem:(LotteryHallDto *)dto{
    
    if (!dto) {
        
        return;
    }
    
    self.hallDto = dto;
    
    self.backgroundImageView.frame = CGRectMake(10, 7, 300, 75);
    self.lotteryImageView.frame = CGRectMake(20, 25, 40, 40);
    self.shadowImageView.frame = CGRectMake(20, 65, 40, 5);
    self.lotteryNameLbl.frame = CGRectMake(self.lotteryImageView.right+10, 33, 60, 30);
    self.desLbl.frame = CGRectMake(self.lotteryNameLbl.right+12, 28, 175, 20);
    self.goHistoryCodeImageView.frame = CGRectMake(280, 42, 8, 8);
    
    
    if ([self isNullOrEmpty:self.hallDto.gid]) {
        
        NSString *imageName = [NSString stringWithFormat:@"caipiao_%@",self.hallDto.gid];
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        self.lotteryImageView.image = image;
    }
    
    if ([self isNullOrEmpty:self.hallDto.gname]) {
        
        self.lotteryNameLbl.text = self.hallDto.gname;
        
    }else{
        
        self.lotteryNameLbl.text = @"";
        
    }
    
    if ([self isNullOrEmpty:self.hallDto.pid]) {
        
        NSString *tempString = [NSString stringWithFormat:@"%@%@%@",L(@"No."),self.hallDto.pid,L(@"No. announcement number")];
        
        NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:tempString];
        
        [mutaString setFont:[UIFont systemFontOfSize:COMMON_FONT_SIZE]];
        
        [mutaString setTextColor:[UIColor blackColor]];
        
        [mutaString setTextColor:[UIColor darkRedColor] range:[tempString rangeOfString:self.hallDto.pid]];
        
        self.desLbl.attributedText = mutaString;
        
        
    }else{
        
        self.desLbl.text = @"";
    }
    
    if ([self isNullOrEmpty:self.hallDto.code]) {
        
        NSArray *array = [self.hallDto.code componentsSeparatedByString:@"|"];
        
        if ([array count] > 1) {
            
            NSString *redString = [array objectAtIndex:0];
            
            redString = [redString stringByReplacingOccurrencesOfString:@"," withString:@" "];
            
            self.redLbl.text = redString;
            
            CGFloat redLblWidth = [self width:redString];
            
            NSString *blueString = [array objectAtIndex:1];
            
            blueString = [blueString stringByReplacingOccurrencesOfString:@"," withString:@" "];
            
            self.blueLbl.text = blueString;
            
            CGFloat blueLblWidth = [self width:blueString];
            
            self.redLbl.frame = CGRectMake(self.lotteryNameLbl.right+10+(LABLENGTH-redLblWidth-blueLblWidth)/2, self.desLbl.bottom, redLblWidth, 20);
            
            self.blueLbl.frame = CGRectMake(self.redLbl.right+10, self.desLbl.bottom, 50, 20);
            
        }else{
            
            NSString *redString = self.hallDto.code;
            
            redString = [redString stringByReplacingOccurrencesOfString:@"," withString:@"  "];
            
            self.redLbl.text = redString;
            
            //CGFloat redLblWidth = [self width:redString];
            
            self.redLbl.frame = CGRectMake(143, self.desLbl.bottom, 128, 20);
            
            self.blueLbl.text = @"";
            
        }
    }
    
    
    
}


#pragma mark - UIView

-(UIImageView *)backgroundImageView{
    
    if (_backgroundImageView == nil) {
        
        _backgroundImageView = [[UIImageView alloc]init];
        
        UIImage *image = nil;
        
        image = [UIImage imageNamed:@"lottery_hall_backgroundNew.png"];
        image =[image stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        CGRect rect = _backgroundImageView.frame;
        rect.size.height = 50;
        _backgroundImageView.frame = rect;
        
        _backgroundImageView.image = image;
        
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_backgroundImageView];
        
    }
    
    return _backgroundImageView;
    
}


-(UIImageView *)lotteryImageView{
    
    if (_lotteryImageView == nil) {
        
        _lotteryImageView = [[UIImageView alloc]init];
        
        _lotteryImageView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_lotteryImageView];
        
    }
    
    return _lotteryImageView;
    
}

-(UIImageView *)shadowImageView{
    
    if (_shadowImageView == nil) {
        
        _shadowImageView = [[UIImageView alloc]init];
        
        _shadowImageView.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [UIImage imageNamed:@"shadow_image.png"];
        
        _shadowImageView.image = image;
        
        [self.contentView addSubview:_shadowImageView];
        
    }
    
    return _shadowImageView;
    
}

-(UILabel *)lotteryNameLbl{
    
    if (_lotteryNameLbl == nil) {
        
        _lotteryNameLbl = [[UILabel alloc]init];
        
        _lotteryNameLbl.backgroundColor = [UIColor clearColor];
        
        _lotteryNameLbl.font = [UIFont boldSystemFontOfSize:18.0];
        
        _lotteryNameLbl.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_lotteryNameLbl];
        
    }
    
    return _lotteryNameLbl;
}

-(OHAttributedLabel *)desLbl{
    
    if (_desLbl == nil) {
        
        _desLbl = [[OHAttributedLabel alloc]init];
        
        _desLbl.backgroundColor = [UIColor clearColor];
        
        _desLbl.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE];
        
        _desLbl.textColor = RGBCOLOR(51.0, 0, 0);
        
        [self.contentView addSubview:_desLbl];
        
    }
    
    return _desLbl;
}


-(UILabel *)redLbl{
    
    if (_redLbl == nil) {
        
        _redLbl = [[UILabel alloc]init];
        
        _redLbl.backgroundColor = [UIColor clearColor];
        
        _redLbl.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE];
        
        _redLbl.textAlignment = UITextAlignmentCenter;
        
        _redLbl.textColor = [UIColor darkRedColor];
        
        [self.contentView addSubview:_redLbl];
        
    }
    
    return _redLbl;
}


-(UILabel *)blueLbl{
    
    if (_blueLbl == nil) {
        
        _blueLbl = [[UILabel alloc]init];
        
        _blueLbl.backgroundColor = [UIColor clearColor];
        
        _blueLbl.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE];
        
        _blueLbl.textColor = [UIColor darkBlueColor];
        
        [self.contentView addSubview:_blueLbl];
        
    }
    
    return _blueLbl;
}

-(UIImageView*)goHistoryCodeImageView
{
    if (!_goHistoryCodeImageView)
    {
        _goHistoryCodeImageView = [[UIImageView alloc]init];
        
        _goHistoryCodeImageView.image = [UIImage imageNamed:@"notice_go.png"];
        
        [self.contentView addSubview:_goHistoryCodeImageView];
    }
    
    return _goHistoryCodeImageView;
}





/*
 * YES:不为空
 * NO:为空或者为nil
 */
-(BOOL)isNullOrEmpty:(NSString *)string{
    
    if (!string) {
        
        return NO;
        
    }else if([string isEqualToString:@""]){
        
        return NO;
    }
    
    return YES;
    
}

-(CGFloat)width:(NSString *)string{
    
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:COMMON_FONT_SIZE] constrainedToSize:CGSizeMake(315, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    return size.width;
}

@end


