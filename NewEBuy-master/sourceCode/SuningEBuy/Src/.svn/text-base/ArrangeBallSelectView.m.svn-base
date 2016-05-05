//
//  ArrangeBallSelectView.m
//  SuningLottery
//
//  Created by yangbo on 4/3/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "ArrangeBallSelectView.h"
#import "BallButton.h"
#import "LotterySelectBallView.h"

#define LOTTERY_SUBTYPE_BTN_BASE_TAG    700    //选择投注方法的basetag

//#define kBallStartTag           kBallStartTag    //彩球按钮basetag

#define LOTTERY_TIP_IMAGE_BASE_TAG      500

#define LOTTERY_TIP_LABEL_TAG           600    //tipLabel tag

#define kBallStartTag     100

@implementation ArrangeBallSelectView
@synthesize delegate = _delegate;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_ballNumberDTO);
    
}

//初始化方法 确定彩票类型（排列三或排列五），投注方法
- (id) initWithFrame:(CGRect)rect ballNumberDto:(BallNumberDTO *)dto
{
    if(self = [super initWithFrame:rect])
    {
        
        //放置彩球的scrollview
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        [self refreshViewWithBallDTO:dto];
        
        [self bringSubviewToFront:_scrollView];
    }
    return self;
}

//清除投注方法选择按钮， 当修改type之前使用
- (void)removeSubTypeBtn
{
    for(int i = 0; i < 4; i++)
    {
        UIView *btn = [self viewWithTag:i + LOTTERY_SUBTYPE_BTN_BASE_TAG + 101];
        
        if(nil != btn)
            [btn removeFromSuperview];
    }
    
    [[self viewWithTag:LOTTERY_TIP_LABEL_TAG] removeFromSuperview];
}

