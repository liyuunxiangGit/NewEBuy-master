//
//  QYaoHttpService.m
//  SuningEBuy
//
//  Created by XZoscar on 14-4-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "QYaoHttpService.h"
#import "QYaoYiYaoDTO.h"


@implementation QYaoHttpService

- (void)dealloc {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
}

- (void)reqActiveQuery:(NSString *)activeTypeId {
    
    self.activeTypeId       = activeTypeId;
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kEbuyWapHostURL stringByAppendingString:@"/ticket/queryCurrentActive.do"]
                                         postDataDic:[NSDictionary dictionaryWithObject:activeTypeId forKey:@"activeTypeId"]
                                             cmdCode:CC_YaoYiYaoActiveQuery];
    _httpMsg.delegate = self;
    _httpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
    
}

- (void)reqActiveChouJiang:(NSString *)activeTypeId {
    
    self.activeTypeId       = activeTypeId;
    
    NSDictionary *paras = [NSDictionary dictionaryWithObjects:@[activeTypeId]
                                                      forKeys:@[@"activeTypeId"]];
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                       requestUrl:[kEbuyWapHostURL stringByAppendingString:@"/ticket/private/loadingTicket.do"]
                                      postDataDic:paras
                                          cmdCode:CC_YaoYiYaoActiveShakeJiang];
    _httpMsg.delegate = self;
    _httpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

- (void)reqActiveCloneValidate:(NSString *)activeTypeId prizeId:(NSString *)prizeId {
    
    self.activeTypeId       = activeTypeId;
    
    NSDictionary *paras = [NSDictionary dictionaryWithObjects:@[activeTypeId,prizeId]
                                                      forKeys:@[@"activeTypeId",@"ticketId"]];
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kEbuyWapHostURL stringByAppendingString:@"/ticket/private/checkCloneWap.do"]
                                         postDataDic:paras
                                             cmdCode:CC_YaoYiYaoActiveCloneValidate];
    _httpMsg.delegate = self;
    _httpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

// 2014-05-30 xzoscar add 云钻乐园 服务'项' 获取
- (void)reqGetScoreParkItems {
    
    NSDictionary *paras = [NSDictionary dictionaryWithObject:@"jifenleyuan" forKey:@"type"];
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    // kHostSuningMts 服务地址 切换 2014/09/23,xzoscar
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[KNewHomeAPIURL stringByAppendingString:@"mts-web/nvps/getNvp.do"]
                                         postDataDic:paras
                                             cmdCode:CC_YaoYiYaoScoreParkServeItems];
    _httpMsg.delegate = self;
    _httpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

- (void)responderDelegate:(id)bean {
    
    if (nil != _httpDelegate
        && [_httpDelegate respondsToSelector:@selector(delegate_yaoYiYaoHttpServeResult:)]) {
        [_httpDelegate delegate_yaoYiYaoHttpServeResult:bean];
    }
}

