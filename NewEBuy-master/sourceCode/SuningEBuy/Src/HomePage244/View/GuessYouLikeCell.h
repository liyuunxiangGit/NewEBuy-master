//
//  GuessYouLikeCell.h
//  SuningEBuy
//
//  Created by GUO on 14-10-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuessDataDTO.h"

@protocol GuessYouLikeCellDelegate;

@interface GuessYouLikeCell : UITableViewCell<EGOImageViewDelegate,EGOImageViewExDelegate>

@property (nonatomic,strong) EGOImageViewEx                *leftBackgroundImageView;
@property (nonatomic,strong) EGOImageViewEx                *rightBackgroundImageView;
@property (nonatomic,strong) EGOImageViewEx             *leftImageView;
@property (nonatomic,strong) EGOImageViewEx             *rightImageView;
@property (nonatomic,strong) UILabel                    *leftNameLabel;
@property (nonatomic,strong) UILabel                    *rightNameLabel;
@property (nonatomic,strong) UILabel                    *leftPriceLabel;
@property (nonatomic,strong) UILabel                    *rightPriceLabel;
@property (nonatomic,strong) UIButton                   *leftButton;
@property (nonatomic,strong) UIButton                   *rightButton;
@property (nonatomic,strong) GuessDataDTO               *leftDto;
@property (nonatomic,strong) GuessDataDTO               *rightDto;
@property (nonatomic,strong) UILabel                    *leftHintLabel;
@property (nonatomic,strong) UILabel                    *rightHintLabel;

@property (nonatomic, assign) id<GuessYouLikeCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setViewWithleftDto:(GuessDataDTO *)leftDto rightDto:(GuessDataDTO *)rightDto;

@end

@protocol GuessYouLikeCellDelegate <NSObject>

@optional
- (void)didSelectGuessYouLikeList:(GuessDataDTO *)dto;

@end