- (void)layoutSubTypeBtn
{
    //选球提示label
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.text = [_ballNumberDTO tipStringForAlert:NO];
    tipLabel.textColor = RGBCOLOR(87, 87, 87);
    tipLabel.tag = LOTTERY_TIP_LABEL_TAG;
    tipLabel.textAlignment = UITextAlignmentCenter;
    int x = 0;
    if (IOS7_OR_LATER)
    {
        tipLabel.textAlignment = UITextAlignmentLeft;
        x = 15;
    }
    
    [self addSubview:tipLabel];
    
    switch (_ballNumberDTO.type) {
        case ArrangeThree:
        {
            float offsetX = 24;               //按钮距离左边界距离
            float btnWidth = (320-24*2)/2;    //按钮宽度
            float btnHeight = 30;             //按钮高度
 
            //设置tiplabel frame
            tipLabel.frame = CGRectMake(x, btnHeight*2+2, [self bounds].size.width, 25);
            
            //设置放置彩球的scrollview的frame
            _scrollView.frame = CGRectMake(0, CGRectGetMaxY(tipLabel.frame), [self bounds].size.width, [self bounds].size.height - btnHeight - CGRectGetHeight(tipLabel.frame));
            
            //添加投注方法选择按钮
            for(int i = 0; i < 4; i++)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self action:@selector(selectSubTypeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
//                if (!IOS7_OR_LATER)
//                {
//                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//                    [btn setTitleColor:RGBCOLOR(59, 28, 26) forState:UIControlStateNormal];
//                    [btn setBackgroundImage:[UIImage imageNamed:@"left_top_unselect.png"] forState:UIControlStateNormal];
//                    
//                    [btn setBackgroundImage:[UIImage imageNamed:@"left_top_selected.png"] forState:UIControlStateSelected];
//                }
//                else
                {
                    btn.backgroundColor = [UIColor colorWithRGBHex:0xfcfcfd];
                    
                    btn.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
                    
                    btn.layer.borderWidth = 1;
                    [btn setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateSelected];
                    [btn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
                    //[btn setBackgroundImage:[UIImage imageNamed:@"ButtonArrNo.png"] forState:UIControlStateNormal];
                    
                    //[btn setBackgroundImage:[UIImage imageNamed:kProductDetailAddToShoppingCarWithNoStore] forState:UIControlStateSelected];
                    
                }
                //btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
                
                btn.tag = LOTTERY_SUBTYPE_BTN_BASE_TAG + i + 101;
                if (IOS7_OR_LATER)
                {
                    if (i+101 == zhiXuan)
                    {
                        for (int j = 0; j < 3; j++)
                        {
                            UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(10 ,12 + j*80+65, 310, 1)];
                            lineView.tag = 10000+j;
                            [lineView setBackgroundColor:[UIColor colorWithRGBHex:0xdcdcdc]];
                            [_scrollView addSubview:lineView];
                        }
                    }
                    
                }
                
                switch (i+101) {
                    case zhiXuan:
                    {
                        
                        btn.frame = CGRectMake(offsetX, 0, btnWidth, btnHeight);
                        //if (IOS7_OR_LATER)
                        {
                            
                            [btn setBackgroundColor:[UIColor colorWithRGBHex:0xdcdcdc]];
                        }
                        
                        [btn setTitle:L(@"Direct election") forState:UIControlStateNormal];
                        //                        [btn setBackgroundImage:[UIImage imageNamed:@"left_bottom_unselect.png"] forState:UIControlStateNormal];
                        //
                        //                        [btn setBackgroundImage:[UIImage imageNamed:@"left_bottom_selected.png"] forState:UIControlStateSelected];
                        
                    }
                        break;
                        
                    case zhiXuanHeZhi:
                    {
                        
                        btn.frame = CGRectMake(offsetX, btnHeight, btnWidth, btnHeight);
                        
                        [btn setTitle:L(@"Direct value") forState:UIControlStateNormal];
                        
//                        [btn setBackgroundImage:[UIImage imageNamed:@"left_bottom_unselect.png"] forState:UIControlStateNormal];
//                        
//                        [btn setBackgroundImage:[UIImage imageNamed:@"left_bottom_selected.png"] forState:UIControlStateSelected];
                    }
                        break;
                    case zuSan:
                    {
                        btn.frame = CGRectMake(offsetX + btnWidth, 0, btnWidth, btnHeight);
                        
                        [btn setTitle:L(@"Groups of three") forState:UIControlStateNormal];
//                        if (!IOS7_OR_LATER)
//                        {
//                            [btn setBackgroundImage:[UIImage imageNamed:@"right_top_unselect.png"] forState:UIControlStateNormal];
//                            
//                            [btn setBackgroundImage:[UIImage imageNamed:@"right_top_selected.png"] forState:UIControlStateSelected];
//                        }
                        
                    }
                        break;
                    case zuLiu:
                    {
                        btn.frame = CGRectMake(offsetX + btnWidth, btnHeight, btnWidth, btnHeight);
                        
                        [btn setTitle:L(@"Groups of six") forState:UIControlStateNormal];
//                        if (!IOS7_OR_LATER)
//                        {
//                            [btn setBackgroundImage:[UIImage imageNamed:@"right_bottom_unselect.png"] forState:UIControlStateNormal];
//                            
//                            [btn setBackgroundImage:[UIImage imageNamed:@"right_bottom_selected.png"] forState:UIControlStateSelected];
//                        }
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                
                if(_ballNumberDTO.subType == i+101)
                {
                    btn.selected = YES;
                }else{
                    btn.selected = NO;
                }
                [self addSubview:btn];
            }
         }
            break;
        case ArrangeFive:
        {
            //设置tiplabel frame
            tipLabel.frame = CGRectMake(x, 0, [self bounds].size.width, 25);
            
            //设置放置彩球的scrollview的frame
            _scrollView.frame = CGRectMake(0, CGRectGetMaxY(tipLabel.frame), [self bounds].size.width, [self bounds].size.height - CGRectGetHeight(tipLabel.frame));
        }
            break;
        default:
            break;
    }
    
    
}

//清除所有彩球按钮, 根据_ballNumberDTO.ballCount和_ballMinNumber清除 (修改_ballNumberDTO.ballCount或_ballMinNumber须先调用此方法)
- (void)clearAllBalls
{
    for(int i = 0; i < _ballNumberDTO.ballCount; i++)
    {
        UIView *ball = [self viewWithTag:i + kBallStartTag];
        
        if(nil != ball)
            [ball removeFromSuperview];
    }
    
    for (int i = 0; i < 7; i++) {
        UIView *tipView = [self viewWithTag:LOTTERY_TIP_IMAGE_BASE_TAG + i];
        
        if(nil != tipView)
            [tipView removeFromSuperview];
    }
}

//添加彩球按钮
- (void)layoutBalls
{
    
    float offsetX = (_ballNumberDTO.subType == zhiXuan ?  60 : 40);  //彩球左边界距离
    
    float offsetY = 0;
    
    float btnXOffset = _ballNumberDTO.subType == zhiXuan ? 11 : 16;    //彩球左右间距
    
    float btnYoffset = 5;     //彩球上下间距
    
    float btnWidth = 35;      //彩球宽度
    
    float btnHeight = 35;     //彩球高度
    
    _scrollView.contentSize = CGSizeMake([self bounds].size.width, (ceilf(_ballNumberDTO.ballCount/5.0) - 1)*(btnHeight + btnYoffset) + btnHeight + 4);
    
    for (int i = 0; i < _ballNumberDTO.ballCount; i++) {
        
        int ballNumber = [_ballNumberDTO ballNumberWithIndex:i];
        
        if(ballNumber == -1)
        {
            DLog(@"{ARRANGE}Arrange ballNumber compute error");
        }
        
        BallButton *btn = [[BallButton alloc] initWithType:eRedBallType ballNumber:[NSString stringWithFormat:@"%d",ballNumber] andDelegate:self];
        
        btn.frame = CGRectMake(offsetX + (i%5)*(btnXOffset + btnWidth), offsetY+(i/5)*(btnHeight + btnYoffset), btnWidth, btnHeight);
        
        btn.tag = kBallStartTag + i;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        //if (IOS7_OR_LATER)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"FlotteryTicket_redBallNew.png"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"FlotteryTicket_whiteBallNew.png"] forState:UIControlStateNormal];
        }
//        else
//        {
//            [btn setBackgroundImage:[UIImage imageNamed:@"FlotteryTicket_redBall.png"] forState:UIControlStateSelected];
//            [btn setBackgroundImage:[UIImage imageNamed:@"FlotteryTicket_whiteBall.png"] forState:UIControlStateNormal];
//        }
        
        
        [btn setTitleColor:[UIColor darkRedColor] forState:UIControlStateNormal];
        
        
        
        
        
        [btn setTitle:[NSString stringWithFormat:@"%d",ballNumber] forState:UIControlStateNormal];
        
        [_scrollView addSubview:btn];
    }
    
    //排列三和排列五彩球位数提示（百位 个位 十位）
    if(_ballNumberDTO.subType == zhiXuan)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        switch (_ballNumberDTO.type) {
            case ArrangeThree:
            {
                [array addObjectsFromArray:[NSArray arrayWithObjects:L(@"Hundred"),L(@"Ten"),L(@"Bit"), nil]];
            }
                break;
            case ArrangeFive:
            {
                [array addObjectsFromArray:[NSArray arrayWithObjects:L(@"Ten Thousand"),L(@"Thousand"),L(@"Hundred"),L(@"Ten"),L(@"Bit"), nil]];
            }
                break;
            default:
                break;
        }
        for(int i = 0; i < [array count]; i++)
        {
            UIImageView *imageView = nil;
            int y = 0;
//            if (!IOS7_OR_LATER)
//            {
//                imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhixuan.png"]];
//            }
//            else
            {   y = 15;
                imageView = [[UIImageView alloc] init];
            }
            imageView.frame = CGRectMake(10 ,12 + i*80-y, 50, 50);
            imageView.backgroundColor = [UIColor clearColor];
            imageView.tag = LOTTERY_TIP_IMAGE_BASE_TAG + i;
            
            if (IOS7_OR_LATER)
            {
                if(_ballNumberDTO.type == ArrangeFive)
                {
                    
                    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(10 ,12 + i*80+65, 310, 1)];
                    [lineView setBackgroundColor:[UIColor colorWithRGBHex:0xdcdcdc]];
                    [_scrollView addSubview:lineView];
                    
                }
                
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 14, 33, 20)];
            label.font = [UIFont boldSystemFontOfSize:15];
            label.text = [array objectAtIndex:i];
            label.textColor = RGBCOLOR(150, 120, 120);
            label.backgroundColor = [UIColor clearColor];
            [imageView addSubview:label];
            
            
            [_scrollView addSubview:imageView];
        }
        
    }
}

