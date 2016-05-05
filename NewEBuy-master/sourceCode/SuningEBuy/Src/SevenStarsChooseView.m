//
//  SevenStarsChooseView.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-6.
//  Copyright (c) 2013年 suning. All rights reserved.
//


#import "BallButton.h"
#import "SevenStarsChooseView.h"

#define kBallCountOfRow   5

#define kBallWidth   35

#define kBallDistanceY  5

#define kBallCount  70

//球的起始点
#define kFirstX   65

#define kFirstY   20

@implementation SevenStarsChooseView
@synthesize chooseNumberArray = chooseNumberArray_;
@synthesize lastSelectedBallTag;
@synthesize sevenStarsdelegate;
#pragma mark - initial/dealloc method
-(id)init
{
    self = [super init];
    if (self) {
        self.lastSelectedBallTag = -1;
        //if (IOS7_OR_LATER)
        {
            selectedImageName_ = @"FlotteryTicket_redBallNew.png";
            unSelectedImageName_ = @"FlotteryTicket_whiteBallNew.png";
        }
//        else
//        {
//            selectedImageName_ = @"FlotteryTicket_redBall.png";
//            unSelectedImageName_ = @"FlotteryTicket_whiteBall.png";
//        }
        
        
        selectedFontColor_  =  [UIColor whiteColor];
        
        unSelectedFontColor_ = [UIColor darkRedColor];
        
        self.contentSize = CGSizeMake(self.width, 640);
        if (IOS7_OR_LATER)
        {
            self.contentSize = CGSizeMake(self.width, 670);
        }
        
        //if (IOS7_OR_LATER)
            self.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollbackTolastBall) name:ROLL_BACK object:nil];
    }
    return self;
}


