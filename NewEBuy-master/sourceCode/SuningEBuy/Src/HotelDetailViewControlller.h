//
//  HotelDetailViewControlller.h
//  SuningEBuy
//
//  Created by robin wang on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelOrderBaseViewController.h"

#import "HotelIntroduceDTO.h"

#import "HotelIntroduceTitelCell.h"

#import "HotelDetalRoomTypeDTO.h"

#import "HotelDetalRoomTypeCell.h"

#import "HotelIntroduceViewController.h"

#import "HotelFacilityViewController.h"

#import "HotelDetailImageListDTO.h"

#import "EGOPhotoGlobal.h"
#import "MyPhotoSource.h"
#import "MyPhoto.h"

#import "HotelDataSourceDTO.h"

#import "HotelInfoService.h"


@interface HotelDetailViewControlller : HotelOrderBaseViewController<HotelDetailServiceDelegate>
{
    ASIFormDataRequest  *sendCommendASIHTTPRequest;
    
    ASIFormDataRequest  *sendRoomTypeASIHTTPRequest;
    
    BOOL                isLoaderOK;
    
    BOOL                isRoomTypeOK;
}

@property (nonatomic, strong) HotelDataSourceDTO *postDto;

@property (nonatomic, strong) HotelIntroduceDTO *parseDto;

@property (nonatomic, strong) HotelIntroduceTitelCell *titelView;

@property (nonatomic, strong) NSMutableArray *itemListArr;

@property (nonatomic, strong) UIView *titleBgView;

@property (nonatomic, strong) HotelInfoService *hotelDetailService;

@property (nonatomic, strong) HotelInfoService *hotelRoomTypeService;

- (void)sendListHttpRequest;

- (void)sendRoomTypeHttpRequest;

@end
