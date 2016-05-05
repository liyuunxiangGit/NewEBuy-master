//
//  SevenLeBottomView.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenLeBottomView.h"
#import "NSAttributedString+Attributes.h"
#import "ComputeLotteryNumber.h"
#import "UIColor+Helper.h"
#import "SubmitLotteryDto.h"

@implementation SevenLeBottomView
@synthesize garbageButton = _garbageButton;
@synthesize selectedNumsLabel = _selectedNumsLabel;
@synthesize priceLabel = _priceLabel;
@synthesize doneButton = _doneButton;
@synthesize bottomDelegate = _bottomDelegate;
@synthesize backgroundImageView = _backgroundImageView;

- (void)dealloc {
    TT_RELEASE_SAFELY(_garbageButton);
    TT_RELEASE_SAFELY(_selectedNumsLabel);
    TT_RELEASE_SAFELY(_priceLabel);
    TT_RELEASE_SAFELY(_doneButton);
    TT_RELEASE_SAFELY(_backgroundImageView);
}


- (id)init {
    
    self = [super init];
    
    if (self) {
        
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.garbageButton.frame = CGRectMake(10, 6, 45, 30);
    
    self.selectedNumsLabel.frame = CGRectMake(self.garbageButton.right+10, 5, 200 - 5, 20);
    
    self.priceLabel.frame = CGRectMake(self.selectedNumsLabel.left, self.selectedNumsLabel.bottom-5, self.selectedNumsLabel.width, self.selectedNumsLabel.height);
    
    self.doneButton.frame = CGRectMake(self.selectedNumsLabel.right + 5, 6, 45, 30);
    
}

/*
 Notes：
 设置选择出的结果
 无选中状态下显示摇一摇
 选中状态下显示选中的数字序列
 */
-(void)setResultChoice:(NSMutableArray *)ballArr  multiNo:(int)mutiNo periods:(int)periods
{
    
    
    NSMutableAttributedString *shakingStr = [[NSMutableAttributedString alloc] initWithString:L(@"Shake machine selection Note")];
    
    [shakingStr setFont:[UIFont systemFontOfSize:12]];
    
    [shakingStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:CTLineBreakModeFromUILineBreakMode(UILineBreakModeCharacterWrap)];
    
    [shakingStr setTextColor:[UIColor darkRedColor]];
    
    
    if ((!ballArr ||[ballArr count]==0))
    {
        [self.selectedNumsLabel resetAttributedText];
        
        [self.selectedNumsLabel setAttributedText:shakingStr];
        
        resultStr_ = @"";
        
        self.priceLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula"),mutiNo,periods];
        
    }
    else{
        
        NSMutableString *resultString = [[NSMutableString alloc] init];
        
        for (NSNumber *value in ballArr)
        {
            
            if ([value intValue]+1<10)
            {
                
                [resultString appendString:[NSString stringWithFormat:@"0%d ",[value intValue] + 1]];
                
            }else
            {
                
                [resultString appendString:[NSString stringWithFormat:@"%d ",[value intValue] + 1]];
            }
            
            
        }
        resultStr_ = [resultString copy];
        
        NSInteger resultCount = 0;
        
        resultCount = [self getReseultCout:resultString];
        
        TT_RELEASE_SAFELY(resultString);
        
        if (resultCount == 0) {
            
            [self.selectedNumsLabel resetAttributedText];
            
            [self.selectedNumsLabel setAttributedText:shakingStr];
            
            self.priceLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula1"),mutiNo,periods];
            
            
        }else{
            
            self.priceLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula2"),resultCount,mutiNo,periods,2*resultCount*mutiNo*periods ];
        }
        
    }
    
    TT_RELEASE_SAFELY(shakingStr);
    
    
    
    [self setNeedsLayout];
    
}



- (NSInteger)getReseultCout:(NSString *)resultString
{
    
    CGFloat lotteryCount = 0;
    
    lotteryCount = [ComputeLotteryNumber computeSevenLeNumber:resultString];
    
    return lotteryCount;
    
}


- (void)deleteAll:(id)sender{
    
    if ([self.bottomDelegate conformsToProtocol:@protocol(SevenLeBottomViewDelegate) ]) {
        
        if ([self.bottomDelegate respondsToSelector:@selector(reChoose)] ) {
            
            [self.bottomDelegate reChoose];
            
        }
    }
    
}

- (void)submit:(id)sender{
    
    if ([self.bottomDelegate conformsToProtocol:@protocol(SevenLeBottomViewDelegate) ]) {
        
        if ([self.bottomDelegate respondsToSelector:@selector(submit:)] ) {
            
            [self.bottomDelegate submit:resultStr_];
            
        }
    }
}

#pragma mark -
#pragma mark Customize UI Methods


-(UIImageView *)backgroundImageView{
    
    if (_backgroundImageView == nil) {
        
        _backgroundImageView = [[UIImageView alloc]init];
        
        self.backgroundImageView.frame = CGRectMake(0,0,320,self.height);
        
        //if (IOS7_OR_LATER)
        {
            _backgroundImageView.backgroundColor = [UIColor uiviewBackGroundColor];
        }
//        else
//        {
//            UIImage *image = [[UIImage imageNamed:@"ball_select_bottom.png"]stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//            
//            _backgroundImageView.image = image;
//            
//            
//            
//            _backgroundImageView.backgroundColor = [UIColor clearColor];
//        }
        _backgroundImageView.userInteractionEnabled = YES;
        [self addSubview:_backgroundImageView];
        
    }
    
    return _backgroundImageView;
    
}
- (UIButton *)garbageButton{
    
    if (!_garbageButton) {
        
        _garbageButton = [[UIButton alloc] init];
        
        [_garbageButton addTarget:self action:@selector(deleteAll:) forControlEvents:UIControlEventTouchUpInside];
        //if (IOS7_OR_LATER)
        {
            _garbageButton.backgroundColor = [UIColor whiteColor];
        }
//        else
//        {
//            [_garbageButton setBackgroundImage:[UIImage imageNamed:@"clean.png"] forState:UIControlStateNormal];
//            _garbageButton.backgroundColor = [UIColor clearColor];
//        }
        
        
        [_garbageButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_garbageButton setTitleColor:[UIColor darkGrownColor] forState:UIControlStateNormal];
        
        [_garbageButton setTitle:L(@"Clear") forState:UIControlStateNormal];
        [self.backgroundImageView addSubview:_garbageButton];
        
    }
    return _garbageButton;
    
}

-(OHAttributedLabel *)selectedNumsLabel{
    
    if (_selectedNumsLabel == nil) {
        
        _selectedNumsLabel = [[OHAttributedLabel alloc]init];
        
        _selectedNumsLabel.backgroundColor = [UIColor clearColor];
        
        _selectedNumsLabel.delegate = self;
        
        [self.backgroundImageView addSubview:_selectedNumsLabel];
    }
    
    return _selectedNumsLabel;
}


- (OHAttributedLabel *)priceLabel{
    
    if (_priceLabel == nil) {
        
        _priceLabel = [[OHAttributedLabel alloc]init];
        
        _priceLabel.backgroundColor = [UIColor clearColor];
        
        [_priceLabel setFont:[UIFont boldSystemFontOfSize:12] ] ;
        
        [_priceLabel setTextAlignment:UITextAlignmentCenter];
        
        _priceLabel.textColor = RGBCOLOR(102.0, 51.0, 51.0);
        
        _priceLabel.delegate = self;
        
        [self.backgroundImageView addSubview:_priceLabel];
        
    }
    
    return _priceLabel;
    
}

- (UIButton *)doneButton{
    
    if (!_doneButton) {
        
        _doneButton = [[UIButton alloc] init];
        
        [_doneButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [_doneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_doneButton setTitle:L(@"Ok") forState:UIControlStateNormal];
        //if (IOS7_OR_LATER)
        {
            _doneButton.backgroundColor = [UIColor colorWithRGBHex:0xfc7c26];
        }
//        else
//        {
//            _doneButton.backgroundColor = [UIColor clearColor];
//            [_doneButton setBackgroundImage:[UIImage imageNamed:@"commit.png"] forState:UIControlStateNormal];
//        }
        
        
        [self.backgroundImageView addSubview:_doneButton];
        
    }
    
    return _doneButton;
    
}




@end
