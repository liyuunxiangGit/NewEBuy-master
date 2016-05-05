//
//  SevenLeSelectBallView.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenLeSelectBallView.h"

#define kBallStartTag     100

#define kBallCountOfRow   9

#define kBallWidth   35

#define kBallDistanceY  5

@interface SevenLeSelectBallView() {
    
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

}

//随机选择button
@property(nonatomic,strong)UIButton  *randomSelectButton;

//随机数量选择button
@property(nonatomic,strong)UIButton  *countSelectButton;

//用于承载球的view
@property(nonatomic,strong)UIView    *ballView;

@property(nonatomic,strong)LotteryBallCountChooseView  *ballCountView;
//已选球的数量展示
@property(nonatomic,strong)UILabel      *selectedCountLabel;

@property(nonatomic,strong)UIButton     *backGroudButton;


//布局整个页面
- (void)setSelectedBallView;

- (void)setSelectedCountText:(NSInteger )selectedCount;

@end


@implementation SevenLeSelectBallView


@synthesize randomSelectButton = _randomSelectButton;
@synthesize countSelectButton = _countSelectButton;
@synthesize ballView = _ballView;
@synthesize ballSelectDelegate = _ballSelectDelegate;
@synthesize ballCountView = _ballCountView;
@synthesize selectedCountLabel = _selectedCountLabel;
@synthesize backGroudButton = _backGroudButton;


