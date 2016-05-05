//
//  SevenStarsListCell.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-8.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenStarsListCell.h"

@implementation SevenStarsListCell


@synthesize multipleTimes;

@synthesize separatorLineImageView = _separatorLineImageView;

@synthesize codeLabel = _codeLabel;

@synthesize backgroundImageView = _backgroundImageView;

@synthesize desLabel = _desLabel;

@synthesize lotteryNumber;//注数


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    return self;
}

-(void)dealloc
{
    
    TT_RELEASE_SAFELY(_separatorLineImageView);
    TT_RELEASE_SAFELY(_codeLabel);
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_desLabel);
    
}

-(void)setItem:(NSString *)string indexRow:(int)indexRow
{
    if (string == nil) {
        
        return;
    }

    self.backgroundImageView.frame = CGRectMake(0, 0, 320, 70);
  
    self.backgroundImageView.backgroundColor = [UIColor clearColor];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 69, 320, 1)];
    v.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
    [self.backgroundImageView addSubview:v];
    
//    else
//    {
//        if (indexRow % 2 == 0) {
//            
//            self.backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_1.png"];
//        }else{
//            self.backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_2.png"];
//        }
//    }
        
    self.codeLabel.text = [string stringByReplacingOccurrencesOfString:@"|" withString:@" "];//@"%@: %@",L(@"Stop betting"),endTime
    
    if (self.lotteryNumber > 1) {
        
        self.desLabel.text = [NSString stringWithFormat:@"%@%@ %d%@",L(@"DirectElection"),L(@"Duplex"),self.lotteryNumber,L(@"Note")];
        
    }else{
        
        self.desLabel.text = [NSString stringWithFormat:@"%@%@  %d%@",L(@"DirectElection"),L(@"Single entry"),self.lotteryNumber,L(@"Note")];
        
    }
    
    if ([string length] > 30) {
        
        self.codeLabel.frame = CGRectMake(10, 5, 280, 40);
        
        self.desLabel.frame = CGRectMake(10, self.codeLabel.bottom, 280, 25);
        
    }else{
        
        self.codeLabel.frame = CGRectMake(10, 10, 280, 25);
        
        self.desLabel.frame = CGRectMake(10, self.codeLabel.bottom, 280, 25);
    }
    

}

#pragma mark - views
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
        
        _desLabel.font = [UIFont systemFontOfSize:14];
        
        _desLabel.textColor =  RGBCOLOR(51.0, 0, 0);
        
        [self.contentView addSubview:_desLabel];
        
    }
    return _desLabel;
}


@end
