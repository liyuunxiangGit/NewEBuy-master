//
//  LotteryItemCell.m
//  SuningEBuy
//
//  Created by david david on 12-6-27.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LotteryItemCell.h"
#import "NSAttributedString+Attributes.h"

#define COMMON_FONT_SIZE 12.0

@implementation LotteryItemCell

@synthesize backgroundImageView = _backgroundImageView;
@synthesize lotteryImageView = _lotteryImageView;
@synthesize lotteryNameLbl = _lotteryNameLbl;
@synthesize poolkeyLbl = _poolkeyLbl;
@synthesize poolValueLbl = _poolValueLbl;
@synthesize timesLbl = _timesLbl;
@synthesize timeLbl = _timeLbl;
@synthesize hallDto = _hallDto;
@synthesize backgroundtopImageView =_backgroundtopImageView;
@synthesize shadowbackgroundImageView = _shadowbackgroundImageView;
@synthesize lotteryRewardLbl = _lotteryRewardLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_lotteryImageView);
    TT_RELEASE_SAFELY(_lotteryNameLbl);
    TT_RELEASE_SAFELY(_poolkeyLbl);
    TT_RELEASE_SAFELY(_poolValueLbl);
    TT_RELEASE_SAFELY(_timesLbl);
    TT_RELEASE_SAFELY(_timeLbl);
    TT_RELEASE_SAFELY(_hallDto);
    TT_RELEASE_SAFELY(_shadowbackgroundImageView);
    TT_RELEASE_SAFELY(_lotteryRewardLbl);
    TT_RELEASE_SAFELY(_backgroundtopImageView);
}

-(void)setItem:(LotteryHallDto *)dto{
    
    if (!dto) {
        
        return;
    }
    
    self.hallDto = dto;
    
    self.backgroundImageView.frame = CGRectMake(10, 10, 300, 88);
    self.lotteryImageView.frame = CGRectMake(20, 35, 45, 45);
    self.shadowbackgroundImageView.frame = CGRectMake(20, 79, 45, 5);
    self.lotteryNameLbl.frame = CGRectMake(self.lotteryImageView.right+10, 25, 60, 30);
    self.poolkeyLbl.frame = CGRectMake(self.lotteryNameLbl.right+5, 25, 60, 30);
    
    if ([self.hallDto.gid isEqualToString:@"01"] ||[self.hallDto.gid isEqualToString:@"50" ]||[self.hallDto.gid isEqualToString:@"51" ]) {
        
        self.timesLbl.frame = CGRectMake(self.lotteryImageView.right+10, self.lotteryNameLbl.bottom+13, 75, 30);
        if (([dto.isale integerValue] == 0) || ([dto.isale integerValue] == 2))
        {
            self.timeLbl.frame = CGRectMake(self.timesLbl.right+5, self.lotteryNameLbl.bottom+15, 150 + 10, 30);
        }else{
            //            if (IOS7_OR_LATER)
            //            {
            self.timeLbl.frame = CGRectMake(self.timesLbl.right+1, self.lotteryNameLbl.bottom+13+1, 150+10, 30);
            //            }
            //            else
            //            self.timeLbl.frame = CGRectMake(self.timesLbl.right+5, self.lotteryNameLbl.bottom+13+1, 150 + 10, 30);
        }
        
    }else{
        
        self.timesLbl.frame = CGRectMake(self.lotteryNameLbl.right+10, self.lotteryNameLbl.top+8, 100, 30);
        self.timeLbl.frame = CGRectMake(self.lotteryNameLbl.left, self.lotteryNameLbl.bottom+8, 150 + 10, 30);
    }
    
    if ([self.hallDto.gid isEqualToString:@"01"] || [self.hallDto.gid isEqualToString:@"50"]||[self.hallDto.gid isEqualToString:@"51" ]) {
        
        self.backgroundtopImageView.frame = CGRectMake(140, 8, 160, 50);
        self.poolValueLbl.frame = CGRectMake(178, 20, 140, 30);
        self.lotteryRewardLbl.frame = CGRectMake(145, 26, 40, 20);
    }
    
    
    if ([self isNullOrEmpty:self.hallDto.gid]) {
        
        NSString *imageName = [NSString stringWithFormat:@"caipiao_%@",self.hallDto.gid];
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        self.lotteryImageView.image = image;
    }else{
        [self.lotteryImageView removeFromSuperview];
    }
    
    if ([self isNullOrEmpty:self.hallDto.gname]) {
        
        self.lotteryNameLbl.text = self.hallDto.gname;
        
    }else{
        [self.lotteryNameLbl removeFromSuperview];
    }
    
    if ([self isNullOrEmpty:self.hallDto.pools]) {
        
        self.poolValueLbl.text = [self addCommaToPoolValue:self.hallDto.pools] ;
        
    }else{
        
        self.poolValueLbl.text = L(@"No prize pool information");
    }
    
    if ([self isNullOrEmpty:self.hallDto.nowpid]) {
        
        
        NSString *tempString = [NSString stringWithFormat:L(@"%@ issue"),self.hallDto.nowpid];
        NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:tempString];
        
        [mutaString setTextColor:[UIColor blackColor]];
        //        if (!IOS7_OR_LATER)
        //          [mutaString setTextColor:[UIColor darkRedColor] range:[tempString rangeOfString:self.hallDto.nowpid]];
        //        else
        [mutaString setTextColor:[UIColor orange_Light_Color] range:[tempString rangeOfString:self.hallDto.nowpid]];
        self.timesLbl.attributedText = mutaString;
        
    }
    
    if ([self isNullOrEmpty:self.hallDto.nowendtime]) {
        
        NSString *endTime = self.hallDto.nowendtime;
        
        endTime = [endTime substringToIndex:16];
        if (([dto.isale integerValue] == 0) || ([dto.isale integerValue] == 2))
        {
            self.timeLbl.text = L(@"LOSuspentSale");
        }else{
            NSString* str = L(@"Stop betting");
            //            if (IOS7_OR_LATER)
            //            {
            str = L(@"LOStopBetting");
            //            }
            self.timeLbl.text = [NSString stringWithFormat:@"%@: %@",str,endTime];
        }
    }
    
}


