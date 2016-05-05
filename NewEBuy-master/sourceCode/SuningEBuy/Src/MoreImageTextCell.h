//
//  MoreImageTextCell.h
//  SuningEBuy
//
//  Created by xingxianping on 13-7-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BigImageTypeDTO.h"

@protocol ImageButtonClickedDelegate <NSObject>

- (void)buttonClicked:(NSString *)infoId andSize:(NSString *)size;

@end

@interface MoreImageTextCell : UITableViewCell

@property (nonatomic,strong) EGOImageView *bigImage;
@property (nonatomic,strong) UILabel *bigTitle;
@property (nonatomic,strong) UIView  *titleBg;
@property (nonatomic,strong) UIImageView *separatorLine1;
@property (nonatomic,strong) UIButton *backBtn1;

@property (nonatomic,strong) EGOImageView *image1;
@property (nonatomic,strong) UILabel *title1;
@property (nonatomic,strong) UIImageView *separatorLine2;
@property (nonatomic,strong) UIButton *backBtn2;

@property (nonatomic,strong) EGOImageView *image2;
@property (nonatomic,strong) UILabel *title2;
@property (nonatomic,strong) UIImageView *separatorLine3;
@property (nonatomic,strong) UIButton *backBtn3;

@property (nonatomic,strong) EGOImageView *image3;
@property (nonatomic,strong) UILabel *title3;
@property (nonatomic,strong) UIButton *backBtn4;
@property (nonatomic,strong) UIImageView *separatorLine4;

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic, assign) id<ImageButtonClickedDelegate> delegate;

- (void)setData:(NSArray *)arr;
@end
