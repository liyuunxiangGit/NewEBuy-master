//
//  MyTicketListViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "PageRefreshTableViewController.h"
#import "TicketOrderFilterViewController.h"
#import "PlanTicketService.h"
#import "TicketListCell.h"

@interface MyTicketListViewController : PageRefreshTableViewController <TicketFilterDelegate,PlanTicketOrderDelegate,TicketListCellDelegate>
{
    ASIFormDataRequest *getListASIHTTPRequest;
    
    BOOL isDataLoaded;
}
@property (nonatomic,assign)BOOL            isFromAllOrderCenter;

@property (nonatomic, strong) NSMutableArray *orderList;
@property (nonatomic, strong) PlanTicketService *ticketOrderService;

@property (nonatomic,strong) UILabel *alertLbl;
@property (nonatomic,strong) UIImageView *alertImageV;

- (void)sendOrderListHttpRequest;

@end