#pragma mark - UIView

-(UIImageView *)backgroundImageView{
    
    if (_backgroundImageView == nil) {
        
        _backgroundImageView = [[UIImageView alloc]init];
        UIImage *image = nil;
        //        if (!IOS7_OR_LATER)
        //        {
        //            image = [UIImage imageNamed:@"lottery_hall_background.png"];
        //
        //        }
        //        else
        //        {
        image = [UIImage imageNamed:@"lottery_hall_backgroundNew.png"];
        image =[image stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        CGRect rect = _backgroundImageView.frame;
        rect.size.height = 50;
        _backgroundImageView.frame = rect;
        //        }
        _backgroundImageView.image = image;
        [self.contentView addSubview:_backgroundImageView];
        
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _backgroundImageView;
    
}
-(UIImageView *)backgroundtopImageView{
    
    if (_backgroundtopImageView == nil) {
        
        _backgroundtopImageView = [[UIImageView alloc]init];
        
        UIImage *image = nil;
        //        if (!IOS7_OR_LATER)
        //        {
        //            image = [UIImage imageNamed:@"back_image.png"];
        //        }
        //        else
        //        {
        image = [UIImage imageNamed:@"back_imageNew.png"];
        image =[image stretchableImageWithLeftCapWidth:10 topCapHeight:12];
        //        }
        _backgroundtopImageView.image = image;
        
        [self.contentView addSubview:_backgroundtopImageView];
        
        _backgroundtopImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _backgroundtopImageView;
    
}

-(UIImageView *)shadowbackgroundImageView{
    
    if (_shadowbackgroundImageView == nil) {
        
        _shadowbackgroundImageView = [[UIImageView alloc]init];
        
        UIImage *image = [UIImage imageNamed:@"shadow_image.png"];
        
        _shadowbackgroundImageView.image = image;
        
        [self.contentView addSubview:_shadowbackgroundImageView];
        
        _shadowbackgroundImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _shadowbackgroundImageView;
    
}


-(UIImageView *)lotteryImageView{
    
    if (_lotteryImageView == nil) {
        
        _lotteryImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_lotteryImageView];
        
        _lotteryImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _lotteryImageView;
    
}

-(UILabel *)lotteryNameLbl{
    
    if (_lotteryNameLbl == nil) {
        
        _lotteryNameLbl = [[UILabel alloc]init];
        
        _lotteryNameLbl.backgroundColor = [UIColor clearColor];
        
        _lotteryNameLbl.font = [UIFont boldSystemFontOfSize:17.0];
        
        _lotteryNameLbl.text = @"";
        
        _lotteryNameLbl.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_lotteryNameLbl];
        
    }
    
    return _lotteryNameLbl;
}

-(UILabel *)lotteryRewardLbl{
    
    if (_lotteryRewardLbl == nil) {
        
        _lotteryRewardLbl = [[UILabel alloc]init];
        
        _lotteryRewardLbl.backgroundColor = [UIColor clearColor];
        
        _lotteryRewardLbl.font = [UIFont boldSystemFontOfSize:12.0];
        
        _lotteryRewardLbl.text = L(@"Bonus:");
        
        _lotteryRewardLbl.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_lotteryRewardLbl];
        
    }
    
    return _lotteryRewardLbl;
}


-(UILabel *)poolkeyLbl{
    
    if (_poolkeyLbl == nil) {
        
        _poolkeyLbl = [[UILabel alloc]init];
        
        _poolkeyLbl.backgroundColor = [UIColor clearColor];
        
        _poolkeyLbl.font = [UIFont boldSystemFontOfSize:COMMON_FONT_SIZE];
        
        _poolkeyLbl.textColor = RGBCOLOR(51.0, 51.0, 51.0);
        
        [self.contentView addSubview:_poolkeyLbl];
    }
    
    return _poolkeyLbl;
}


-(UILabel *)poolValueLbl{
    
    if (_poolValueLbl == nil) {
        
        _poolValueLbl = [[UILabel alloc]init];
        
        _poolValueLbl.backgroundColor = [UIColor clearColor];
        
        _poolValueLbl.font = [UIFont systemFontOfSize:19.0];
        
        _poolValueLbl.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_poolValueLbl];
    }
    
    return _poolValueLbl;
}

-(OHAttributedLabel *)timesLbl{
    
    if (_timesLbl == nil) {
        
        _timesLbl = [[OHAttributedLabel alloc]init];
        
        _timesLbl.backgroundColor = [UIColor clearColor];
        
        _timesLbl.font = [UIFont systemFontOfSize:11.0];
        
        [self.contentView addSubview:_timesLbl];
    }
    
    return _timesLbl;
}


-(UILabel *)timeLbl{
    
    if (_timeLbl == nil) {
        
        _timeLbl = [[OHAttributedLabel alloc]init];
        
        _timeLbl.backgroundColor = [UIColor clearColor];
        
        _timeLbl.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE];
        
        _timeLbl.text = L(@"2012-06-06 19:28 stop betting");
        
        [self.contentView addSubview:_timeLbl];
    }
    
    return _timeLbl;
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

-(NSString *)addCommaToPoolValue:(NSString *)string{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    int length = [string length];
    
    NSString *tempString = nil;
    
    NSString *returnStr = nil;
    
    for (int i = length - 1 ;i >= 0 ; i--) {
        
        tempString = [string substringWithRange:NSMakeRange( i, 1)] ;
        
        if ([returnStr length] == 0) {
            
            returnStr = tempString;
            
        }else{
            
            returnStr = [tempString stringByAppendingFormat:@"%@",returnStr];
        }
        
        if ([returnStr length] == 3 || i == 0) {
            
            [array addObject:returnStr];
            
            returnStr = nil;
            
        }
    }
    
    tempString = @"";
    
    for (NSString *str in array) {
        
        if ([tempString isEqualToString:@""]) {
            
            tempString = str;
            
        }else{
            
            tempString = [NSString stringWithFormat:@"%@,%@",str,tempString];
        }
    }
    
    tempString = [NSString stringWithFormat:@"¥%@",tempString];
    
    TT_RELEASE_SAFELY(array);
    
    return tempString;
}

@end
