//
//  LotterySelectBottomView.m
//  SuningEBuy
//
//  Created by shasha on 12-7-1.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import "LotterySelectBottomView.h"
#import "NSAttributedString+Attributes.h"
#import "ComputeLotteryNumber.h"
#import "UIColor+Helper.h"
#import "SubmitLotteryDto.h"

@interface LotterySelectBottomView(){
    
    //注数
    NSInteger   count;
    
    LotteryType  lotteryType_;
    
    NSString     *resultStr_;
    
}

@property (nonatomic, copy) NSString           *resultStr;
@property (nonatomic, strong)UIButton            *garbageButton;
@property (nonatomic, strong)OHAttributedLabel   *selectedNumsLabel;
@property (nonatomic, strong)OHAttributedLabel   *priceLabel;
@property (nonatomic, strong)UIButton            *doneButton;
@property (nonatomic, strong)UIImageView         *backgroundImageView;


- (NSString*)setResultText:(NSMutableArray *)blueArr redArr:(NSMutableArray *)redArr;

- (NSInteger)getReseultCout:(NSString *)resultString;

@end

@implementation LotterySelectBottomView
@synthesize garbageButton = _garbageButton;
@synthesize selectedNumsLabel = _selectedNumsLabel;
@synthesize priceLabel = _priceLabel;
@synthesize doneButton = _doneButton;
@synthesize bottomDelegate = _bottomDelegate;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize ballType = _ballType;
@synthesize resultStr = resultStr_;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_garbageButton);
    TT_RELEASE_SAFELY(_selectedNumsLabel);
    TT_RELEASE_SAFELY(_priceLabel);
    TT_RELEASE_SAFELY(_doneButton);
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(resultStr_);
    
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
-(void)setResultChoice:(NSMutableArray *)blueArr redArr:(NSMutableArray *)redArr LottertType:(LotteryType)lotteryType multiNo:(int)mutiNo periods:(int)periods;
{
    
    self.backgroundImageView.frame = CGRectMake(0,0,320,self.height);
    
    lotteryType_ = lotteryType;
    
    NSMutableAttributedString *shakingStr = [[NSMutableAttributedString alloc] initWithString:L(@"Shake machine selection Note")];
    
    [shakingStr setFont:[UIFont systemFontOfSize:12]];
    
    [shakingStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:CTLineBreakModeFromUILineBreakMode(UILineBreakModeCharacterWrap)];
    
    [shakingStr setTextColor:[UIColor darkRedColor]];
    
    [self.selectedNumsLabel resetAttributedText];
    
    [self.selectedNumsLabel setAttributedText:shakingStr];
    
    
    if ((!blueArr ||[blueArr count]==0)||(!redArr ||[redArr count]==0)) {
        
        
        self.resultStr = @"";
        
        self.priceLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula1"),mutiNo,periods];
        
    }else{
        
        
        self.resultStr =  [self setResultText:blueArr redArr:redArr];
        
        NSInteger resultCount = 0;
        
        resultCount = [self getReseultCout:resultStr_];
        
        if (resultCount == 0) {
            
            
            self.priceLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula1"),mutiNo,periods];
            
            
        }else{
            
            self.priceLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula2"),resultCount,mutiNo,periods,2*resultCount*mutiNo*periods ];
        }
        
    }
    
    TT_RELEASE_SAFELY(shakingStr);
    
    [self setNeedsLayout];
    
}


