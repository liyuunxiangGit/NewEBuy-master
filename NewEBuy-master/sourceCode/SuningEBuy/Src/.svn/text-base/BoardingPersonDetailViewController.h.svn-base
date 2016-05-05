//
//  BoardingPersonDetailViewController.h
//  SuningEBuy
//
//  Created by david on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "BoardingInfoDTO.h"
#import "PlaneSegement.h"
#import "BoardingItemCell.h"
#import "BoardingFootView.h"
#import "BoardingService.h"


@protocol BoardingPersonDetailViewControllerDelegate;

@interface BoardingPersonDetailViewController : CommonViewController<PlaneSegementDelegate,BoardingDelegate>{
    
    BOOL    isAdult;
    
    BOOL    isSuccess;
}

@property(nonatomic,copy)              NSString   *dengjiTime;
@property(nonatomic,strong)            BoardingInfoDTO *boardingInfoDto;
@property(nonatomic,strong)            NSArray    *certiList;
@property(nonatomic,strong)            BoardingService  *newBoardingService;
@property(nonatomic,weak) id<BoardingPersonDetailViewControllerDelegate> delegate;

@end


@protocol BoardingPersonDetailViewControllerDelegate <NSObject>

-(void)addBoardingPersonInformation:(BoardingInfoDTO *)dto;

-(void)modifyBoardingPersonInformation:(BoardingInfoDTO *)dto;


@end