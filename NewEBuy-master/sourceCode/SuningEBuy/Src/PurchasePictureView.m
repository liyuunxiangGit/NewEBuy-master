//
//  PurchasePictureView.m
//  SuningEBuy
//
//  Created by Xunxiaodong on 13-7-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PurchasePictureView.h"

#define kPurchaseTimeColor     RGBCOLOR(108, 43, 4)

@implementation PurchasePictureView

@synthesize tmButtonOne = _tmButtonOne;
@synthesize tmButtonTwo = _tmButtonTwo;
@synthesize tmButtonThree = _tmButtonThree;
@synthesize tmButtonFour = _tmButtonFour;
@synthesize tmButtonFive = _tmButtonFive;
@synthesize tmButtonSix = _tmButtonSix;
@synthesize tmButtonSeven = _tmButtonSeven;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//       [self addSubview:self.tmButtonOne];
//        [self addSubview:self.tmButtonTwo];
//        [self addSubview:self.tmButtonThree];
//        [self addSubview:self.tmButtonFour];
//        [self addSubview:self.tmButtonFive];
//        [self addSubview:self.tmButtonSix];
//        [self addSubview:self.tmButtonSeven];
        // Initialization code
        self.frame = CGRectMake(143, 43, 150, 30);
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(143, 43, 150, 30);
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_tmButtonOne);
    TT_RELEASE_SAFELY(_tmButtonTwo);
    TT_RELEASE_SAFELY(_tmButtonThree);
    TT_RELEASE_SAFELY(_tmButtonFour);
    TT_RELEASE_SAFELY(_tmButtonFive);
    TT_RELEASE_SAFELY(_tmButtonSix);
    TT_RELEASE_SAFELY(_tmButtonSeven);
    
}

- (UIButton *)tmButtonOne
{
    if (!_tmButtonOne) {
        
        _tmButtonOne = [[UIButton alloc] init];
        _tmButtonOne.tag = 1;
        
//        _tmButtonOne.backgroundColor = [UIColor darkBlueColor];
        _tmButtonOne.frame = CGRectMake(0, 0, 12.5,20 );
        
        [_tmButtonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tmButtonOne.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_tmButtonOne setBackgroundImage:[UIImage imageNamed:@"Purchase_time.png"] forState:UIControlStateNormal];
        [self addSubview:_tmButtonOne];
    }
    return _tmButtonOne;
}

