//
//  TopRecommentCell.h
//  SuningEBuy
//
//  Created by cw on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTopRecommendDTO.h"

#import "DataProductBasic.h"

@interface TopRecommentCell : UITableViewCell<EGOImageViewExDelegate>
{

    BOOL isLeftProduct;
    
    HomeTopRecommendDTO     *_leftDTO;
    HomeTopRecommendDTO     *_rightDTO;

}

@property (nonatomic,strong) UILabel *leftProductNameLbl;
@property (nonatomic,strong) UILabel *leftPriceLbl;
@property (nonatomic,strong) UILabel *rightProductNameLbl;
@property (nonatomic,strong) UILabel *rightPriceLbl;

@property (nonatomic,strong) HomeTopRecommendDTO *leftDTO;
@property (nonatomic,strong) HomeTopRecommendDTO *rightDTO;

@property (nonatomic,strong) EGOImageViewEx *leftImage;
@property (nonatomic,strong) EGOImageViewEx *rightImage;


-(void) setItem:(HomeTopRecommendDTO *)leftDto rightItem:(HomeTopRecommendDTO *)rightDto;
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
-(void)loadLeftOrRightItem:(HomeTopRecommendDTO *)dto isLeft:(BOOL)isLeft;
@end
