//
//  Welfare3DBallChooseView.m
//  SuningLottery
//
//  Created by jian  zhang on 12-9-24.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "Welfare3DBallChooseView.h"
#import "BallButton.h"

#define kBallStartTag     100

#define kBallCountOfRow   5

#define kBallWidth   35

#define kBallDistanceY  5


@interface Welfare3DBallChooseView() {
    
    //球的总个数
    NSInteger ballCount_;
    //随机选的球的个数    
    NSInteger ballRandomSelectCount_;
    //最少的球数量
    NSInteger minNum_;
    //最多选择的球的数量
    NSInteger maxNum_;
    //选中的球的图片名称    
    NSString   *selectedImageName_;
    //未选中的球的图片名称
    NSString    *unSelectedImageName_;
    
    //选中的球的字体颜色
    UIColor    *selectedFontColor_;
    //未选中的球的字体颜色
    UIColor    *unSelectedFontColor_;
    
    LotteryBallType ballType_;
    
}

@property (nonatomic, strong) UIImageView               *bitsView;
@property (nonatomic, strong) UIImageView               *tenView;
@property (nonatomic, strong) UIImageView               *hundredView;

//布局整个页面
- (void)setSelectedBallView;

@end


@implementation Welfare3DBallChooseView

@synthesize welfare3DDelegate = _welfare3DDelegate;
@synthesize ballType = _ballType;
@synthesize bitsView = _bitsView;
@synthesize tenView = _tenView;
@synthesize hundredView = _hundredView;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_bitsView);
    TT_RELEASE_SAFELY(_tenView);
    TT_RELEASE_SAFELY(_hundredView);
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {

        selectedImageName_ = @"lottery_redball";
        
        unSelectedImageName_ = @"lottery_grayball";
        
        selectedFontColor_  =  [UIColor whiteColor];
        
        unSelectedFontColor_ = [UIColor darkRedColor];

    }
    return self;
}

- (void)reloadBallCount:(NSInteger)ballCount minNumber:(NSInteger)minNum BallType:(int)ballType{
    
    ballCount_ = ballCount;
    
    minNum_ = minNum;
        
    ballType_ = ballType;
    
    ballRandomSelectCount_ = minNum_;

    [self removeAllSubviews];
    
    [self setSelectedBallView];
}


/*
 Notes：
 根据随机数表，选中对应的球
 */
- (void)randomChooseBall:(NSMutableArray*)selectedBallArr{
    
    for (int index = kBallStartTag ;index <  kBallStartTag + ballCount_; index ++) {
        
        UIButton *ballButton = (UIButton *)[self viewWithTag:index]; 
        
        if ([selectedBallArr containsObject:[NSNumber numberWithInt:index - kBallStartTag]]) {
            
            ballButton.selected = YES;
            
        }else{
            
            ballButton.selected = NO;
        }        
    }
}

