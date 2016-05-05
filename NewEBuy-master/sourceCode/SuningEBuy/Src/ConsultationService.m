//
//  ConsultationService.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ConsultationService.h"

@implementation ConsultationService
#define pagesize @"10"
- (void)dealloc
{
    
    HTTPMSG_RELEASE_SAFELY(ListHttpMsg);
    
}

//获取咨询
- (void)SendConsultlistHttpRequest:(SendConsultListDTO *)senddto currentpage:(int)page{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setValue:@"1" forKey:@"subcodeflag"];
    [dic setValue:senddto.suppliercode forKey:@"suppliercode"];
    NSString *isbookstr=senddto.isbook?@"true":@"false";
    
    [dic setValue:isbookstr forKey:@"isbook"];
    [dic setValue:senddto.partnumber forKey:@"partnumber"];
    [dic setValue:senddto.modeltype forKey:@"modeltype"];
    [dic setValue:[NSString stringWithFormat:@"%d",page] forKey:@"currentpage"];
    [dic setValue:pagesize forKey:@"pagesize"];

//    NSString *url = [NSString stringWithFormat:@"%@/%@",kNewHotWordsServer, kgetConsultList];
    
#ifdef kPreTest
    
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kHostSuningWap, kgetConsultList];
    
#elif kSitTest
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostSuningWap, kgetConsultList];
#elif kReleaseH
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kNewHotWordsServer, kgetConsultList];
#endif
    
    
    HTTPMSG_RELEASE_SAFELY(ListHttpMsg);
    ListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:dic
                                                           cmdCode:CC_GetConsultList];
    ListHttpMsg.delegate = self;
    ListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:ListHttpMsg];
}


//获取咨询总数
- (void)SendConsultcountHttpRequest:(SendConsultListDTO *)senddto{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    [dic setValue:@"1" forKey:@"subcodeflag"];
    [dic setValue:senddto.suppliercode forKey:@"suppliercode"];
    NSString *isbookstr=senddto.isbook?@"true":@"false";
    
    [dic setValue:isbookstr forKey:@"isbook"];
    [dic setValue:senddto.partnumber forKey:@"partnumber"];
    
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostSuningWap, kgetConsultCount];
    
#ifdef kPreTest
    
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kHostSuningWap, kgetConsultCount];
    
#elif kSitTest
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostSuningWap, kgetConsultCount];
#elif kReleaseH
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kNewHotWordsServer, kgetConsultCount];
#endif
    HTTPMSG_RELEASE_SAFELY(ListHttpMsg);
    ListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:dic
                                                cmdCode:CC_GetConsultCount];
    ListHttpMsg.delegate = self;
    ListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:ListHttpMsg];
}


//我的咨询历史
- (void)SendMyConsultlistHttpRequest:(int)page{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setValue:[NSString stringWithFormat:@"%d",page] forKey:@"currentpage"];
    [dic setValue:pagesize forKey:@"pagesize"];
    
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostSuningWap, kgetMyConsult];
#ifdef kPreTest
    
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kHostSuningWap, kgetMyConsult];
    
#elif kSitTest
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kHostSuningWap, kgetMyConsult];
#elif kReleaseH
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kNewHotWordsServer, kgetMyConsult];
#endif

    HTTPMSG_RELEASE_SAFELY(ListHttpMsg);
    ListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:dic
                                                cmdCode:CC_GetMyConsultList];
    ListHttpMsg.delegate = self;
    ListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:ListHttpMsg];

}


//发表咨询
- (void)SendpublishHttpRequest:(SendPublishConsultDTO *)dto{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setValue:@"1" forKey:@"subcodeflag"];
    [dic setValue:dto.subcodeflag.suppliercode forKey:@"suppliercode"];
    NSString *isbookstr=dto.subcodeflag.isbook?@"true":@"false";
    
    [dic setValue:isbookstr forKey:@"isbook"];
    [dic setValue:dto.subcodeflag.partnumber forKey:@"partnumber"];
    [dic setValue:dto.subcodeflag.modeltype forKey:@"modeltype"];
    [dic setValue:dto.content forKey:@"content"];
    [dic setValue:dto.cflag forKey:@"cflag"];
//    [dic setObject:dto.uuid forKey:@"uuid"];
//    [dic setObject:dto.vCode forKey:@"vCode"];

#ifdef kPreTest
    
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kHostSuningWap, kPublichconsult];
    
#elif kSitTest
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostSuningWap, kPublichconsult];
#elif kReleaseH
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kNewHotWordsServer, kPublichconsult];
#endif
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostSuningWap, kPublichconsult];
    HTTPMSG_RELEASE_SAFELY(ListHttpMsg);
    ListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:dic
                                                cmdCode:CC_PublichConsult];
    ListHttpMsg.delegate = self;
    ListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:ListHttpMsg];
}


