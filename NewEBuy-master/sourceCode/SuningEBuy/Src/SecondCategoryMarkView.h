//
//  SecondCategoryMarkView.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-10.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "V2SecCategoryDTO.h"


@protocol SecondCategoryMarkViewDelegate <NSObject>

@optional
-(void)topImageView:(id)obj;
@end

@interface SecondCategoryMarkView : UIView

@property (nonatomic, strong) EGOImageButton *iconImageBtn;

@property (nonatomic,weak)id<SecondCategoryMarkViewDelegate> myDelegate;

@property (nonatomic,strong)UILabel *buttomLab;

@property (nonatomic,strong)V2SecCategoryDTO *secDto;


@end