-(void)dealloc{
    
    TT_RELEASE_SAFELY(_randomSelectButton);
    TT_RELEASE_SAFELY(_countSelectButton);
    TT_RELEASE_SAFELY(_ballView);
    TT_RELEASE_SAFELY(_ballCountView);
    TT_RELEASE_SAFELY(_selectedCountLabel);
    TT_RELEASE_SAFELY(_backGroudButton);
    
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (id)initWithBallCount:(NSInteger)ballCount minNumber:(NSInteger)minNum maxNumber:(NSInteger)maxNum{
    
    self = [super init];
    
    if(self){
        
        ballCount_ = ballCount;
        
        minNum_ = minNum;
        
        maxNum_ = maxNum;
        
    }
    
    return self;
}

#pragma mark -
#pragma mark View Handle Method

- (void)setBall
{
    
         [self.ballCountView setMinCount:minNum_ maxCount:maxNum_];
    
         ballRandomSelectCount_ = minNum_;
        //if (IOS7_OR_LATER)
        {
            selectedImageName_ = @"FlotteryTicket_redBallNew.png";
            
            unSelectedImageName_ = @"FlotteryTicket_whiteBallNew.png";
        }
//        else
//        {
//            selectedImageName_ = @"FlotteryTicket_redBall.png";
//            
//            unSelectedImageName_ = @"FlotteryTicket_whiteBall.png";
//        }
    
         selectedFontColor_ = [UIColor whiteColor];
            
         unSelectedFontColor_ = [UIColor darkRedColor];
    
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

+ (CGFloat)height:(NSInteger)ballCount{
    
    CGFloat ballWidth = 0;
    
    CGFloat distance = (300 - kBallCountOfRow*kBallWidth) /(kBallCountOfRow -1);
    
    if (distance<5) {
        
        ballWidth = (300-(kBallCountOfRow-1)*5)/kBallCountOfRow;
        
    }else{
        
        ballWidth = kBallWidth;
    }
    
    NSInteger rowCount = 0;
    
    if ( ballCount % kBallCountOfRow == 0) {
        
        rowCount  =  ballCount / kBallCountOfRow;
        
    }else{
        
        rowCount = ballCount / kBallCountOfRow +1;
        
    }
    
    return (ballWidth + kBallDistanceY)*rowCount + kBallDistanceY + 40 + 10;
}

- (void)setSelectedBallView{
    
    /*
     Notes：
     计算球之间的距离
     如果，球的距离小于5，那么将球的大小置为距离为5的最大宽度。
     否则，球的直径为kBallWidth，距离为计算的结果。
     */
    
    CGFloat ballWidth = 0;
    
    CGFloat distance = (300 - kBallCountOfRow*kBallWidth) /(kBallCountOfRow -1);
    
    if (distance<5) {
        
        distance = 5;
        
        ballWidth = (300-(kBallCountOfRow-1)*5)/kBallCountOfRow;
        
    }else{
        
        ballWidth = kBallWidth;
    }
    
    NSInteger rowCount = 0;
    
    if ( ballCount_ % kBallCountOfRow == 0) {
        
        rowCount  =  ballCount_ / kBallCountOfRow;
        
    }else{
        
        rowCount = ballCount_ / kBallCountOfRow +1;
        
    }
    
    self.ballView.frame = CGRectMake(10, 0, 300, (ballWidth + kBallDistanceY)*rowCount + kBallDistanceY);
    
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
            
            CGFloat YFrame = (ballWidth + kBallDistanceY)*row + kBallDistanceY;
            
            CGFloat XFrame = (ballWidth + distance)*rowLocation;
            
            UIButton *ballButton = [[BallButton alloc] initWithType:eRedBallType ballNumber:[NSString stringWithFormat:@"%02d", (index + 1)] andDelegate:self.ballSelectDelegate];
            
            ballButton.frame = CGRectMake(XFrame, YFrame, ballWidth, ballWidth);
            
            ballButton.tag = kBallStartTag + index;
            
            ballButton.titleLabel.font = [UIFont systemFontOfSize:15];
            
//            [ballButton addTarget:self action:@selector(ballButtonTag:) forControlEvents:UIControlEventTouchUpInside];
            
            [ballButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [ballButton setTitleColor:selectedFontColor_ forState:UIControlStateSelected];
            
            [ballButton setBackgroundImage:[UIImage imageNamed:selectedImageName_] forState:UIControlStateSelected];
            
            [ballButton setTitleColor:unSelectedFontColor_ forState:UIControlStateNormal];
            
            [ballButton setBackgroundImage:[UIImage imageNamed:unSelectedImageName_] forState:UIControlStateNormal];
            
            if (index+1<10) {
                
                [ballButton setTitle:[NSString stringWithFormat:@"0%d",index+1] forState:UIControlStateNormal];
            }else{
                
                [ballButton setTitle:[NSString stringWithFormat:@"%d",index+1] forState:UIControlStateNormal];
            }
            
            [ballButton setBackgroundColor:[UIColor clearColor]];
            
            [self.ballView addSubview:ballButton];
            
            TT_RELEASE_SAFELY(ballButton);
            
        }
        
    }
    
    [self layoutIfNeeded];
    
}


- (void)setSelectedCountText:(NSInteger)selectedCount
{
    
   self.selectedCountLabel.text = [NSString stringWithFormat:L(@"LOLessChoose"),minNum_,selectedCount];
        
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.randomSelectButton.frame = CGRectMake(10, 53, self.randomSelectButton.width , self.randomSelectButton.height);
    if (IOS7_OR_LATER)
    {
        self.countSelectButton.frame = CGRectMake(self.randomSelectButton.right+20, self.randomSelectButton.top, self.countSelectButton.width, self.countSelectButton.height);
    }
    else
    {
        self.countSelectButton.frame = CGRectMake(self.randomSelectButton.right, self.randomSelectButton.top, self.countSelectButton.width, self.countSelectButton.height);
    }
    
    
    if (IOS7_OR_LATER)
    {
        self.selectedCountLabel.frame = CGRectMake(self.randomSelectButton.frame.origin.x, 80, 160, 35);
    }
    else
    {
        self.selectedCountLabel.frame = CGRectMake(self.countSelectButton.right +20, self.countSelectButton.top-3, 160, 35);
    }
    
    self.ballCountView.frame = CGRectMake(5, self.countSelectButton.bottom, 310, self.ballCountView.height);
    
    if (IOS7_OR_LATER)
    {
        self.ballView.frame = CGRectMake(self.ballView.left, self.randomSelectButton.bottom + 30, self.ballView.width, self.ballView.height);
    }
    else
    self.ballView.frame = CGRectMake(self.ballView.left, self.randomSelectButton.bottom + 10, self.ballView.width, self.ballView.height);
    
    self.backGroudButton.frame = self.frame;
    
}

//#pragma mark -
//#pragma mark Button Tapped Event Method 点击button事件的方法
//
//- (void)ballButtonTag:(id)sender{
//    
//    UIButton *button = (UIButton *)sender;
//    
//    //    DLog(@"buttom tag is %d",button.tag);
//    
//    
//    if (button.selected == NO) {
//        
//            if ( [self.ballSelectDelegate conformsToProtocol:@protocol(SevenLeSelectBallViewDelegate)])
//            {
//                
//                if ([_ballSelectDelegate respondsToSelector:@selector(ballSelect:)] ) {
//                
//                BOOL isValide =  [self.ballSelectDelegate  ballSelect:button.tag-kBallStartTag + 1 ballType:eRedBallType ];
//                
//                if (isValide == YES)
//                {
//                    
//                    button.selected  = !button.isSelected;
//                }
//            }
//        }
//        
//    }else{
//        
//        if ( [self.ballSelectDelegate conformsToProtocol:@protocol(SevenLeSelectBallViewDelegate)]) {
//            
//            if ([self.ballSelectDelegate respondsToSelector:@selector(ballUnselect:) ]) {
//                
//                BOOL isValide =  [self.ballSelectDelegate  ballUnselect:button.tag - kBallStartTag + 1 ballUnselect:eRedBallType];
//                
//                if (isValide == YES) {
//                    
//                    button.selected  = !button.isSelected;
//                    
//                }
//            }
//        }
//    }
//}
//

- (void)excuteRandomSelect:(id)sender{
    
    if ( [self.ballSelectDelegate conformsToProtocol:@protocol(SevenLeSelectBallViewDelegate)]) {
        
        if ([self.ballSelectDelegate respondsToSelector:@selector(randomBallSelect:) ]) {
            
            [self.ballSelectDelegate randomBallSelect:ballRandomSelectCount_];
        }
    }
}

- (void)excuteCountSelect:(id)sender{
    
    if (self.countSelectButton.selected == YES) {
        
        self.countSelectButton.selected = NO;
        
        if ([self.ballCountView superview]!= nil) {
            
            [self.ballCountView removeFromSuperview];
            
            [self.backGroudButton removeFromSuperview];
        }
        
    }else{
        
        self.countSelectButton.selected = YES;
        
        if ([self.ballCountView superview] == nil) {
            
            [self addSubview:self.ballCountView];
            
            [self insertSubview:self.backGroudButton belowSubview:self.ballCountView];
        }
    }
}

- (void)chooseBallCount:(NSInteger)ballCount{
    
    if ( [self.ballSelectDelegate conformsToProtocol:@protocol(SevenLeSelectBallViewDelegate)]) {
        
        if ([self.ballSelectDelegate respondsToSelector:@selector(ballCountSelect:) ]) {
            
            BOOL isvalide = [self.ballSelectDelegate ballCountSelect:ballCount];
            
            if (isvalide == YES) {
                
                ballRandomSelectCount_ = ballCount;
                
                [self.countSelectButton setTitle:[NSString stringWithFormat:@"%d个",ballCount] forState:UIControlStateNormal];
                
                if ([self.ballCountView superview]!=nil) {
                    
                    self.countSelectButton.selected = NO;
                    
                    [self.ballCountView removeFromSuperview];
                    
                    [self.backGroudButton removeFromSuperview];
                }
            }
        }
    }
}

#pragma mark -
#pragma mark Customize UI Method

- (UIButton *)randomSelectButton{
    
    if (!_randomSelectButton) {
        
        CGRect rect = CGRectMake(0, 0, 70, 30);
        if (IOS7_OR_LATER)
        {
            rect = CGRectMake(15, 0, 100, 30);
        }
        _randomSelectButton = [[UIButton alloc] initWithFrame:rect];
        
        [_randomSelectButton addTarget:self action:@selector(excuteRandomSelect:) forControlEvents:UIControlEventTouchDown];
        //UIImage *image = nil;
        //if (IOS7_OR_LATER)
        {
            [_randomSelectButton setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
            
            [_randomSelectButton setTitleColor:[UIColor light_Black_Color] forState:UIControlStateHighlighted];
            _randomSelectButton.backgroundColor = [UIColor whiteColor];
            
            _randomSelectButton.layer.borderColor = [UIColor orange_Light_Color].CGColor;
            
            _randomSelectButton.layer.borderWidth = 1;
        }
//        else
//        {
//            image = [UIImage imageNamed:@"LotteryRandom_Button_Unselected.png"];
//            UIImage *strechedImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
//            
//            [_randomSelectButton setBackgroundImage:strechedImage forState:UIControlStateNormal];
//            [_randomSelectButton setTitleColor:[UIColor darkGrownColor] forState:UIControlStateNormal];
//        }
        
        _randomSelectButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        
        _randomSelectButton.titleLabel.textAlignment = UITextAlignmentCenter;
        
        _randomSelectButton.selected = NO;
        
        _randomSelectButton.titleLabel.shadowColor = [UIColor whiteColor];
        
        _randomSelectButton.backgroundColor = [UIColor clearColor];
        
        [_randomSelectButton setTitle:L(@"Machine election") forState:UIControlStateNormal];
        
        [self addSubview:_randomSelectButton];
        
    }
    
    return _randomSelectButton;
    
}


- (UIButton *)countSelectButton{
    
    if (!_countSelectButton) {
        
        if (IOS7_OR_LATER)
        {
            _countSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 0, 100, 30)];
        }
        else
        {
            _countSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        }
        
        [_countSelectButton addTarget:self action:@selector(excuteCountSelect:) forControlEvents:UIControlEventTouchDown];
        if (IOS7_OR_LATER)
        {
            [_countSelectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0,0 )];
            
            [_countSelectButton setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
            [_countSelectButton setImage:[UIImage imageNamed:@"arrow_bottom_gray"] forState:UIControlStateNormal];
            [_countSelectButton setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
            
            [_countSelectButton setTitleColor:[UIColor light_Black_Color] forState:UIControlStateHighlighted];
            _countSelectButton.backgroundColor = [UIColor whiteColor];
            
            _countSelectButton.layer.borderColor = [UIColor orange_Light_Color].CGColor;
            
            _countSelectButton.layer.borderWidth = 1;
        }
        else
        {
            [_countSelectButton setBackgroundImage: [UIImage imageNamed:@"LotteryCount_Button_Unselected.png"] forState:UIControlStateNormal];
            
            [_countSelectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,10 )];
            [_countSelectButton setTitleColor:[UIColor darkGrownColor] forState:UIControlStateNormal];
            [_countSelectButton.layer setCornerRadius:10];
            _countSelectButton.backgroundColor = [UIColor clearColor];
        }
        
        
        [self.countSelectButton setTitle:[NSString stringWithFormat:@"%d%@",minNum_,L(@"Number")] forState:UIControlStateNormal];
        
        _countSelectButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        
        _countSelectButton.titleLabel.textAlignment = UITextAlignmentCenter;
        
        
        
       
        
        [self addSubview:_countSelectButton];
        
    }
    
    return _countSelectButton;
    
    
}

