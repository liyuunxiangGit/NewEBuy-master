//
//  Welfare3DBottomView.m
//  SuningLottery
//
//  Created by jian  zhang on 12-9-25.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "Welfare3DBottomView.h"

#import "ComputeLotteryNumber.h"
#import "UIColor+Helper.h"
#import "SubmitLotteryDto.h"

@interface Welfare3DBottomView(){
    
    //注数
    NSInteger   count;
    
    int         lotteryType_;
        
} 
@property(nonatomic,strong)UIButton            *garbageButton;
@property(nonatomic,strong)UILabel             *priceLabel;
@property(nonatomic,strong)UIButton            *doneButton;
@property(nonatomic,strong)UIImageView         *backgroundImageView;


- (void)setResultText:(NSMutableArray *)wel3DArr;

- (NSInteger)getReseultCout:(NSString *)resultString;

@end

@implementation Welfare3DBottomView

@synthesize garbageButton = _garbageButton;
@synthesize selectedNumsLabel = _selectedNumsLabel;
@synthesize priceLabel = _priceLabel;
@synthesize doneButton = _doneButton;
@synthesize bottomDelegate = _bottomDelegate;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize ballType = _ballType;
@synthesize resultStr = resultStr_;



- (void)dealloc {
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
        
        self.backgroundColor = [UIColor uiviewBackGroundColor];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.garbageButton.frame = CGRectMake(10, 8, 45, 30);
    
    self.selectedNumsLabel.frame = CGRectMake(self.garbageButton.right+10, 5, 200 - 5, 20);
    
    self.priceLabel.frame = CGRectMake(self.selectedNumsLabel.left, self.selectedNumsLabel.bottom-5, self.selectedNumsLabel.width, self.selectedNumsLabel.height);
    
    self.doneButton.frame = CGRectMake(self.selectedNumsLabel.right + 5, 8, 45, 30);
    
}

/*
 Notes：
 设置选择出的结果
 无选中状态下显示摇一摇
 选中状态下显示选中的数字序列
 */
-(void)setResultChoice:(NSMutableArray *)wel3DArr LottertType:(int)lotteryType multiNo:(NSString *)mutiNo period:(NSString *)period{
    
    self.backgroundImageView.frame = CGRectMake(0,0,320,self.height);
    
    lotteryType_ = lotteryType;
        
    if (!wel3DArr || (wel3DArr.count == 0)) {
        
        self.selectedNumsLabel.text = L(@"Shake machine selection Note");
        
        resultStr_ = @"";
        
        self.priceLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula4"),mutiNo,period];
        
    }else{
        
        [self setResultText:wel3DArr];
        
        NSInteger resultCount = [ComputeLotteryNumber computeLotteryFC3DNumber:resultStr_ ballType:lotteryType_];
            
        if (resultCount == 0) {
                        
            self.selectedNumsLabel.text = L(@"Shake machine selection Note");

            
            self.priceLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula4"),mutiNo,period];
            
            
        }else{
            
            self.priceLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula5"),resultCount,mutiNo,period,2*resultCount*[mutiNo intValue] * [period intValue]];
        }
        
    }
    
    
    [self setNeedsLayout];
    
}


- (void)setResultText:(NSMutableArray *)wel3DArr{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    switch (lotteryType_) {
        case zhiXuan:{

            int ten = 0;
            int hund = 0;
            
            for (NSNumber *value in wel3DArr) {

                if ([value intValue] >= 20) {
                    if (hund == 0) {
                        [resultString appendFormat:@" |"];
                    }
                    hund ++;
                    [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue] - 20]];
                }
                else if ([value intValue] >= 10) {
                    if (ten == 0) {
                        [resultString appendFormat:@" |"];
                    }
                    ten ++;
                    [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue] - 10]];
                }
                else{
                    [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue]]];
                }
            }  
        }
            break;
        case zuSanHeZhi:
            for (NSNumber *value in wel3DArr) {
                
                [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue] + 1]];
            }
            break;            
        case zuLiuHeZhi:
            for (NSNumber *value in wel3DArr) {
                
                [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue] + 3]];
            }
        break;            
        default:
        
            for (NSNumber *value in wel3DArr) {
                
                [resultString appendString:[NSString stringWithFormat:@" %d",[value intValue]]];
            }
            break;
    }
    
    DLog(@"resultString is %@", resultString); 
      
//    self.selectedNumsLabel.text = resultString;
    
    resultStr_ = [resultString copy]; 
    
    TT_RELEASE_SAFELY(resultString);
        
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
    
    if ([self.bottomDelegate conformsToProtocol:@protocol(Welfare3DBottomViewDelegate) ]) {
        
        if ([self.bottomDelegate respondsToSelector:@selector(reChoose)] ) {
            
            [self.bottomDelegate reChoose];
            
        }
    }
}

- (void)submit:(id)sender{
    
    if ([self.bottomDelegate conformsToProtocol:@protocol(Welfare3DBottomViewDelegate) ]) {
        
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
        
        [_garbageButton setTitle:L(@"Clear") forState:UIControlStateNormal];

        _garbageButton.backgroundColor = [UIColor whiteColor];
        
        [self.backgroundImageView addSubview:_garbageButton];
        
    }
    return _garbageButton;
    
}

-(UILabel  *)selectedNumsLabel{
    
    if (_selectedNumsLabel == nil) {
        
        _selectedNumsLabel = [[UILabel alloc]init];
        
        _selectedNumsLabel.textAlignment = UITextAlignmentCenter;
        
        [_selectedNumsLabel setFont:[UIFont systemFontOfSize:12]];
        
        [_selectedNumsLabel setTextColor:[UIColor darkRedColor]];

        _selectedNumsLabel.backgroundColor = [UIColor clearColor];
                
        [self.backgroundImageView addSubview:_selectedNumsLabel];
    }
    
    return _selectedNumsLabel;
}


- (UILabel  *)priceLabel{
    
    if (_priceLabel == nil) {
        
        _priceLabel = [[UILabel  alloc]init];
        
        _priceLabel.backgroundColor = [UIColor clearColor];
        
        [_priceLabel setFont:[UIFont boldSystemFontOfSize:12] ] ;
        
        [_priceLabel setTextAlignment:UITextAlignmentCenter];
        
        _priceLabel.textColor = RGBCOLOR(102.0, 51.0, 51.0);
                
        [self.backgroundImageView addSubview:_priceLabel];
        
    }
    
    return _priceLabel;
    
}

- (UIButton *)doneButton{
    
    if (!_doneButton) {
        
        _doneButton = [[UIButton alloc] init];
        
        [_doneButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        
//        [_doneButton setBackgroundImage:[UIImage imageNamed:@"commit.png"] forState:UIControlStateNormal];
        
        [_doneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_doneButton setTitle:L(@"Ok") forState:UIControlStateNormal];
        
        _doneButton.backgroundColor = RGBCOLOR(233, 123, 49);
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateHighlighted];
        
        [self.backgroundImageView addSubview:_doneButton];
        
    }
    
    return _doneButton;
    
}


@end
