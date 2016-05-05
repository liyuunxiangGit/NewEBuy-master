//
//  ChooseSevenLeListCell.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-9.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "ChooseSevenLeListCell.h"
#import "NSAttributedString+Attributes.h"


#define COMMON_FONT_SIZE 14.0

@implementation ChooseSevenLeListCell


@synthesize separatorLineImageView = _separatorLineImageView;
@synthesize codeLabel  = _codeLabel;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize isBottomItem = _isBottomItem;
@synthesize desLabel = _desLabel;
@synthesize lotteryNo = _lotteryNo;

- (void)dealloc {
    
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
    
        self.backgroundImageView.frame = CGRectMake(8, 0, 300, 70);
        //if (IOS7_OR_LATER)
        //{
            self.backgroundImageView.backgroundColor = [UIColor whiteColor];
            
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 69, 320, 1)];
            v.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
            [self addSubview:v];
            
        //}
//        else
//        {
////            if (indexRow % 2 == 0) {
////                self.backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_1.png"];
////            }else{
////                self.backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_2.png"];
////            }
//        }
    
        
        NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:string];
        
        [mutaString setFont:[UIFont systemFontOfSize:COMMON_FONT_SIZE]];
        
        [mutaString setTextColor:[UIColor darkRedColor]];
    
        self.codeLabel.attributedText = mutaString;
        
        TT_RELEASE_SAFELY(mutaString);
        
        if (self.lotteryNo > 1) {
            
            self.desLabel.text = [NSString stringWithFormat:L(@"LOPluralLottery"),self.lotteryNo];
            
        }else{
            
            self.desLabel.text = [NSString stringWithFormat:L(@"LOSingleLottery"),self.lotteryNo];
            
        }
        
        if ([string length] > 42) {
            
            self.codeLabel.frame = CGRectMake(10, 5, 280, 35);
            
            self.desLabel.frame = CGRectMake(10, self.codeLabel.bottom, 280, 25);
            
        }else{
            
            self.codeLabel.frame = CGRectMake(10, 10, 280, 25);
            
            self.desLabel.frame = CGRectMake(10, self.codeLabel.bottom, 280, 25);
        }
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
        
        _separatorLineImageView = [[UIImageView alloc]init];
        
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
