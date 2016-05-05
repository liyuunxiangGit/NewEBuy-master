//
//  HotelOrderDetailViewController.h
//  SuningEBuy
//
//  Created by Qin on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "BusinessOrderDetailDTO.h"
//
//#import "BusinessOrderCenterListDTO.h"
//
//#import "BusinessOrderDetailCell.h"
//
//#import "LiveingCustomerInfoCell.h"
//
//#import "BusinessContactInfoCell.h"

#import "HotelOrderDetailDTO.h"

#import "HotelOrderListDto.h"

#import "HotelInfoCell.h"
#import "PayInfoCell.h"
#import "ManInfoCell.h"
#import "HotelOrderInfoCell.h"

@interface HotelOrderDetailViewController : CommonViewController
{
    ASIFormDataRequest                  *sendCommendASIHTTPRequest;
    
    BOOL            isLoaderOK;
}

@property (nonatomic, strong) HotelOrderListDto *postDto;

@property (nonatomic, strong) HotelOrderDetailDTO     *parseDto;

@property (nonatomic, strong) UILabel* totle;

@property (nonatomic, strong) UILabel* totlePriceLbl;

//@property (nonatomic, strong) UITableView *vpTableView;

- (void)sendListHttpRequest;

@end
