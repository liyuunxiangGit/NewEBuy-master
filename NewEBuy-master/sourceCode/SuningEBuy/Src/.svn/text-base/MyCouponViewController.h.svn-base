//
//  MyCouponViewController.h
//  SuningEBuy
//
//  Created by xingxianping on 13-8-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "MYEbuyCouponCell.h"
#import "TotalAmountCell.h"
#import "MYEbuyCoumonDTO.h"
#import "PageRefreshTableViewController.h"
#import "GetAllSysInfo.h"
#import "serialNumberCell.h"
#import "ExCouponDto.h"
#import "UserDiscountService.h"
#import "ExCouponCell.h"
#import "MyCouponSerivce.h"
#import "SegmentedView.h"
#import "UpSegmentView.h"
#import "GetRedPackSuccessViewController.h"

#import "CustomSegment.h"

#import "EbuyQuanCell.h"

#define kLeftButtonHighlightImage       @"search_fouce_left.png"
#define kRightButtonHighlightImage      @"search_fouce_right.png"

#define kButtonNormalImage  @"search_normal_new.png"

@interface MyCouponViewController : PageRefreshTableViewController
<MyCouponServiceDelegate,UserDiscountServiceDelegate,SegmentBtnClickedDelegate,UpSegmentDelegate,CustomSegmentDelegate,EbuyQuanCellDelegate>

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) UILabel *norecordLbl;

@property (nonatomic, strong) UIView *loadMoreView;

@property (nonatomic, strong) UpSegmentView *upSegement;

@property (nonatomic, strong) SegmentedView *segmentView;

@property (nonatomic, strong) MyCouponSerivce     *myCouponService;

@property (nonatomic, strong) UserDiscountService  *userDiscountService;

@property (nonatomic, strong) NSMutableArray *myCouponList;

@property (nonatomic, strong) NSString *totalAmount;

@property (nonatomic, assign) NSInteger   state;

@property (nonatomic, strong) MYEbuyCoumonDTO *selectMyCouponDTO;

@property (nonatomic, strong) CustomSegment *segment;

- (id)initWithTotalAmount:(NSString *)totalAmount;

@end