- (BOOL)ballSelect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType
{
    BOOL bRet = [_ballNumberDTO addBallNumber:ballIndex-1];
    
    if(!bRet)
    {
        DLog(@"{ARRANGE}select ball error");
    }
    
    if([_delegate isTotalPayOverflow])
    {
//        AlertMessageView *alert = [[AlertMessageView alloc] init];
//        
//        [alert alertMessage:L(@"The single orders bets up to 2000 yuan")];
//        
        [_ballNumberDTO removeBallNumber:ballIndex-1];
        
        return NO;
    }
    
   // sender.selected = !sender.isSelected;
    
    if([_delegate respondsToSelector:@selector(selectOrCancelSelectBall)])
    {
        [_delegate selectOrCancelSelectBall];
    }
    return YES;

}

- (BOOL)ballUnselect:(NSInteger)ballIndex ballType:(LotteryBallType)ballType
{
    BOOL bRet = [_ballNumberDTO removeBallNumber:ballIndex-1];
    
    if(!bRet)
    {
        DLog(@"{ARRANGE}deselect ball error");
    }

    
    //sender.selected = !sender.isSelected;
    
    if([_delegate respondsToSelector:@selector(selectOrCancelSelectBall)])
    {
        [_delegate selectOrCancelSelectBall];
    }
    
    return YES;
}

