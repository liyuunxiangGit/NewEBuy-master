//
//  SevenStarsBottomView.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenStarsBottomView.h"

@implementation SevenStarsBottomView

@synthesize finalResultStr;
@synthesize leftMoney;
@synthesize mutipleTimes;
@synthesize periods;
@synthesize resetButton = _resetButton;
@synthesize submitButton = _submitButton;
@synthesize shakeTips = _shakeTips;
@synthesize totalCost = _totalCost;
@synthesize backgroundImgView = _backgroundImgView;
@synthesize delegate;

#pragma mark - initial/dealloc method
-(id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.mutipleTimes = 1;
        self.periods = 1;
        self.leftMoney = 2000;
    }
    return self;
}

-(void)dealloc
{

    TT_RELEASE_SAFELY(_shakeTips);
    TT_RELEASE_SAFELY(_totalCost);
    TT_RELEASE_SAFELY(_backgroundImgView);
    TT_RELEASE_SAFELY(finalResultStr);
    TT_RELEASE_SAFELY(_resetButton);
    TT_RELEASE_SAFELY(_submitButton);
    
}


-(UIImageView *)backgroundImgView
{
    if (!_backgroundImgView) {
        _backgroundImgView = [[UIImageView alloc]init];
        
        [_backgroundImgView  setFrame:self.bounds];
        //if (IOS7_OR_LATER)
        {
            _backgroundImgView.backgroundColor = [UIColor uiviewBackGroundColor];
        }
//        else
//        {
//            UIImage *image = [[UIImage imageNamed:@"ball_select_bottom.png"]stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//            
//            _backgroundImgView.image = image;
//            
//        }
        _backgroundImgView.userInteractionEnabled = YES;
        [self addSubview:_backgroundImgView];
    }
    return _backgroundImgView;
}

-(UIButton *)resetButton
{
    if (!_resetButton) {
        _resetButton = [[UIButton alloc]init];
        //if (IOS7_OR_LATER)
        {
            _resetButton.backgroundColor = [UIColor whiteColor];
        }
//        else
//        {
//            [_resetButton setBackgroundImage:[UIImage imageNamed:@"clean.png"] forState:UIControlStateNormal];
//             _resetButton.backgroundColor = [UIColor clearColor];
//        }
        
        
        [_resetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_resetButton setTitleColor:[UIColor darkGrownColor] forState:UIControlStateNormal];
        
        [_resetButton addTarget:self action:@selector(resetButtonAction) forControlEvents:UIControlEventTouchDown];
        
        [_resetButton setTitle:L(@"Clear") forState:UIControlStateNormal];
        
        [self.backgroundImgView addSubview:_resetButton];
    }
    return _resetButton;
}

