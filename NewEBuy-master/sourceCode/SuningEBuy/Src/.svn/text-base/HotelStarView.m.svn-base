//
//  HotelStarView.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelStarView.h"

#define kStarSizeWidth   12
#define kStarSizeHeight  12
#define kStarFrameWith   12
#define kStarSpaceWidth  8
@interface HotelStarView()

@property (nonatomic, strong) UIImageView *star1;
@property (nonatomic, strong) UIImageView *star2;
@property (nonatomic, strong) UIImageView *star3;
@property (nonatomic, strong) UIImageView *star4;
@property (nonatomic, strong) UIImageView *star5;

@end


@implementation HotelStarView

@synthesize star1 = star1_;
@synthesize star2 = star2_;
@synthesize star3 = star3_;
@synthesize star4 = star4_;
@synthesize star5 = star5_;

- (void)dealloc
{
    
    TTVIEW_RELEASE_SAFELY(star1_);
    TTVIEW_RELEASE_SAFELY(star2_);
    TTVIEW_RELEASE_SAFELY(star3_);
    TTVIEW_RELEASE_SAFELY(star4_);
    TTVIEW_RELEASE_SAFELY(star5_);
    
}

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        
    }
    
    return self;
    
    
}

- (void)setStarsImages:(NSString *)evaluation
{
    
    CGFloat evaValue = 0;
    
    if (evaluation != nil || ![evaluation isEqualToString:@""])
    {
        evaValue = [evaluation floatValue];
    }
    
    for (int i = 0; i < 5; i++)
    {
        NSString *selecter = [NSString stringWithFormat:@"star%d", i+1];
        
        SuppressPerformSelectorLeakWarning
        (UIImageView *star = [self performSelector:NSSelectorFromString(selecter)];
         if (evaValue-i < 0.5)
         {
             star.image = [UIImage imageNamed:@"gray_star@2x.png"];
         }
         else if (evaValue-i >= 0.5 && evaValue-i < 1)
         {
             star.image = [UIImage imageNamed:@"half_star@2x.png"];
         }
         else if (evaValue-i >= 1)
         {
             star.image = [UIImage imageNamed:@"orange_star@2x.png"];
         });
        
        
        
    }
}


-(UIImageView *)star1
{
    
    if (!star1_) {
        star1_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kStarSizeWidth, kStarSizeHeight)];
        star1_.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview: star1_];
    }
    
    return star1_;
}

- (UIImageView *)star2
{
    
    if (!star2_) {
        star2_ = [[UIImageView alloc] initWithFrame:CGRectMake(kStarFrameWith+kStarSpaceWidth, 0, kStarSizeWidth, kStarSizeHeight)];
        star2_.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview: star2_];
    }
    
    return star2_;
}

- (UIImageView *)star3
{
    
    if (!star3_) {
        star3_ = [[UIImageView alloc] initWithFrame:CGRectMake(kStarFrameWith*2+kStarSpaceWidth*2, 0, kStarSizeWidth, kStarSizeHeight)];
        star3_.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview: star3_];
    }
    
    return star3_;
}

-(UIImageView *)star4
{
    
    if (!star4_) {
        star4_ = [[UIImageView alloc] initWithFrame:CGRectMake(kStarFrameWith*3+kStarSpaceWidth*3, 0, kStarSizeWidth, kStarSizeHeight)];
        star4_.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview: star4_];
    }
    
    return star4_;
}

-(UIImageView *)star5
{
    
    if (!star5_) {
        star5_ = [[UIImageView alloc] initWithFrame:CGRectMake(kStarFrameWith*4+kStarSpaceWidth*4, 0, kStarSizeWidth, kStarSizeHeight)];
        star5_.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview: star5_];
    }
    
    return star5_;
}

@end

