//
//  ProductAppraisalViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "DataProductBasic.h"
#import "EditNicknameViewController.h"
#import "AuthManagerNavViewController.h"
#import "ProductAppraisalService.h"


#define kHttpRequestGoodAppraisal   @"good"
#define kHttpRequestMidAppraisal    @"mid"
#define kHttpRequestLackAppraisal   @"lack"


@interface ProductAppraisalViewController : PageRefreshTableViewController<EditNicknameDelegate,ProductAppraisalServiceDelegate>
{
@private
    UITableView         *tableView_;
    
    UISegmentedControl  *_appraisalSegment;
    
    NSString            *_type;
    
    NSString            *_isEvaluatable;
    
    BOOL                isListLoaded;
    
}   

@property(nonatomic,strong)ProductAppraisalService *productAppraisalService;
@property(nonatomic,copy) NSString    *type;
@property (nonatomic,strong)NSMutableArray *appraseBtnArray;
@property (nonatomic,strong)UIView *headView;

- (id)initWithProductBasicDTO:(DataProductBasic *)productBasc;

- (void)sendHttpRequest;

/*
 *author:zhaofk
 *date:2012-8-14
 *discription:判断本地用户信息是否包含“昵称”
 *return：有昵称：YES；无昵称：NO
 */
-(BOOL)isNickNameNilOrNot;

-(void)loadAppraseView;
@end
