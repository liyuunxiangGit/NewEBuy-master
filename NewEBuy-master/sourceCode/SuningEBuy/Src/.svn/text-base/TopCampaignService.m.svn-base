//
//  TopCampaignService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "TopCampaignService.h"
#import "StoreCampaignDTO.h"

@implementation TopCampaignService

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_campaignListArr);
    
}

- (void)httpMsgRelease
{
    
    HTTPMSG_RELEASE_SAFELY(campaignListHttpMsg);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        _campaignListArr = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}


- (void)getCampaignListWithCityId:(NSString *)cityId
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(cityId)?@"":cityId forKey:@"cityId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@.html",kEbuyWapHostURL,kACTopCampaignList,cityId];
    
    HTTPMSG_RELEASE_SAFELY(campaignListHttpMsg);
    
    campaignListHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_TopCampaignList];
    campaignListHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:campaignListHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_TopCampaignList)
    {
        [_serviceDelegate getTopCampaignList:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"msg"];
    
    if (receiveMsg.cmdCode == CC_TopCampaignList)
    {
        if ([[item objectForKey:@"code"] isEqualToString:@"1"])
        {
            NSMutableArray *list = [item objectForKey:@"data"];
            
            [self.campaignListArr removeAllObjects];
                
            for (int i =0; i<[list count]; i++)
            {
                StoreCampaignDTO *dto  =[[StoreCampaignDTO alloc]init];
                    
                [dto encodeFromDictionary:[list objectAtIndex:i]];
                    
                [self.campaignListArr addObject:dto];
            }
                
            [_serviceDelegate getTopCampaignList:self isSuccess:YES errorMsg:self.errorMsg];
            
        }
        else
        {
            [_serviceDelegate getTopCampaignList:self isSuccess:NO errorMsg:self.errorMsg];
        }
    }
    
}

@end