- (void)selectSubTypeBtnPressed:(UIButton *)sender
{
    if (sender.tag - LOTTERY_SUBTYPE_BTN_BASE_TAG == 101)
    {
        for (int j = 0; j < 3; j++)
        {
            [_scrollView viewWithTag:10000+j].hidden = NO;
        }
    }
    else
    {
        for (int j = 0; j < 3; j++)
        {
            [_scrollView viewWithTag:10000+j].hidden = YES;
        }
    }
    for (int i = 0;i < 4; ++i)
    {
        UIButton *bt = (UIButton*)[self viewWithTag:LOTTERY_SUBTYPE_BTN_BASE_TAG + i + 101];
        if (bt == sender)
        {
            continue;
        }
        [bt setBackgroundColor:[UIColor colorWithRGBHex:0xfcfcfd]];
    }
    [sender setBackgroundColor:[UIColor colorWithRGBHex:0xdcdcdc]];
    [self setSubType:sender.tag - LOTTERY_SUBTYPE_BTN_BASE_TAG];
}

//清空所选号码
- (void)clearSelectedNumber
{
    for (NSNumber *number in _ballNumberDTO.ballArray) {
        UIButton *ball = (UIButton *)[self viewWithTag:kBallStartTag + [number integerValue]];
        
        if(nil != ball)
        {
            ball.selected = NO;
        }
    }
    
    [_ballNumberDTO clearAllBalls];
}

- (void)setSubType:(LotterySelectionType)subType
{
    if(_ballNumberDTO.subType == subType)
        return;
    
    //清除上个subType按钮选中状态
    ((UIButton *)[self viewWithTag:LOTTERY_SUBTYPE_BTN_BASE_TAG + _ballNumberDTO.subType]).selected = NO;
    
    //选中subType对应的按钮
    ((UIButton *)[self viewWithTag:LOTTERY_SUBTYPE_BTN_BASE_TAG + subType]).selected = YES;
    
    //更换投注方式 需要重新排版彩球按钮
    [self clearAllBalls];
    
    [_ballNumberDTO clearAllBalls];
        
    _ballNumberDTO.subType = subType;
    
    //修改tipLabel文字
    ((UILabel *)[self viewWithTag:LOTTERY_TIP_LABEL_TAG]).text = [_ballNumberDTO tipStringForAlert:NO];
    
    //重新设置彩球按钮
    [self layoutBalls];
    
    if([_delegate respondsToSelector:@selector(selectOrCancelSelectBall)])
    {
        [_delegate selectOrCancelSelectBall];
    }
}

//根据投注号码刷新view
- (void)refreshViewWithBallDTO:(BallNumberDTO *)ballNumberDTO
{
    
    
    [self removeSubTypeBtn];
    [self clearAllBalls];
    
    TT_RELEASE_SAFELY(_ballNumberDTO);
    _ballNumberDTO = ballNumberDTO;
    
    [self layoutSubTypeBtn];
    
    //重新设置彩球按钮
    [self layoutBalls];
    
    //设置ball的选中状态
    for(NSNumber *ball in ballNumberDTO.ballArray)
    {
        int number = [ball integerValue];
        
        UIButton *ballBtn = (UIButton *)[self viewWithTag:kBallStartTag + number];
        
        if(nil != ballBtn)
        {
            ballBtn.selected = YES;
        }
    }

}

//获取选号结果
- (BallNumberDTO *)getSelectionBallNumber{
    
    return _ballNumberDTO;
}

//随即选择一组号码
- (void)randomSelectNumber
{
    
    BallNumberDTO *tmpBallNumberDto = [_ballNumberDTO deepCopy];
    
    [_ballNumberDTO randomSelectNumber];
    
    if([_delegate isTotalPayOverflow])
    {
//        AlertMessageView *alert = [[AlertMessageView alloc] init];
//        
//        [alert alertMessage:L(@"The single orders bets up to 2000 yuan")];
//        
//        [alert release];
        
        TT_RELEASE_SAFELY(_ballNumberDTO);
        
        _ballNumberDTO = tmpBallNumberDto;
        
        return;
    }
    
    [self clearAllBalls];
    
    [self layoutBalls];
    
    //设置ball的选中状态
    for(NSNumber *ball in _ballNumberDTO.ballArray)
    {
        int number = [ball integerValue];
        
        UIButton *ballBtn = (UIButton *)[self viewWithTag:kBallStartTag + number];
        
        if(nil != ballBtn)
        {
            ballBtn.selected = YES;
        }
    }

    
    if([_delegate respondsToSelector:@selector(selectOrCancelSelectBall)])
    {
        [_delegate selectOrCancelSelectBall];
    }
}

//判断选择的号码 是否满足投注要求
- (BOOL)isSelectNumbersValid
{
    return [_ballNumberDTO bets] > 0 ? YES : NO;
}
@end
