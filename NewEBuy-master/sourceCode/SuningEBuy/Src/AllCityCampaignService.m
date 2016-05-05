//
//  AllCityCampaignService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllCityCampaignService.h"
#import "StoreCampaignDTO.h"

@implementation AllCityCampaignService

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


- (void)getAllCityCampaignListWithCityId:(NSString *)cityId
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(cityId)?@"":cityId forKey:@"cityId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@.html",kEbuyWapHostURL,kACCampaignList,cityId];
    
    HTTPMSG_RELEASE_SAFELY(campaignListHttpMsg);
    
    campaignListHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_CampaignList];
    campaignListHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:campaignListHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_CampaignList)
    {
        [_serviceDelegate getAllCityCampaignList:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"msg"];
    
    if (receiveMsg.cmdCode == CC_CampaignList)
    {
        if ([[item objectForKey:@"code"] isEqualToString:@"1"])
        {
            NSMutableArray *list = [item objectForKey:@"data"];
            
            if (IsArrEmpty(list))
            {
                self.errorMsg =L(@"NearnySuning_NoActivityInLocalArea");
                
                [_serviceDelegate getAllCityCampaignList:self isSuccess:NO errorMsg:self.errorMsg];
            }
            else
            {
                [self.campaignListArr removeAllObjects];
                
                for (int i =0; i<[list count]; i++)
                {
                    StoreCampaignDTO *dto  =[[StoreCampaignDTO alloc]init];
                    
                    [dto encodeFromDictionary:[list objectAtIndex:i]];
                    
                    [self.campaignListArr addObject:dto];
                }
                
                [_serviceDelegate getAllCityCampaignList:self isSuccess:YES errorMsg:self.errorMsg];
            }
        }
        else
        {
            [_serviceDelegate getAllCityCampaignList:self isSuccess:NO errorMsg:self.errorMsg];
        }
    }
    
}

@end