- (void)setSelectedBallView{
    
    /*
     Notes：
     计算球之间的距离
     如果，球的距离小于5，那么将球的大小置为距离为5的最大宽度。
     否则，球的直径为kBallWidth，距离为计算的结果。
     */  

    CGFloat ballWidth = 0;
    
    CGFloat distance = (240 - kBallCountOfRow*kBallWidth) /(kBallCountOfRow -1);    
    
    if (distance<5) {
        
        distance = 5;
        
        ballWidth = (240-(kBallCountOfRow-1)*5)/kBallCountOfRow;
        
    }else{
        
        ballWidth = kBallWidth;
    }
    
    /*
     Notes：
     布局球位置
     row：从0开始
     rowLocation：从0开始
     */
    
    
    @autoreleasepool {
        
        for (int index=0 ; index < ballCount_; index ++) {
            
            NSInteger row = 0;
            
            NSInteger rowLocation = 0;
            
            if ((index+1)%kBallCountOfRow == 0) {
                
                row = (index+1) / kBallCountOfRow - 1;
                
                rowLocation = kBallCountOfRow - 1;
                
            }else{
                
                row = (index+1) /kBallCountOfRow ;
                
                rowLocation = (index+1) % kBallCountOfRow -1 ;
            }
            
            CGFloat YFrame = (ballWidth + kBallDistanceY)*row;
            CGFloat XFrame ;

            NSUInteger ballNumber = 0;
            
            if (ballType_ == zhiXuan)
            {
                
                XFrame = (ballWidth + distance - 5)*rowLocation + 60;

                [self addSubview:self.bitsView];
                [self addSubview:self.tenView];
                [self addSubview:self.hundredView];
                if (index + minNum_ >= 20)
                {
                    ballNumber = index + minNum_ - 20;
                    
                }
                else if(index + minNum_ >= 10)
                {
                    ballNumber = index + minNum_ - 10;
                    
                }
                else
                {
                    ballNumber = index + minNum_;
                    
                }
                
            }
            else
            {
            
                XFrame = (ballWidth + distance)*rowLocation + 40;

                ballNumber = index + minNum_;
                
            }
            
            BallButton *ballButton = [[BallButton alloc] initWithType:ballType_ ballNumber:[NSString stringWithFormat:@"%d",ballNumber] andDelegate:self.welfare3DDelegate];
            
            ballButton.tag = kBallStartTag + index;
            
            [ballButton setTitle:[NSString stringWithFormat:@"%d",ballNumber] forState:UIControlStateNormal];
            
            ballButton.titleLabel.font = [UIFont systemFontOfSize:15];
            
            [ballButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [ballButton setTitleColor:selectedFontColor_ forState:UIControlStateSelected];
            
            [ballButton setBackgroundImage:[UIImage imageNamed:selectedImageName_] forState:UIControlStateSelected];
            
            [ballButton setTitleColor:unSelectedFontColor_ forState:UIControlStateNormal];
                        
            [ballButton setBackgroundImage:[UIImage imageNamed:unSelectedImageName_] forState:UIControlStateNormal];
            
            ballButton.frame = CGRectMake(XFrame, YFrame, ballWidth, ballWidth);

            [ballButton setBackgroundColor:[UIColor clearColor]];
            
            [ballButton setSelected:NO];

            [self addSubview:ballButton];
            
            TT_RELEASE_SAFELY(ballButton);
            
        }
        
    }
        
    [self layoutIfNeeded];    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
}


#pragma mark -
#pragma mark Button Tapped Event Method 点击button事件的方法

- (void)ballButtonTag:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    
    if (button.selected == NO) 
    {
        if ( [self.welfare3DDelegate conformsToProtocol:@protocol(Welfare3DBallChooseViewDelegate)]) 
        {
            if ([self.welfare3DDelegate respondsToSelector:@selector(ballSelect:ballType:) ]) 
            {
                BOOL isValide =  [self.welfare3DDelegate  ballSelect:button.tag-kBallStartTag + 1  ballType:ballType_];
                
                if (isValide == YES) 
                {
                    button.selected  = !button.isSelected;
                }
            }
        }
    }
    else
    {
        if ( [self.welfare3DDelegate conformsToProtocol:@protocol(Welfare3DBallChooseViewDelegate)]) 
        {
            if ([self.welfare3DDelegate respondsToSelector:@selector(ballUnselect:ballType:) ]) 
            {
                BOOL isValide =  [self.welfare3DDelegate  ballUnselect:button.tag - kBallStartTag + 1 ballType:ballType_];
                
                if (isValide == YES) 
                {
                    button.selected  = !button.isSelected;
                    
                }
            }
        }        
    }
}


- (void)excuteRandomSelect:(id)sender{
    
    if ( [self.welfare3DDelegate conformsToProtocol:@protocol(Welfare3DBallChooseViewDelegate)]) 
    {
        if ([self.welfare3DDelegate respondsToSelector:@selector(randomBallSelect:randomCount:) ]) 
        {
            [self.welfare3DDelegate randomBallSelect:ballType_ randomCount:ballRandomSelectCount_];
        }
    }
}



#pragma mark -
#pragma mark uiview init

- (UIImageView *)bitsView{
    
    if (!_bitsView) {
        
        _bitsView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhixuan.png"]];
        
        _bitsView.frame = CGRectMake(10 ,12, 50, 50);
        
        _bitsView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 14, 33, 20)];
        
        label.font = [UIFont boldSystemFontOfSize:15];
        
        label.text = L(@"Hundred");
        
        label.textColor = RGBCOLOR(150, 120, 120);
        
        label.backgroundColor = [UIColor clearColor];
        
        [_bitsView addSubview:label];
        
        
    }
    
    return _bitsView;
}

- (UIImageView *)tenView{
    
    if (!_tenView) {
        
        _tenView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhixuan.png"]];
        
        _tenView.frame = CGRectMake(10 ,12  + 80, 50, 50);
        
        _tenView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 14, 33, 20)];
        
        label.font = [UIFont boldSystemFontOfSize:15];
        
        label.text = L(@"Ten");
        
        label.textColor = RGBCOLOR(150, 120, 120);
        
        label.backgroundColor = [UIColor clearColor];
        
        [_tenView addSubview:label];
        
        
    }
    
    return _tenView;
}

- (UIImageView *)hundredView{
    
    if (!_hundredView) {
        
        _hundredView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhixuan.png"]];
        
        _hundredView.frame = CGRectMake(10 ,12 + 160, 50, 50);
        
        _hundredView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 14, 33, 20)];
        
        label.font = [UIFont boldSystemFontOfSize:15];
        
        label.text = L(@"Bit");
        
        label.textColor = RGBCOLOR(150, 120, 120);
        
        label.backgroundColor = [UIColor clearColor];
        
        [_hundredView addSubview:label];
        
        
    }
    return _hundredView;
}




@end
