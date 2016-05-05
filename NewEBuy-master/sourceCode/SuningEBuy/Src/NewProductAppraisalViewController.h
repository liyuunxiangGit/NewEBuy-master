//
//  NewProductAppraisalViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "NewEvalutionService.h"
#import "DataProductBasic.h"
#import "NewProductAppraisalCell.h"

@protocol BackRecordsDelegate ;

@interface NewProductAppraisalViewController : PageRefreshTableViewController<NewEvalutionServiceDelegate>
{
    BOOL                isListLoaded;
}
@property (nonatomic,strong)NSMutableArray *productReviewList;

@property (nonatomic, strong) NewEvalutionService       *evalutionService;

@property (nonatomic, strong) DataProductBasic *productBasic;

@property (nonatomic, weak) id<BackRecordsDelegate> delegate;

- (id)initWithProductBasicDTO:(DataProductBasic *)productBasc;

-(void)sendHttpRequest;

@end

@protocol BackRecordsDelegate <NSObject>

- (void)backRecordsDelegate:(NSString *)recordsNum;

@end