- (NSString*)setResultText:(NSMutableArray *)blueArr redArr:(NSMutableArray *)redArr
{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    for (NSNumber *value in redArr) {
        
        if ([value intValue]+1<10) {
            
            [resultString appendString:[NSString stringWithFormat:@"0%d ",[value intValue] + 1]];
            
        }else{
            
            [resultString appendString:[NSString stringWithFormat:@"%d ",[value intValue] + 1]];
        }
        
        
    }
    
    NSRange rangRed = [resultString rangeOfString:resultString];
    
    [resultString appendString:@"|"];
    
    NSRange rangCenter = [resultString rangeOfString:@"|"];
    
    for (NSNumber *value in blueArr) {
        
        if ([value intValue]+1<10){
            
            [resultString appendString:[NSString stringWithFormat:@" 0%d",[value intValue]+1]];
            
        }else{
            
            [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue]+1]];
            
        }
        
    }
    
    NSRange blueRange = NSMakeRange(rangCenter.location + rangCenter.length, resultString.length - rangRed.length - rangCenter.length);
    
    DLog(@"resultString is %@", resultString);
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:resultString];
    
    [attriStr setFont:[UIFont systemFontOfSize:12]];
    
    [attriStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByCharWrapping];
    
    [attriStr setTextColor:[UIColor darkRedColor] range:rangRed];
    
    [attriStr setTextColor:[UIColor darkGrayColor] range:rangCenter];
    
    [attriStr setTextColor:[UIColor darkBlueColor] range:blueRange];
    
    NSString * str = [resultString copy];
    
    TT_RELEASE_SAFELY(attriStr);
    TT_RELEASE_SAFELY(resultString);
    
    return str ;
    
}

- (NSInteger)getReseultCout:(NSString *)resultString  {
    
    CGFloat lotteryCount = 0;
    
    switch (self.ballType) {
            
        case eColorBall:{
            
            lotteryCount = [ComputeLotteryNumber computeLotterySSQNumber:resultString];
            
        }
            
            break;
            
        case eBigLottery:{
            
            lotteryCount = [ComputeLotteryNumber computeLotteryDLTNumber:resultString];
        }
            break;
            
        default:
            break;
    }
    
    
    return lotteryCount;
    
}


- (void)deleteAll:(id)sender{
    
    if ([self.bottomDelegate conformsToProtocol:@protocol(LotterySelectBottomViewDelegate) ]) {
        
        if ([self.bottomDelegate respondsToSelector:@selector(reChoose)] ) {
            
            [self.bottomDelegate reChoose];
            
        }
    }
    
}

- (void)submit:(id)sender{
    
    if ([self.bottomDelegate conformsToProtocol:@protocol(LotterySelectBottomViewDelegate) ]) {
        
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
        
//        UIImage *image = [[UIImage imageNamed:@"ball_select_bottom.png"]stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//        
//        _backgroundImageView.image = image;
        
        _backgroundImageView.userInteractionEnabled = YES;
        
        _backgroundImageView.backgroundColor = [UIColor uiviewBackGroundColor];
        
        [self addSubview:_backgroundImageView];
        
    }
    
    return _backgroundImageView;
    
}
- (UIButton *)garbageButton{
    
    if (!_garbageButton) {
        
        _garbageButton = [[UIButton alloc] init];
        
        [_garbageButton addTarget:self action:@selector(deleteAll:) forControlEvents:UIControlEventTouchUpInside];
        
//        [_garbageButton setBackgroundImage:[UIImage imageNamed:@"clean.png"] forState:UIControlStateNormal];
        
        [_garbageButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_garbageButton setTitleColor:[UIColor darkGrownColor] forState:UIControlStateNormal];
        _garbageButton.backgroundColor = [UIColor whiteColor];
        [_garbageButton setTitle:L(@"Clear") forState:UIControlStateNormal];
        
        
        
        
        [self.backgroundImageView addSubview:_garbageButton];
        
    }
    return _garbageButton;
    
}

- (UIButton *)doneButton{
    
    if (!_doneButton) {
        
        _doneButton = [[UIButton alloc] init];
        
        [_doneButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        
        //[_doneButton setBackgroundImage:[UIImage imageNamed:@"commit.png"] forState:UIControlStateNormal];
        
        [_doneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_doneButton setTitle:L(@"Ok") forState:UIControlStateNormal];
        
        _doneButton.backgroundColor = RGBCOLOR(233, 123, 49);
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateHighlighted];
        
        [self.backgroundImageView addSubview:_doneButton];
        
    }
    
    return _doneButton;
    
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






@end