- (void)parserHttpMsg:(HttpMessage *)receiveMsg {
    
    NSString *resultCode = [receiveMsg.jasonItems objectForKey:@"errorCode"];
    
    if (receiveMsg.cmdCode == CC_YaoYiYaoActiveQuery) {
        
        QYaoQueryDTO *bean = [[QYaoQueryDTO alloc] init];
        bean.cmd = receiveMsg.cmdCode;
        if (![resultCode isEqualToString:@""]) {
            bean.resultCode = resultCode;
        }else { // ok
            bean.activeRuleUrl = [receiveMsg.jasonItems objectForKey:@"activeUrl"];
            bean.activeMsg     = [receiveMsg.jasonItems objectForKey:@"activeMsg"];
        }
        bean.resultDesc     = [receiveMsg.jasonItems objectForKey:@"activeMsg"];
        bean.backgroundUrl  = [receiveMsg.jasonItems objectForKey:@"iosPic"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self responderDelegate:bean];
        });
        
    }else if (receiveMsg.cmdCode == CC_YaoYiYaoActiveShakeJiang) { // {{{
        
        QYaoChouJiangDTO *bean = [[QYaoChouJiangDTO alloc] init];
        bean.cmd = receiveMsg.cmdCode;
        
        bean.resultDesc   = [receiveMsg.jasonItems objectForKey:@"errorMsg"];
        bean.resultCode   = resultCode;
        
        if (![resultCode isEqualToString:@""]) {
            
            bean.isEntityPrize = EncodeStringFromDic(receiveMsg.jasonItems,@"isEntity");
            /* 是实物 奖励,实物奖品 使用的字段*/
            bean.prizeName = [receiveMsg.jasonItems objectForKey:@"prizeName"];
            
            bean.prizeTypeName = [receiveMsg.jasonItems objectForKey:@"prizeTypeName"];
            bean.prizeType     = [receiveMsg.jasonItems objectForKey:@"prizeType"];
            bean.serialNumber  = [receiveMsg.jasonItems objectForKey:@"serialNumber"];
            bean.prizeAdUrl    = [receiveMsg.jasonItems objectForKey:@"prizeAdUrl"];
            bean.prizePicUrl   = [receiveMsg.jasonItems objectForKey:@"prizeMake"];
            bean.activename    = [receiveMsg.jasonItems objectForKey:@"activeName"];
            
            //
            bean.mrakedwords   = [receiveMsg.jasonItems objectForKey:@"mrakedWords"];
            bean.shareContent  = [receiveMsg.jasonItems objectForKey:@"shakeContent"];
            
            // {{{
            if ([bean.resultCode isEqualToString:@"e01"]) {             // 当前没有正在进行的活动
                bean.stateType = kQYaoYiYaoResultStateNoActive;
                
            }else if ([bean.resultCode isEqualToString:@"e02"]
                      || [bean.resultCode isEqualToString:@"e06"]) {   // 您的云钻不足，可以签到赚取云钻
                bean.stateType  = kQYaoYiYaoResultStateScoreNotEnough;
                
            }else if ([bean.resultCode isEqualToString:@"e03"]          // 您已经超过活动抽奖次数，请下次再参加
                      || [bean.resultCode isEqualToString:@"e04"]       // 您今天已经超过活动抽奖次数，请下次再参加
                      || [bean.resultCode isEqualToString:@"e10"]       // 您今天已经超过抽奖次数，请明天再参加 ？
                      || [bean.resultCode isEqualToString:@"e12"]) {    // 您已经超过活动时间，请下次再参加
                
                bean.stateType = kQYaoYiYaoResultStateActivityTimesLimited;
                
            }else if ([bean.resultCode isEqualToString:@"e08"]) {
                
            }else if ([bean.resultCode isEqualToString:@"e09"]) {       // 参加摇易摇活动请登录
                bean.stateType = kQYaoYiYaoResultStateNotBegin;
                
            }else if ([bean.resultCode isEqualToString:@"e11"]          // 没有中奖
                      ||[bean.resultCode isEqualToString:@"e07"]        // 云钻扣减失败
                      || [bean.resultCode isEqualToString:@"e20"]) {    // 云钻扣减失败
                
                bean.stateType  = kQYaoYiYaoResultStateNotWining;
                if (nil != bean.mrakedwords
                    && bean.mrakedwords.length > 0) {
                    bean.resultDesc = bean.mrakedwords;
                }
            }else if ([bean.resultCode isEqualToString:@"e0"]) {        // iP限制
                
                bean.stateType  = kQYaoYiYaoResultStateNoActive;
                [bean setResultDesc:L(@"NWAccessTooOften")];
            }
            // }}
            
        }else {
            NSDictionary *tmpDic = [receiveMsg.jasonItems objectForKey:@"ShakeTickeDetail"];
            if (nil != tmpDic) {
                
                bean.isEntityPrize = EncodeStringFromDic(tmpDic,@"isEntity");
                /* 是实物 奖励,实物奖品 使用的字段*/
                bean.prizeName = [tmpDic objectForKey:@"prizeName"];
                
                bean.prizeTypeName = [tmpDic objectForKey:@"prizeTypeName"];
                bean.prizeType     = [tmpDic objectForKey:@"prizeType"];
                bean.serialNumber  = [tmpDic objectForKey:@"serialNumber"];
                bean.prizeAdUrl    = [tmpDic objectForKey:@"prizeAdUrl"];
                bean.prizePicUrl   = [tmpDic objectForKey:@"prizeMake"];
                bean.activename    = [tmpDic objectForKey:@"activeName"];
                bean.isShowNum     = EncodeStringFromDic(tmpDic,@"isShowNum");
                //
                bean.mrakedwords   = [tmpDic objectForKey:@"mrakedWords"];
                bean.shareContent  = [tmpDic objectForKey:@"shakeContent"];
                
                
                // ok 中奖 // {{{
                bean.prizeType = EncodeStringFromDic(tmpDic, @"prizeType");
                NSString *prizeType = [tmpDic objectForKey:@"prizeType"];
                NSInteger iVal = prizeType.integerValue;
                if (iVal >= 1 && iVal <= 4) {
                    // 券或云钻 面值
                    NSString *prizeVal  = [tmpDic objectForKey:@"commonValue"];
                    if ([prizeVal isKindOfClass:[NSString class]]
                        &&prizeVal.length > 0) {
                        bean.prizeValue = prizeVal;
                    }
                    // 普通云钻、普通云券 的分享内容
                    NSString *shareContent = [tmpDic objectForKey:@"shakeContent"];
                    if ([shareContent isKindOfClass:[NSString class]]
                        && shareContent.length > 0) {
                        bean.shareContent = shareContent;
                    }
                    // 克隆云钻、克隆云券 clone url
                    NSString *cloneUrl = [tmpDic objectForKey:@"toCloneUrl"];
                    if ([cloneUrl isKindOfClass:[NSString class]]
                        && cloneUrl.length > 0) {
                        bean.cloneUrl = cloneUrl;
                    }
                    // 宝贝id
                    NSString *prizeId = [tmpDic objectForKey:@"shakeTicketId"];
                    if ([prizeId isKindOfClass:[NSString class]]
                        && prizeId.length > 0) {
                        bean.prizeId = prizeId;
                    }
                
                    switch (iVal) {
                        case 1:// 摇得： 普通云钻
                            bean.stateType  = kQYaoYiYaoResultStateWiningNormalScore;
                            break;
                        case 2: // 克隆云钻
                            bean.stateType  = kQYaoYiYaoResultStateCanCloneScore;
                            break;
                        case 3: // 普通云券
                            bean.stateType = kQYaoYiYaoResultStateWiningNormalCloudTicket;
                            break;
                        case 4: // 克隆云券
                            bean.stateType = kQYaoYiYaoResultStateCanCloneCloudTicket;
                            break;
                        default:
                            break;
                    }
                }
                
                bean.isEntityPrize = EncodeStringFromDic(tmpDic, @"isEntity");
                if (nil != bean.isEntityPrize
                    && [bean.isEntityPrize isEqualToString:@"1"]) {
                    bean.stateType = kQYaoYiYaoResultStateWiningPhyTicket;
                    
                    // 实物奖品 使用的字段
                    bean.prizeName = [tmpDic objectForKey:@"prizeName"];
                    bean.prizeTypeName = [tmpDic objectForKey:@"prizeTypeName"];
                    bean.prizeType     = [tmpDic objectForKey:@"prizeType"];
                    bean.resultDesc    = [tmpDic objectForKey:@"errorMsg"];
                    bean.resultCode    = resultCode;
                    bean.serialNumber  = [tmpDic objectForKey:@"serialNumber"];
                    bean.prizeAdUrl    = [tmpDic objectForKey:@"prizeAdUrl"];
                    bean.prizePicUrl   = [tmpDic objectForKey:@"prizeMake"];
                    bean.mrakedwords   = [tmpDic objectForKey:@"mrakedWords"];
                    bean.activename    = [tmpDic objectForKey:@"activeName"];
                    bean.shareContent  = [tmpDic objectForKey:@"shakeContent"];
                }
            }
        } // }}}
        dispatch_async(dispatch_get_main_queue(), ^{
            [self responderDelegate:bean];
        });
    } // }}}
    // 克隆校验
    else if (receiveMsg.cmdCode == CC_YaoYiYaoActiveCloneValidate) {
        
        QYaoCloneValidateDTO *bean = [[QYaoCloneValidateDTO alloc] init];
        bean.cmd          = receiveMsg.cmdCode;
        if (![resultCode isEqualToString:@""]) {
            bean.resultCode = resultCode;
            bean.errMsg = [receiveMsg.jasonItems objectForKey:@"errorMsg"];
        }else {
            // ok,这时可能有第一次克隆提示信息 （弹框）
            bean.firstCloneMsg = [receiveMsg.jasonItems objectForKey:@"cloneMsg"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self responderDelegate:bean];
        });
    }
    // 云钻乐园服务项目
    else if (receiveMsg.cmdCode == CC_YaoYiYaoScoreParkServeItems) {
        if ([resultCode isEqualToString:@""]) {
            
            NSMutableArray *retArr = [NSMutableArray array];
            
            QYaoScoreParkGrpDTO *grp = nil;;
            NSArray *items = [receiveMsg.jasonItems objectForKey:@"nvps"];
            for (NSDictionary *item in items) {
                
                QYaoScoreParkItemDTO *bean = [[QYaoScoreParkItemDTO alloc] init];
                bean.numberId =           item[@"name"];
                NSString *description   = item[@"description"];
                if ([description isKindOfClass:[NSString class]]) {
                     description = [description JSONValue2];
                }
                NSDictionary *desc      = (NSDictionary *)description;
                
                bean.title              = desc[@"enterUrl"];
                bean.entryPictureUrl    = desc[@"va"];
                bean.pageContentUrl     = desc[@"skipUrl"];
                
                
                if (bean.numberId.integerValue <= 4) {
                    if (nil == grp) {
                        grp = [[QYaoScoreParkGrpDTO alloc] init];
                        grp.grpType = 1;
                        [grp setSortId:@"-1"];
                        [grp setTitle:L(@"PlayGameWithoutStop")];
                        [retArr addObject:grp];
                    }
                    [grp.items addObject:bean];
                }else {
                    QYaoScoreParkGrpDTO *dto = [[QYaoScoreParkGrpDTO alloc] init];
                    dto.grpType = 2;
                    [dto setSortId:bean.numberId];
                    dto.title = bean.title;
                    [dto.items addObject:bean];
                    [retArr addObject:dto];
                }
            }

            if (retArr.count > 0) {
                
                for (QYaoScoreParkGrpDTO *bean in retArr) {
                    if (1 == bean.grpType) {
                        [bean.items sortUsingComparator:^NSComparisonResult(QYaoScoreParkItemDTO *obj1,
                                                                            QYaoScoreParkItemDTO *obj2) {
                            
                            return [obj1.numberId compare:obj2.numberId];
                        }];
                        break;
                    }
                }
                [retArr sortUsingComparator:^NSComparisonResult(QYaoScoreParkGrpDTO *obj1,
                                                                QYaoScoreParkGrpDTO *obj2) {
                    return [obj1.sortId compare:obj2.sortId];
                }];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self responderDelegate:retArr];
                });
            }
        }
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg {
    //NSLog(@"\n\nxzoscar : %@\n",receiveMsg.jasonItems);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self parserHttpMsg:receiveMsg];
    });
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg {
    
    [super receiveDidFailed:receiveMsg];
    
    QHttpObject *bean = [[QHttpObject alloc] init];
    bean.cmd          = receiveMsg.cmdCode;
    bean.errCode      = [NSString stringWithFormat:@"%d",receiveMsg.responseStatusCode];
    bean.errMsg       = self.errorMsg;
    [self responderDelegate:bean];
}

@end
