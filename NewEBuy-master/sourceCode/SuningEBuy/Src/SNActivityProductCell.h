//
//  SNActivityProductCell.h
//  SuningEBuy
//
//  Created by 家兴 王 on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNActivityProductDTO.h"
#import "SNTouchView.h"

#import "UITableViewCellEx.h"
#import "ProductDetailViewController.h"
#import "BBVerticalAlignmentLabel.h"

@interface SNActivityProductCell : UITableViewCellEx<EGOImageViewExDelegate>
{
    
    BOOL isLeftProduct;
    
    SNActivityProductDTO     *_leftDTO;
    SNActivityProductDTO     *_rightDTO;
    SNActivityProductDTO     *_centerDTO;

    
    SNActivityProductDTO     *_bigCenterDTO;
    
    SNActivityProductDTO     *_smallCenterDTO;
    
}
@property (nonatomic,strong) BBVerticalAlignmentLabel *centerProductNameLbl;
@property (nonatomic,strong) UILabel *centerPriceLbl;
@property (nonatomic,strong) BBVerticalAlignmentLabel *leftProductNameLbl;
@property (nonatomic,strong) UILabel *leftPriceLbl;
@property (nonatomic,strong) BBVerticalAlignmentLabel *rightProductNameLbl;
@property (nonatomic,strong) UILabel *rightPriceLbl;
@property (nonatomic,strong) BBVerticalAlignmentLabel *bigCenterProductNameLbl;
@property (nonatomic,strong) UILabel *bigCenterPriceLbl;
@property (nonatomic,strong) BBVerticalAlignmentLabel *smallCenterProductNameLbl;
@property (nonatomic,strong) UILabel *smallCenterPriceLbl;

@property (nonatomic,strong) SNActivityProductDTO *centerDTO;
@property (nonatomic,strong) SNActivityProductDTO *leftDTO;
@property (nonatomic,strong) SNActivityProductDTO *rightDTO;
@property (nonatomic,strong) SNActivityProductDTO *bigCenterDTO;
@property (nonatomic,strong) SNActivityProductDTO *smallCenterDTO;

@property (nonatomic,strong) EGOImageViewEx *centerImage;
@property (nonatomic,strong) EGOImageViewEx *leftImage;
@property (nonatomic,strong) EGOImageViewEx *rightImage;
@property (nonatomic,strong) EGOImageViewEx *bigCenterImage;
@property (nonatomic,strong) EGOImageViewEx *smallCenterImage;

@property (nonatomic,strong) UIImageView *salesCenterMiddleImage;
@property (nonatomic,strong) UIImageView *salesBigImage;
@property (nonatomic,strong) UIImageView *salesLeftMiddleImage;
@property (nonatomic,strong) UIImageView *salesRightMiddleImage;
@property (nonatomic,strong) UIImageView *salesSmallImage;

@property (nonatomic,strong) UIImageView *centerBgImage;
@property (nonatomic,strong) UIImageView *leftBgImage;
@property (nonatomic,strong) UIImageView *rightBgImage;
@property (nonatomic,strong) UIImageView *smallBgImage;


@property (nonatomic,strong)UILabel *salesBigBangNameLbl;
@property (nonatomic,strong)UILabel *salesSmallBangNameLbl;

@property (nonatomic,strong)UILabel *salesLeftBigBangNameLbl;
@property (nonatomic,strong)UILabel *salesRightBigBangNameLbl;




-(void) setBigCenterItem:(SNActivityProductDTO *)bigCenterDto;
-(void) setSmallCenterItem:(SNActivityProductDTO *)smallCenterDto;

-(void)setItem:(SNActivityProductDTO *)leftDto rightItem:(SNActivityProductDTO *)rightDto;
- (void) setItem:(SNActivityProductDTO *)leftDto  rightItem:(SNActivityProductDTO *)rightDto withTag:(NSInteger)index;


-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

-(void)loadLeftOrRightItem:(SNActivityProductDTO *)dto isLeft:(BOOL)isLeft;
-(void)loadBigCenterItem:(SNActivityProductDTO *)bigCenterDto;
-(void)loadSmallCenterItem:(SNActivityProductDTO *)smallCenterDto;

//-(void)loadLeftOrRightOrMidItem:(SNActivityProductDTO *)dto isLeft:(BOOL)isLeft isMiddle:(BOOL)isMiddle isRight:(BOOL)isRight;//新增

+ (CGFloat)height:(NSInteger)sortType;
@end
