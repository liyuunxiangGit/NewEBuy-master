//
//  HotelIntroduceTitelCell.h
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//酒店详情头View

#import <Foundation/Foundation.h>



#import "HotelIntroduceDTO.h"

#import "HotelStarView.h"

@interface HotelIntroduceTitelCell : UIView
{
    
}

@property (nonatomic, strong)EGOImageView *productImageView;

@property (nonatomic, strong) UILabel *numberLbl;

@property (nonatomic, strong) UILabel *addressLbl;

@property (nonatomic, strong) UILabel *starLevelLbl;

@property (nonatomic, strong) HotelStarView *starView;

//@property (nonatomic, strong) UISegmentedControl *changeEventSegment;

@property (nonatomic, strong) UIButton* leftBtn;

@property (nonatomic, strong) UIButton* centerBtn;

@property (nonatomic, strong) UIButton* rightBtn;

@property (nonatomic, strong) HotelIntroduceDTO *merchItemDTO;

@property (nonatomic, strong) UIImageView* lineImageView;
@end