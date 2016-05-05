//
//  PromotionInfoService.h
//  SuningEBuy
//
//  Created by huangtf on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"
#import "PromotionInfoDTO.h"

@protocol PromotionInfoServiceDelegate <NSObject>


-(void)getPromotionInfoListWithSuccess:(BOOL)isSuccess 
                              errorMsg:(NSString *)errorMsg 
                     PromotionInfoList:(NSMutableArray *)list 
                             totalPage:(NSInteger)totalPage 
                           currentPage:(NSInteger)currPage;
                            

@end

@interface PromotionInfoService : DataService
{
    HttpMessage *PromotionInfoListMessage;


}

@property(nonatomic,weak) id<PromotionInfoServiceDelegate> delegate;

-(void)beginGetPromotionInfoListWithPageNum:(NSString *)pageNum 
                                   PageSize:(NSString *)pageSize;

- (void)parsePromotionInfoListData:(NSDictionary *)items;

@end