//2.5 咨询数量概况查询
- (void)SendConsultnumDetailHttpRequest:(SendConsultListDTO *)senddto{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setValue:senddto.subcodeflag forKey:@"1"];
    [dic setValue:senddto.suppliercode forKey:@"suppliercode"];
    NSString *isbookstr=senddto.isbook?@"true":@"false";
    
    [dic setValue:isbookstr forKey:@"isbook"];
    [dic setValue:senddto.partnumber forKey:@"partnumber"];
    
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostSuningWap, kConsultNumDetail];
#ifdef kPreTest
    
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kHostSuningWap, kConsultNumDetail];
    
#elif kSitTest
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostSuningWap, kConsultNumDetail];
#elif kReleaseH
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kNewHotWordsServer, kConsultNumDetail];
#endif
    HTTPMSG_RELEASE_SAFELY(ListHttpMsg);
    ListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:dic
                                                cmdCode:CC_ConsultNumDetail];
    ListHttpMsg.delegate = self;
    ListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:ListHttpMsg];
}

//咨询满意度
-(void)SendConsultSatisfactionHttpRequest:(NSString *)articleId isbook:(NSString *)isbook isflag:(NSString *)isflag{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    if (!articleId) {
        return;
    }
    [dic setValue:articleId forKey:@"articleId"];
    [dic setValue:isbook forKey:@"isbook"];
    [dic setValue:isflag forKey:@"isflag"];
    
    
#ifdef kPreTest
    
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kHostSuningWap, kConsultSatisfaction];
    
#elif kSitTest
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostSuningWap, kConsultSatisfaction];
#elif kReleaseH
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kNewHotWordsServer, kConsultSatisfaction];
#endif

    HTTPMSG_RELEASE_SAFELY(ListHttpMsg);
    ListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:dic
                                                cmdCode:CC_ConsultNumDetail];
    ListHttpMsg.delegate = self;
    ListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:ListHttpMsg];
}

