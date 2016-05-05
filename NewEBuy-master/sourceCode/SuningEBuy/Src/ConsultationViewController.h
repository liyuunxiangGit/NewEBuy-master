//
//  ConsultationViewController.h
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "ConsultListDTO.h"
@protocol ConsulDelegate <NSObject>
@optional
- (void)loginViewload:(ConsultListDTO *)dto;
@end
@protocol ConsultationViewDelegate <NSObject>
-(void)ConsultationDelegate;
@end
@interface ConsultationViewController : PageRefreshTableViewController
{
    BOOL                isListLoaded;

}
@property (nonatomic, weak) id<ConsulDelegate> logdelegate;
@property (nonatomic,strong)UILabel *emptyLabel;
@property (nonatomic, weak) id<ConsultationViewDelegate> delegate;
@property (nonatomic,assign) BOOL ismyconsult;
@property (nonatomic,strong) NSMutableArray *consultlist;
@property (nonatomic,strong) SendConsultListDTO *sendcondto;
@property (nonatomic,strong) NSArray  *modelarray;
-(void)sendHttpRequest;
@end