-(void)dealloc
{

    TT_RELEASE_SAFELY(chooseNumberArray_);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(NSMutableArray *)chooseNumberArray
{
    if (!chooseNumberArray_) {
        chooseNumberArray_ = [[NSMutableArray alloc]init];
    }
    return chooseNumberArray_;
}

#pragma mark - self-define method
-(void)setAllBallsView
{
    int x = kFirstX;
    if (IOS7_OR_LATER)
        x = -10;
    UILabel *tips = [[UILabel alloc]initWithFrame:CGRectMake(x + 25, 3, 200, 15)];
    [tips setBackgroundColor:[UIColor clearColor]];
    
    [tips setTextColor:[UIColor grayColor]];
    
    [tips setText:L(@"Each select at least one ball")];
    
    [self addSubview:tips];
    
    TT_RELEASE_SAFELY(tips);
    //球的布局
    for (int index = 0; index <kBallCount; index ++) {
        //第一行为row = 0
        NSInteger row = index/kBallCountOfRow;
        //第一列为colunm = 0
        NSInteger colunm = index - kBallCountOfRow * row;
        //是否奇数行  奇数行表示是第一个起头的是数值5
        BOOL isOdd = row%2;
        NSString *ballNumber = [NSString stringWithFormat:@"%d",(index + kBallStartTag - kBallStartTag)%10];
        BallButton *ballButton = [[BallButton alloc] initWithType:eRedBallType ballNumber:ballNumber andDelegate:self.sevenStarsdelegate];
        
        //tag表示真正的对应选球数值(只算个位)
        ballButton.tag = index + kBallStartTag;
        
        [ballButton setTitle:ballNumber forState:UIControlStateNormal];
        
        ballButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [ballButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [ballButton setTitleColor:selectedFontColor_ forState:UIControlStateSelected];
        
        [ballButton setBackgroundImage:[UIImage imageNamed:selectedImageName_] forState:UIControlStateSelected];
        
        [ballButton setTitleColor:unSelectedFontColor_ forState:UIControlStateNormal];
        
        [ballButton setBackgroundImage:[UIImage imageNamed:unSelectedImageName_] forState:UIControlStateNormal];
        
        [ballButton setSelected:NO];
        //第一列的球
        [ballButton setFrame:CGRectMake(kFirstX+colunm*(2*kBallDistanceY+kBallWidth), kFirstY + row*(2*kBallDistanceY + kBallWidth), kBallWidth, kBallWidth)];
        
        if (colunm == 0&&isOdd == NO) {
            //第一列
            //左边标示视图
            int y = 0;
            if (!IOS7_OR_LATER)
            {
                UIImageView *leftNumberView = [[UIImageView alloc]initWithFrame:CGRectMake(kFirstX - 40, ballButton.origin.y  + kBallWidth / 2, kBallWidth*1.1, kBallWidth * 1.2)];
                
                [leftNumberView setImage:[UIImage imageNamed:@"zhixuan.png"]];
                
                [self addSubview:leftNumberView];
                
                TT_RELEASE_SAFELY(leftNumberView);
            }
            else
            {
                y = 20;
                UIImageView* lineView = [[UIImageView alloc]initWithFrame:CGRectMake(kFirstX - 40 -15, ballButton.origin.y  + kBallWidth*2+15, 320-10, 1)];
                [lineView setBackgroundColor:[UIColor colorWithRGBHex:0xdcdcdc]];
                [self addSubview:lineView];
                 TT_RELEASE_SAFELY(lineView);
            }
            //标示数字
            UILabel *leftNumber = [[UILabel alloc]initWithFrame:CGRectMake(kFirstX - 40, ballButton.origin.y  + kBallWidth / 2 + 3 - y, kBallWidth, kBallWidth)];
            
            leftNumber.backgroundColor = [UIColor clearColor];
            
            [leftNumber setTextAlignment:NSTextAlignmentCenter];
            if (IOS7_OR_LATER)
            {
                NSArray* array = [[NSArray alloc] initWithObjects:@"",L(@"LOOne"),L(@"LOTwo"),L(@"LOThree"),L(@"LOFour"),L(@"LOFive"),L(@"LOSix"),L(@"LOSeven"), nil];
                [leftNumber setText:[NSString stringWithFormat:@"%@",array[row/2 +1]]];
                
            }
            else
            {
                [leftNumber setText:[NSString stringWithFormat:@"%d",row/2 +1]];
            }
            
            
            [self addSubview:leftNumber];
            
            TT_RELEASE_SAFELY(leftNumber);
        }
        
        [self addSubview:ballButton];
        
        TT_RELEASE_SAFELY(ballButton);
    }
}

-(void)setBallSheetWith:(NSString *)resultString
{
    NSArray *stringArray = [resultString componentsSeparatedByString:@" | "];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    NSInteger tenbit = 0;
    for (NSString *str_one in stringArray) {
        NSArray *tempArray = [str_one componentsSeparatedByString:@" "];
        for (NSString *str_two in tempArray) {
            [resultArray addObject:[NSNumber numberWithInteger:[str_two integerValue] + tenbit]];
            
            UIButton *ball = (UIButton *)[self viewWithTag:[str_two integerValue] + tenbit + kBallStartTag];
            if (ball) {
                [self clickOnBall:ball];
                
                [self.chooseNumberArray addObject:[NSNumber numberWithInteger:ball.tag]];
            }
        }
        tenbit = tenbit + 10;
    }
    TT_RELEASE_SAFELY(resultArray);
}

-(void)resetAllBallsView
{
    [self removeAllSubviews];
    
    [self setAllBallsView];
    
    //清空所选球项
    [self.chooseNumberArray removeAllObjects];
    
    if ([self.sevenStarsdelegate conformsToProtocol:@protocol(SevenStarsChooseViewDelegate)]&&[self.sevenStarsdelegate respondsToSelector:@selector(setBottomViewInfo)]) {
        [self.sevenStarsdelegate setBottomViewInfo];
    }
}


/*
 *   选球响应事件
 *   参数：球所对应的tag
 */
-(void)clickOnBall:(UIButton *) ball
{
    
    //取消选号
    if ([sevenStarsdelegate conformsToProtocol:@protocol(SevenStarsChooseViewDelegate)]&&[sevenStarsdelegate respondsToSelector:@selector(ballUnselect:ballType:)]) {
            [self.sevenStarsdelegate ballUnselect:ball.tag - kBallStartTag + 1 ballType:eRedBallType];
    }
    
    [ball setSelected:!ball.isSelected];
  
}


-(void)rollbackTolastBall
{
    if (self.lastSelectedBallTag != -1) {
        BallButton *ball = (BallButton *)[self viewWithTag:self.lastSelectedBallTag];
        [self clickOnBall:ball];
    }
}
@end
