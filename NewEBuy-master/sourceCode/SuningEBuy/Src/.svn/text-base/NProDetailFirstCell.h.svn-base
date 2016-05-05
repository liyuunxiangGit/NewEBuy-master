//
//  NProDetailFirstCell.h
//  SuningEBuy
//
//  Created by xmy on 18/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"
#import "MyPageControl.h"

#import "NDetailHeadProImages.h"

@class NProDetailFirstCell;
@protocol NProDetailFirstCellDelegate <NSObject>

- (void)activetyBtnAction;

- (void)addToFavorite;

- (void)touchImages;

- (void)gotoShare;

@end

@interface NProDetailFirstCell : UITableViewCell
{
//    NSInteger currentPageNumber;
}

@property (nonatomic, assign)id<NProDetailFirstCellDelegate>delegate;

@property (nonatomic, assign)ProductDeatailType type;  

//@property (nonatomic, retain)MyPageControl *myPageControl;

@property (nonatomic, retain)UILabel *productNameLbl;//商品名

@property (nonatomic, retain)UIButton *collectBtn; // 收藏按钮

@property (nonatomic, strong) UIButton  *shareBtn; // 分享按钮

@property (nonatomic, retain)UIImageView *backView;

@property (nonatomic, retain)NDetailHeadProImages *proImagesScroll;

@property (nonatomic, retain)UIImageView *qiangOrTuanImageView;//抢购／团购详情需贴上抢（团）标签

@property (nonatomic,retain)UIButton *activetyImageV;//抢购或团购

@property (nonatomic,retain)UILabel *activetyPriceLbl;

@property (nonatomic,retain)DataProductBasic *nDto;
@property (nonatomic,retain)NSString *collectFlag;

@property (nonatomic, retain)UIImageView *proNameBackView;

//type 1为普通 2为抢购 3为团购
- (void)setNProDetailFirstCell:(DataProductBasic*)dto WithCollectFlag:(NSString*)collectFlag WithType:(ProductDeatailType)type;

+ (CGFloat)NProDetailFirstCellHeight:(DataProductBasic*)dataDto WithMore:(BOOL)isMore;

@end