- (UIView *)ballView{
    
    if (!_ballView) {
        
        _ballView = [[UIView alloc] init];
        
        _ballView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_ballView];
        
    }
    
    return _ballView;
    
}


-(UIButton *)backGroudButton{
    
    if (!_backGroudButton) {
        
        _backGroudButton = [[UIButton alloc] init];
        
        _backGroudButton.alpha = 0.5;
        
        _backGroudButton.backgroundColor = [UIColor blackColor];
        
        [_backGroudButton addTarget:self action:@selector(hideBallCountView:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _backGroudButton;
    
}

- (void)hideBallCountView:(id)sender{
    
    if ([self.ballCountView superview]!=nil) {
        
        self.countSelectButton.selected = NO;
        
        [self.ballCountView removeFromSuperview];
        
        [self.backGroudButton removeFromSuperview];
        
    }
}

- (void)removeView
{
    if ([self.ballCountView superview]!=nil) {
        
        self.countSelectButton.selected = NO;
        
        [self.ballCountView removeFromSuperview];
        
        [self.backGroudButton removeFromSuperview];
        
    }

}

-(LotteryBallCountChooseView *)ballCountView{
    
    if (!_ballCountView) {
        
        _ballCountView = [[LotteryBallCountChooseView alloc] init];
        
        _ballCountView.backgroundColor = [UIColor clearColor];
        
        _ballCountView.ballCountDelegate = self;
        
        _ballCountView.userInteractionEnabled = YES;
        
    }
    
    return _ballCountView;
}


-(UILabel *)selectedCountLabel{
    
    if (!_selectedCountLabel) {
        
        _selectedCountLabel = [[UILabel alloc] init];
        
        _selectedCountLabel.font = [UIFont systemFontOfSize:12];
        
        _selectedCountLabel.textAlignment = UITextAlignmentLeft;
        
        _selectedCountLabel.textColor = RGBCOLOR(102.0, 51.0, 51.0);
        
        _selectedCountLabel.backgroundColor = [UIColor clearColor];
        
        _selectedCountLabel.adjustsFontSizeToFitWidth = YES;
        
        _selectedCountLabel.shadowColor = [UIColor whiteColor];
        
        _selectedCountLabel.shadowOffset = CGSizeMake(-1, 0);
        
        _selectedCountLabel.numberOfLines = 2;
        
        [self addSubview:_selectedCountLabel];
        
    }
    return _selectedCountLabel;
}


@end
