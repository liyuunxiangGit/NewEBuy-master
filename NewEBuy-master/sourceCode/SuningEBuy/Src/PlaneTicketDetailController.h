//
//  PlaneTicketDetailController.h
//  SuningEBuy
//
//  Created by david on 14-2-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "PFOrderBasicDTO.h"
#import "PFOrderDetailDTO.h"
#import "PlanTicketService.h"
#import "AirLineCell.h"
#import "PlaneOneButtonCell.h"


@interface PlaneTicketDetailController : CommonViewController<PlanTicketOrderDelegate,AirLineCellDelegate,PlaneOneButtonCellDelegate>{
    
    BOOL        isDataLoaded;
}

@property (nonatomic,strong) PlanTicketService *ticketService;
@property (nonatomic,assign) BOOL              *isLoadOk;

- (id)initWithBasicOrderDTO:(PFOrderBasicDTO *)basicDto;


@end