- (UIButton *)tmButtonTwo
{
    if (!_tmButtonTwo) {
        
        _tmButtonTwo = [[UIButton alloc] init];
        _tmButtonTwo.tag = 2;
        
//        _tmButtonTwo.backgroundColor = [UIColor darkBlueColor];
        _tmButtonTwo.frame = CGRectMake(14, 0, 12.5,20 );
        
        [_tmButtonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tmButtonTwo.titleLabel.font = [UIFont systemFontOfSize:14];
       
        [_tmButtonTwo setBackgroundImage:[UIImage imageNamed:@"Purchase_time.png"] forState:UIControlStateNormal];
       
        [self addSubview:_tmButtonTwo];
    }
    return _tmButtonTwo;
}

- (UIButton *)tmButtonThree
{
    if (!_tmButtonThree) {
        
        _tmButtonThree = [[UIButton alloc] init];
        _tmButtonThree.tag = 3;
        
//        _tmButtonThree.backgroundColor = [UIColor darkBlueColor];
        _tmButtonThree.frame = CGRectMake(28, 0, 12.5,20 );
        
        [_tmButtonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tmButtonThree.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_tmButtonThree setBackgroundImage:[UIImage imageNamed:@"Purchase_time.png"] forState:UIControlStateNormal];
      
        [self addSubview:_tmButtonThree];
    }
    return _tmButtonThree;
}

- (UIButton *)tmButtonFour
{
    if (!_tmButtonFour) {
        
        _tmButtonFour = [[UIButton alloc] init];
        _tmButtonFour.tag = 4;
        
//        _tmButtonFour.backgroundColor = [UIColor darkBlueColor];
        _tmButtonFour.frame = CGRectMake(60, 0, 12.5, 20);
        
        [_tmButtonFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tmButtonFour.titleLabel.font = [UIFont systemFontOfSize:14];

        [_tmButtonFour setBackgroundImage:[UIImage imageNamed:@"Purchase_time.png"] forState:UIControlStateNormal];
       
        [self addSubview:_tmButtonFour];
    }
    return _tmButtonFour;
}

- (UIButton *)tmButtonFive
{
    if (!_tmButtonFive) {
        
        _tmButtonFive = [[UIButton alloc] init];
        _tmButtonFive.tag = 5;
        
//        _tmButtonFive.backgroundColor = [UIColor darkBlueColor];
        _tmButtonFive.frame = CGRectMake(74, 0, 12.5, 20);
        
        [_tmButtonFive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tmButtonFive.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_tmButtonFive setBackgroundImage:[UIImage imageNamed:@"Purchase_time.png"] forState:UIControlStateNormal];
        
        [self addSubview:_tmButtonFive];
    }
    return _tmButtonFive;
}

- (UIButton *)tmButtonSix
{
    if (!_tmButtonSix) {
        
        _tmButtonSix = [[UIButton alloc] init];
        _tmButtonSix.tag = 6;
        
//        _tmButtonSix.backgroundColor = [UIColor darkBlueColor];
        _tmButtonSix.frame = CGRectMake(106, 0, 12.5,20 );
        
        [_tmButtonSix setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tmButtonSix.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_tmButtonSix setBackgroundImage:[UIImage imageNamed:@"Purchase_time.png"] forState:UIControlStateNormal];
        
        [self addSubview:_tmButtonSix];
    }
    return _tmButtonSix;
}

- (UIButton *)tmButtonSeven
{
    if (!_tmButtonSeven) {
        
        _tmButtonSeven = [[UIButton alloc] init];
        _tmButtonSeven.tag = 7;
        
//        _tmButtonSeven.backgroundColor = [UIColor darkBlueColor];
        _tmButtonSeven.frame = CGRectMake(120, 0, 12.5,20 );
        
        [_tmButtonSeven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tmButtonSeven.titleLabel.font = [UIFont systemFontOfSize:14];
       
        [_tmButtonSeven setBackgroundImage:[UIImage imageNamed:@"Purchase_time.png"] forState:UIControlStateNormal];
        
        [self addSubview:_tmButtonSeven];
    }
    return _tmButtonSeven;
}

- (void)setTimeString:(NSString *)string
{

    NSString *string1 = [string substringWithRange:NSMakeRange(0, 1)];
    if ([string1 isEqualToString:@"0"])
    {
        self.tmButtonOne.alpha = 0;
        [self.tmButtonOne setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
        self.tmButtonOne.alpha = 1;
        [self.tmButtonOne setTitle:string1 forState:UIControlStateNormal];
    }
    
    NSString *string2 = [string substringWithRange:NSMakeRange(1, 1)];
    [self.tmButtonTwo setTitle:string2 forState:UIControlStateNormal];
    
    NSString *string3 = [string substringWithRange:NSMakeRange(2, 1)];
    [self.tmButtonThree setTitle:string3 forState:UIControlStateNormal];
    
    NSString *string4 = [string substringWithRange:NSMakeRange(3, 1)];
    [self.tmButtonFour setTitle:string4 forState:UIControlStateNormal];
    
    NSString *string5 = [string substringWithRange:NSMakeRange(4, 1)];
    [self.tmButtonFive setTitle:string5 forState:UIControlStateNormal];
    
    NSString *string6 = [string substringWithRange:NSMakeRange(5, 1)];
    [self.tmButtonSix setTitle:string6 forState:UIControlStateNormal];
    
    NSString *string7 = [string substringWithRange:NSMakeRange(6, 1)];
    [self.tmButtonSeven setTitle:string7 forState:UIControlStateNormal];
    
}

-(void)setBtnTitle:(NSString*)str Tag:(int)tag
{
    UIView *view = [self viewWithTag:tag];
    
    UIButton *btn = (UIButton*)view;
    
    if ([str isEqualToString:@""])
    {
        btn.alpha = 0;
    }
    else
    {
        btn.alpha = 1;
    }
    
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