//咨询类型查询
-(void)SendConsultationType{
    NSString *url = [NSString stringWithFormat:@"%@/%@",KNewHomeAPIURL, KgetConsultationType];
    HTTPMSG_RELEASE_SAFELY(ListHttpMsg);
    ListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                             requestUrl:url
                                            postDataDic:nil
                                                cmdCode:CC_ConsultationType];
    ListHttpMsg.delegate = self;
    ListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:ListHttpMsg];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    NSString *error = [NSString stringWithFormat:@"%@",[item objectForKey:@"returnCode"] ];
    if (receiveMsg.cmdCode == CC_GetConsultList)
    {
        NSMutableArray *listarr = [[NSMutableArray alloc] initWithCapacity:1];
        NSString *resulterror;
        if (![error isEqualToString:@"0"]) {
            resulterror = [item objectForKey:@"returnMessage"];
            listarr = nil;
        }
        else{
            NSArray *consulist = [item objectForKey:@"consulationList"];
            NSString *totalcnt = [item objectForKey:@"totalcnt"];
            for (NSDictionary *dic in consulist) {
                ConsultListDTO *consult = [[ConsultListDTO alloc] init];
                [consult encodeFromDictionary:dic];
                consult.totalcnt = totalcnt;
                [listarr addObject:consult];
            }
            resulterror=nil;
        }
        if ([_delegate respondsToSelector:@selector(GetConsultListDelegate:error:)])
        {
            [_delegate GetConsultListDelegate:listarr error:resulterror];
        }
    }
    else if(receiveMsg.cmdCode == CC_GetConsultCount){
        NSString *resulterror;
        NSString *consulationcount;
        if (![error isEqualToString:@"0"]) {
            resulterror = [item objectForKey:@"returnMessage"];
            consulationcount = nil;
        }
        else{
            consulationcount = [item objectForKey:@"consulationcnt"];
            resulterror = nil;
        }
        if ([_delegate respondsToSelector:@selector(GetConsultCountDelegate:error:)])
        {
            [_delegate GetConsultCountDelegate:consulationcount error:resulterror];
        }
    }
    else if(receiveMsg.cmdCode == CC_GetMyConsultList){
        NSMutableArray *listarr = [[NSMutableArray alloc] initWithCapacity:1];
        NSString *resulterror;
        if (![error isEqualToString:@"0"]) {
            resulterror = [item objectForKey:@"returnMessage"];
            listarr = nil;
        }
        else{
            NSArray *consulist = [item objectForKey:@"consulationList"];
            NSString *totalcnt = [item objectForKey:@"totalcnt"];
            for (NSDictionary *dic in consulist) {
                MyConsultDTO *consult = [[MyConsultDTO alloc] init];
                [consult encodeFromDictionary:dic];
                consult.totalcnt = totalcnt;
                [listarr addObject:consult];
            }
            resulterror=nil;
        }
        if ([_delegate respondsToSelector:@selector(GetMyConsultDelegate:error:)])
        {
            [_delegate GetMyConsultDelegate:listarr error:resulterror];
        }

    }
    else if(receiveMsg.cmdCode == CC_PublichConsult){
        NSString *resulterror;
        BOOL issuccess;
        if (![error isEqualToString:@"0"]) {
            resulterror = [item objectForKey:@"returnMessage"];
            issuccess = NO;
        }
        else{
            resulterror = nil;
            issuccess = YES;
        }
        if ([_delegate respondsToSelector:@selector(PublishConsultDelegate:error:)])
        {
            [_delegate PublishConsultDelegate:issuccess error:resulterror];
        }

    }
    else if (receiveMsg.cmdCode == CC_ConsultNumDetail){
        NSString *resulterror;
        NSString *consulationcount;
        ConsultNumDetailsDTO *dto=nil;
        BOOL issuccess;
        if (![error isEqualToString:@"0"]) {
            resulterror = [item objectForKey:@"returnMessage"];
            consulationcount = nil;
            issuccess = NO;
        }
        else{
            dto = [[ConsultNumDetailsDTO alloc] init];
            [dto encodeFromDictionary:item];
            issuccess = YES;
        }
        if ([_delegate respondsToSelector:@selector(GetConsultNumDelegate:error:ConsultDTO:)])
        {
            [_delegate GetConsultNumDelegate:issuccess error:resulterror ConsultDTO:dto];
        }

    }
    else if(receiveMsg.cmdCode == CC_ConsultSatisfaction){
        BOOL issuccess;
        NSString *resulterror;
        if (![error isEqualToString:@"0"]) {
            issuccess = NO;
            resulterror = [item objectForKey:@"returnMessage"];
        }
        else{
            issuccess = YES;
            resulterror = nil;
        }
        if ([_delegate respondsToSelector:@selector(GetConsultSatisfactionDelegate:error:)])
        {
            [_delegate GetConsultSatisfactionDelegate:issuccess error:resulterror];
        }
        
    }
    else if (receiveMsg.cmdCode == CC_ConsultationType){
        BOOL issuccess;
        NSString *resulterror;
        NSMutableArray *list;
        if (![error isEqualToString:@""]) {
            issuccess = NO;
            list=   nil;
            resulterror = [item objectForKey:@"returnMessage"];
        }
        else{
            issuccess = YES;
            resulterror = nil;
            NSArray *consulist = [item objectForKey:@"modelTypeList"];

            for (NSDictionary *dic in consulist) {
                ModelTypeList *dto =[[ModelTypeList alloc] init];
                dto.modelType = [dic objectForKey:@"modelType"];
                dto.modelName = [dic objectForKey:@"modelName"];
                [list addObject:dto];
            }
        }
        if ([_delegate respondsToSelector:@selector(GetConsultationTypeDelegate:error:list:)])
        {
            [_delegate GetConsultationTypeDelegate:issuccess error:resulterror list:list];
        }

    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_GetConsultList)
    {
        if ([_delegate respondsToSelector:@selector(GetConsultListDelegate:error:)])
        {
            [_delegate GetConsultListDelegate:nil error:nil];
        }
    }
    else if(receiveMsg.cmdCode == CC_GetConsultCount){
        if ([_delegate respondsToSelector:@selector(GetConsultCountDelegate:error:)])
        {
            [_delegate GetConsultCountDelegate:nil error:nil];
        }
    }
    else if(receiveMsg.cmdCode == CC_GetMyConsultList){
        if ([_delegate respondsToSelector:@selector(GetConsultListDelegate:error:)])
        {
            [_delegate GetConsultListDelegate:nil error:nil];
        }
    }
    else if(receiveMsg.cmdCode == CC_PublichConsult){
        if ([_delegate respondsToSelector:@selector(PublishConsultDelegate:error:)])
        {
            [_delegate PublishConsultDelegate:NO error:nil];
        }
    }
    else if (receiveMsg.cmdCode == CC_ConsultNumDetail){
        if ([_delegate respondsToSelector:@selector(GetConsultNumDelegate:error:ConsultDTO:)])
        {
            [_delegate GetConsultNumDelegate:NO error:nil ConsultDTO:nil];
        }
    }
    else if(receiveMsg.cmdCode == CC_ConsultSatisfaction){
        if ([_delegate respondsToSelector:@selector(GetConsultSatisfactionDelegate:error:)])
        {
            [_delegate GetConsultSatisfactionDelegate:NO error:nil];
        }

    }
    else if (receiveMsg.cmdCode == CC_ConsultationType){
        if ([_delegate respondsToSelector:@selector(GetConsultationTypeDelegate:error:list:)])
        {
            [_delegate GetConsultationTypeDelegate:NO error:nil list:nil];
        }
    }
}


@end
