//
//  FamilyCell.h
//  SuningEBuy
//
//  Created by li xiaokai on 14-2-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSFFileName         @"SuningFamily"

#define kSFIconKey          @"icon"
#define kSFNameKey          @"name"
#define kSFVersionKey       @"version"
#define kSFDescKey          @"description"
#define kSFIsOwnerKey       @"owner"
#define kSFiTunesUrlKey     @"iTunesUrl"
#define kSFLocalUrlKey      @"localUrl"

@protocol FamilyCellDelegate <NSObject>

@optional

-(void)downApp:(NSDictionary *)familyDic;

@end

@interface FamilyCell : UITableViewCell


@property (nonatomic,assign)id <FamilyCellDelegate> mydelegate;

@property (nonatomic,strong)UIImageView *cellImg;

@property (nonatomic,strong)UILabel *cellTitle;

@property (nonatomic,strong)UILabel *cellDetail;

@property (nonatomic,strong)UIButton *markButton;

@property (nonatomic,strong)NSDictionary *familyDic;


-(void)setUIItem:(NSDictionary *)dic;

@end
