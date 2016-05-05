//
//  LotteryBallCountChooseView.m
//  SuningEBuy
//
//  Created by shasha on 12-6-29.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import "LotteryBallCountChooseView.h"

#define kButtonStartTag     1000

#define kButtonCountOfRow   6

#define kButtonWidth   30

#define kButtonHeight  30

#define kButtonDistanceY  10

@interface LotteryBallCountChooseView () {

    NSInteger buttonCount_;
    
    NSInteger minCount_;

    NSInteger maxCount_;
    
}

@property(nonatomic,strong)UIImageView  *backGroundView;

- (void)setButtonView;

@end

@implementation LotteryBallCountChooseView

@synthesize ballCountDelegate = _ballCountDelegate;

@synthesize backGroundView = _backGroundView;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_backGroundView);
    
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        
    }
    return self;
}

- (void)setMinCount:(NSInteger)minCount maxCount:(NSInteger)maxCount{

    buttonCount_ = maxCount - minCount + 1;
    
    minCount_  = minCount;
    
    maxCount_ = maxCount;
    
    [self addSubview:self.backGroundView];
            
    [self setButtonView];
    
    self.backGroundView.frame = CGRectMake(0, 0, self.width, self.height);

 }

- (UIImageView *)backGroundView{
    
    if (!_backGroundView) {
        
        _backGroundView = [[UIImageView alloc] init];
        
//        UIImage *image = [UIImage imageNamed:@"search_tablePicker_backBorder.png"];
//        
//        UIImage *strechedImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
//        
//        _backGroundView.image = strechedImage;
        
        _backGroundView.backgroundColor = [UIColor whiteColor];
                        
    }

    return _backGroundView;
   

}


/*
 Notes：
 
 计算Button之间的距离
 如果，Button的距离小于5，那么将球的大小置为距离为5的最大宽度。
 否则，Button的宽度为kButtonWidth，距离为计算的结果。
 */  
- (void)setButtonView{
    
    CGFloat buttonWidth = 0;
    
    CGFloat distance = (310 - kButtonCountOfRow*kButtonWidth) /(kButtonCountOfRow +1);
    
    if (distance<5) {
        
        distance = 5;
        
        buttonWidth = (310-(kButtonCountOfRow+1)*5)/kButtonCountOfRow;
        
    }else{
        
        buttonWidth = kButtonWidth;
    }
    
    NSInteger rowCount = 0;
    
    if ( buttonCount_ % kButtonCountOfRow == 0) {
        
        rowCount  =  buttonCount_ / kButtonCountOfRow;
        
    }else{
        
        rowCount = buttonCount_ / kButtonCountOfRow +1;
        
    }
    
    self.frame = CGRectMake(5, 0, 310, (kButtonHeight + kButtonDistanceY)*rowCount + kButtonDistanceY);
       /*
     Notes：
     布Button的位置
     row：从0开始
     rowLocation：从0开始
     */
    
    
    @autoreleasepool {
        
        for (int index=0 ; index < buttonCount_; index ++) {
            
            NSInteger row = 0;
            
            NSInteger rowLocation = 0;
            
            
            if ((index+1)%kButtonCountOfRow == 0) {
                
                row = (index+1) / kButtonCountOfRow - 1;
                
                rowLocation = kButtonCountOfRow - 1;
                
            }else{
                
                row = (index+1) /kButtonCountOfRow ;
                
                rowLocation = (index+1) % kButtonCountOfRow -1 ;
            }
            
            CGFloat YFrame = (kButtonHeight + kButtonDistanceY)*row + kButtonDistanceY;
            
            CGFloat XFrame = (buttonWidth + distance)*rowLocation + distance;
            
            UIButton *numCountButton = [[UIButton alloc] init];
            
            //numCountButton.frame = CGRectMake(XFrame, YFrame, buttonWidth, kButtonHeight);
            numCountButton.frame = CGRectMake(XFrame, YFrame, kButtonHeight, kButtonHeight);
            
            numCountButton.tag = kButtonStartTag + index;
            
            numCountButton.backgroundColor = [UIColor clearColor];
            
            [numCountButton setBackgroundImage:[UIImage imageNamed:@"lottery_grayball"] forState:UIControlStateNormal];
//
//            [numCountButton setBackgroundImage:[UIImage imageNamed:@"blueButton.png"] forState:UIControlStateSelected];
            
            numCountButton.titleLabel.font = [UIFont systemFontOfSize:15];
            
            [numCountButton addTarget:self action:@selector(numCountButtonTag:) forControlEvents:UIControlEventTouchUpInside];
            
            [numCountButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [numCountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [numCountButton setTitle:[NSString stringWithFormat:@"%d",index+minCount_] forState:UIControlStateNormal];
                        
            [self addSubview:numCountButton];
            
            TT_RELEASE_SAFELY(numCountButton);
            
        }
        
    }
    
}

- (void)numCountButtonTag:(id)sender{

    UIButton *countButton = (UIButton *)sender;
  
    NSInteger ballNumCount = countButton.tag - kButtonStartTag + minCount_;
    
    if ([self.ballCountDelegate conformsToProtocol:@protocol(LotteryBallCountChooseViewDelegate)]) {
        
        if ([self.ballCountDelegate respondsToSelector:@selector(chooseBallCount:)]) {
            
            [self.ballCountDelegate chooseBallCount:ballNumCount];
        }
    }
    
}

@end
