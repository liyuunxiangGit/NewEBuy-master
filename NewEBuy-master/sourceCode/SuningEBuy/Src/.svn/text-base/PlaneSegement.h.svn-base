//
//  PlaneSegement.h
//  SuningEBuy
//
//  Created by david on 14-1-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaneSegementDelegate;


@interface PlaneSegement : UIView

@property(nonatomic,weak)id<PlaneSegementDelegate> delegate;

@property(nonatomic,strong) UIButton    *oneButton;
@property(nonatomic,strong) UIButton    *twoButton;
@property(nonatomic,strong) UIImageView *oneLine;
@property(nonatomic,strong) UIImageView *twoLine;
@property(nonatomic,strong) UIImageView *verticalLine;

-(id)initWithLeftItem:(NSString *)leftItem
            rightItem:(NSString *)rightItem;

-(void)setCheckedIndex:(NSInteger)index;

@end


@protocol PlaneSegementDelegate <NSObject>

-(void)planeSegement:(NSInteger)buttonIndex;

@end

