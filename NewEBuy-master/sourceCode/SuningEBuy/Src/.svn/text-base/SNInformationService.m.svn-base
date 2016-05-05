//
//  SNInformationService.m
//  SuningEBuy
//
//  Created by xingxianping on 13-7-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNInformationService.h"

@interface SNInformationService()
{
    //    informationDetailDto *detailDto;
}
- (void)informationServiceFinished:(BOOL)isSuccess;

@end
@implementation SNInformationService

@synthesize delegate=_delegate;
@synthesize informationListArray=_informationListArray;
@synthesize detailDto=_detailDto;
@synthesize totalPage=_totalPage;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_informationListArray);
    
    HTTPMSG_RELEASE_SAFELY(informationListHttpMsg);
    
    HTTPMSG_RELEASE_SAFELY(informationDetailHttpMsg);
    
    TT_RELEASE_SAFELY(_detailDto);
        
}

- (NSMutableArray *)informationListArray
{
    if (!_informationListArray) {
        _informationListArray=[[NSMutableArray alloc]init];
    }
    return _informationListArray;
}


- (InformationDetailDto *)detailDto
{
    if (!_detailDto) {
        _detailDto=[[InformationDetailDto alloc] init];
    }
    return _detailDto;
}

- (void)beginInformationListHttpRequest:(NSString *)page
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setObject:@"0" forKey:@"storeId"];
    [dic setObject:@"0" forKey:@"deviceId"];
    [dic setObject:@"0" forKey:@"appId"];
    [dic setObject:@"3" forKey:@"pageSize"];
    [dic setObject:page forKey:@"curPage"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kMobileHostAddress, @"getNoticeInfo.do"];
    
    HTTPMSG_RELEASE_SAFELY(informationListHttpMsg);
    
    informationListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:dic
                                                           cmdCode:CC_InformationList];
    informationListHttpMsg.requestMethod = RequestMethodGet;
    TT_RELEASE_SAFELY(dic);
    
    [self.httpMsgCtrl sendHttpMsg:informationListHttpMsg];
    
}

- (void)beginInformationDetailHttpRequest:(NSString *)infoId
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [dic setObject:@"0" forKey:@"storeId"];
    [dic setObject:infoId forKey:@"infoId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kMobileHostAddress, @"getNoticeDetail.do"];
    
    HTTPMSG_RELEASE_SAFELY(informationDetailHttpMsg);
    
    informationDetailHttpMsg =[[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_InformationDetail];
    informationDetailHttpMsg.requestMethod=RequestMethodGet;
    
    
    TT_RELEASE_SAFELY(dic);
    
    [self.httpMsgCtrl sendHttpMsg:informationDetailHttpMsg];
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_InformationList)
    {
        [self informationServiceFinished:NO];
    }
    else if (receiveMsg.cmdCode ==CC_InformationDetail)
    {
        [self informationServiceFinished:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    NSString *error = [NSString stringWithFormat:@"%@",[item objectForKey:@"errorCode"] ];
    
    
    if (receiveMsg.cmdCode == CC_InformationList)
    {
        if ([error isEqualToString:@"0"]) {
            NSString *total = [NSString stringWithFormat:@"%@",[item objectForKey:@"totalPage"]];
            
            self.totalPage=[total integerValue];

            [self.informationListArray removeAllObjects];
            
            NSArray *listArray=EncodeArrayFromDic(item, @"contentList");
            

            if (!IsArrEmpty(listArray)) {
                for (NSDictionary *items in listArray) {
                    
                    BigImageTypeDTO *listDto=[[BigImageTypeDTO alloc]init];

                    NSString *typeId=[NSString stringWithFormat:@"%@",[items objectForKey:@"typeId"] ];
                    if ([typeId isEqualToString:@"1"]) {
                        
                        [listDto encodeFromDictionary:items];
                        listDto.typeId =typeId;
                        
                        [self.informationListArray addObject:listDto];
                        
                    }
                    else
                    {
                        NSArray *arr=EncodeArrayFromDic(items, @"list");
                        NSMutableArray *array =[[NSMutableArray alloc]init];
                        for (NSDictionary *dic in arr) {
                            listDto.imgUrl=[dic objectForKey:@"imgUrl"];
                            listDto.title=[dic objectForKey:@"title"];
                            listDto.infoId=[dic objectForKey:@"infoId"];
                            [array  addObject:listDto];
                        }
                        [self.informationListArray addObject:array];
                    }
                    
                }
                
                [self informationServiceFinished:YES];
            }
            else
            {
                self.errorMsg=L(@"search records is null");
                [self informationServiceFinished:NO];
            }
        
        }
        else
        {
            self.errorMsg=[item objectForKey:@"errorMessage"];
            
            [self informationServiceFinished:NO];
        }
    }
    else if(receiveMsg.cmdCode ==CC_InformationDetail)
    {
        if ([error isEqualToString:@"0"]) {
            
            NSArray *list = EncodeArrayFromDic(item, @"contentList");
            
            if (!IsArrEmpty(list)) {
                for (NSDictionary *item in list) {
                    InformationDetailDto *dto = [[InformationDetailDto alloc] init];
                    [dto encodeFromDictionary:item];
                    self.detailDto = dto;
                }
                [self informationServiceFinished:YES];
            }
            else
            {
                self.errorMsg=L(@"search records is null");
                [self informationServiceFinished:NO];
            }
            
        }
        else
        {
            self.errorMsg=[item objectForKey:@"errorMessage"];
            
            [self informationServiceFinished:NO];
        }
    }
    
}

- (void)informationServiceFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(informationServiceComplete:isSuccess:)]) {
        [_delegate informationServiceComplete:self isSuccess:isSuccess];
    }
}
@end



@implementation InformationDetailDto

@synthesize publishTime=_publishTime;
@synthesize title=_title;
@synthesize content=_content;
@synthesize infoSource=_infoSource;
@synthesize url=_url;
@synthesize imgUrl=_imgUrl;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_publishTime);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_infoSource);
    TT_RELEASE_SAFELY(_url);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.title = EncodeStringFromDic(dic, @"title");
    self.imgUrl = EncodeStringFromDic(dic, @"imgUrl");
    self.content = EncodeStringFromDic(dic, @"content");
    NSString *time=EncodeStringFromDic(dic, @"publishTime");
    self.publishTime = [NSString stringWithFormat:@"%i%@%@%@",[[time substringWithRange:NSMakeRange(5, 2)]intValue],L(@"Imformation_Month"),[time substringWithRange:NSMakeRange(8, 2)],L(@"Imformation_Day")];
    self.url = EncodeStringFromDic(dic, @"url");
    self.infoSource = EncodeStringFromDic(dic, @"infoSource");
    
}

@end