-(UIButton *)submitButton
{
    if (!_submitButton) {
        _submitButton = [[UIButton alloc]init];;
        
        [_submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        //if (IOS7_OR_LATER)
        {
            _submitButton.backgroundColor = [UIColor colorWithRGBHex:0xfc7c26];
        }
//        else
//        {
//            [_submitButton setBackgroundImage:[UIImage imageNamed:@"commit.png"] forState:UIControlStateNormal];
//            _submitButton.backgroundColor = [UIColor clearColor];
//        }
       
        
        [_submitButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_submitButton setTitle:L(@"Ok") forState:UIControlStateNormal];
        
        
        
        [self.backgroundImgView addSubview:_submitButton];
    }
    return _submitButton;
}

-(UILabel *)shakeTips
{
    if (!_shakeTips) {
        _shakeTips = [[UILabel alloc]init];
        
        _shakeTips.textAlignment = UITextAlignmentCenter;
        
        [_shakeTips setFont:[UIFont systemFontOfSize:12]];
        
        [_shakeTips setTextColor:[UIColor darkRedColor]];
        
        _shakeTips.text = L(@"Shake machine selection Note");
        
        _shakeTips.backgroundColor = [UIColor clearColor];
        
        [self.backgroundImgView addSubview:_shakeTips];
    }
    return _shakeTips;
}

-(UILabel *)totalCost
{
    if (!_totalCost) {
        _totalCost = [[UILabel alloc]init];
        
        _totalCost.backgroundColor = [UIColor clearColor];
        
        [_totalCost setFont:[UIFont boldSystemFontOfSize:12] ] ;
        
        [_totalCost setTextAlignment:UITextAlignmentCenter];
        
        _totalCost.textColor = RGBCOLOR(102.0, 51.0, 51.0);
        
        [self.backgroundImgView addSubview:_totalCost];
    }
    return _totalCost;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.resetButton.frame = CGRectMake(10, 6, 45, 32);
    
    self.shakeTips.frame = CGRectMake(self.resetButton.right+10, 5, 200 - 5, 20);
    
    self.totalCost.frame = CGRectMake(self.shakeTips.left, self.shakeTips.bottom-5, self.shakeTips.width, self.shakeTips.height);
    
    self.submitButton.frame = CGRectMake(self.shakeTips.right + 5, 6, 45, 32);
    
}




#pragma mark - delegate of SevenStarsChooseView
-(void)setBottomViewInfo:(NSMutableArray *)selectedNumber
{
    if ([selectedNumber count] == 0) {
        self.shakeTips.text = L(@"Shake machine selection Note");
        
        self.totalCost.text = [NSString stringWithFormat:L(@"LOCalculateFormula"), self.mutipleTimes, self.periods];
    }else
    {
        [self chooseNumberSort:selectedNumber];
        
        [self setResultLabelWithNumber:selectedNumber];
    }
}


#pragma mark - self-define method
/* 排序
 * 参数：未排序的选球结果
 */
-(void)chooseNumberSort:(NSMutableArray *) unsortArray
{
    if ([unsortArray count] == 0) {
        return;
    }else
    {
        //递减
        for (int i = 0; i < [unsortArray count]; i++) {
            for (int j = i+1; j<[unsortArray count]; j++) {
                if ([[unsortArray objectAtIndex:i] integerValue] > [[unsortArray objectAtIndex:j] integerValue]) {
                    [unsortArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }
        }
    }
}

/*
 * 更改底部结果标签显示
 * 参数：降序排列的选球结果
 */
-(void)setResultLabelWithNumber:(NSMutableArray *) selectedNumber
{
    NSMutableString *resultString = [[NSMutableString alloc]init];
    for (NSNumber *value in selectedNumber) {
        //是否是最后一个
        if ([selectedNumber lastObject] == value) {//地址是否相同  是否是同一个
            [resultString appendString:[NSString stringWithFormat:@"%d",[value integerValue]%10]];
        }else
        {
            NSInteger currentIndex = [selectedNumber indexOfObject:value];
            
            if ([value integerValue]/10-[[selectedNumber objectAtIndex:currentIndex + 1] integerValue]/10 == 0) {
                //十位上的数字相同
                [resultString appendString:[NSString stringWithFormat:@"%d ",[value integerValue]%10]];
            }else
            {
                [resultString appendString:[NSString stringWithFormat:@"%d | ",[value integerValue]%10]];
            }
        }
    }
    
    //选球改变时  底部标签显示修改
    CGFloat totalcost = [self getTotalCost:resultString];
    if ( totalcost == 0) {
        self.totalCost.text = [NSString stringWithFormat:L(@"LOCalculateFormula"), self.mutipleTimes, self.periods];
    }else
    {
        if (totalcost * self.mutipleTimes * self.periods > self.leftMoney || totalcost < 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ROLL_BACK object:nil];
            TT_RELEASE_SAFELY(resultString);
            return;
        }else
        {
            self.totalCost.text = [NSString stringWithFormat:L(@"LOCalculateFormula3"),[self getTotalCost:resultString]/2,self.mutipleTimes,self.periods,[self getTotalCost:resultString] * self.mutipleTimes * self.periods];
        }
    }
    
    self.finalResultStr = resultString ;
    
    TT_RELEASE_SAFELY(resultString);
}


/*
 * 得到总共钱数
 * 返回钱数
 */
-(NSInteger)getTotalCost:(NSString *) resultStr
{
    NSInteger countOfLottery;
    countOfLottery = (NSInteger)[ComputeLotteryNumber computeLotterySevenStarsNumber:resultStr];
    return countOfLottery * 2;
}


/*
 * 清空按钮响应事件
 */
-(void)resetButtonAction
{
    self.finalResultStr = nil;
    if ([self.delegate conformsToProtocol:@protocol(SevenStarsBottomViewDelegate)]&&[self.delegate respondsToSelector:@selector(resetSevenStarsBallChooseView)]) {
        [self.delegate resetSevenStarsBallChooseView];
    }
}

/*
 * 确定按钮响应事件
 */
-(void)submit
{
    if ([self.delegate conformsToProtocol:@protocol(SevenStarsBottomViewDelegate)]&&[self.delegate respondsToSelector:@selector(submitSelection:)]) {
        [self.delegate submitSelection:self.finalResultStr];
    }
}
@end
