//
//  productHttpDataSource.m
//  SuningEBuy
//
//  Created by zhaojw on 11-9-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "productHttpDataSource.h"


@implementation productHttpDataSource

+(DataProductBasic*)parseProductDetailInfo:(NSDictionary*)items{
	
	DataProductBasic *dto = [[DataProductBasic alloc] init];
	
	[dto encodeFromDictionary:items];
	
	return dto;
	
	
}


+(NSMutableArray *)parseProductAppraisalInfo:(NSDictionary *)items{
    
    NSArray *temArr = [items objectForKey:kHttpResponseSearchSearchList];
    
    if (nil ==  temArr || 0 == [temArr count]) {
        return nil;
    }else{
        NSMutableArray *appraisaArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in temArr) {
            ProductAppraisalDTO *dto = [[ProductAppraisalDTO alloc]init];
            [dto encodeFromDictionary:dic];
            [appraisaArr addObject:dto];
        }
        if([appraisaArr count]){
			
		    return appraisaArr;
			
		}
		else{
			
			
			return nil;
		}
    }
}


+ (NSMutableArray *)parseProductParaInfo:(NSDictionary *)items isBook:(BOOL)isYes
{
    if (items == nil || [items count] == 0) 
    {
        return nil;
    }
    
    if (isYes == YES) {
        //图书参数返回判断是否成功
        if ([items objectForKey:@"isSuccess"] && ![[items objectForKey:@"isSuccess"] isEqualToString:@"1"])
        {
            return nil;
        }
    }else
    {
        //非图书参数返回判断是否成功
        if ([items objectForKey:@"errorCode"] && ![[items objectForKey:@"errorCode"] isEqualToString:@""])
        {
            return nil;
        }
    }    
      
    NSArray *parameters = [items objectForKey:@"parameters"];
    
    if (parameters && [parameters count] > 0)
    {
        NSMutableArray *bookInfoList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in parameters)
        {
            if ([dic isKindOfClass:[NSDictionary class]])
            {
                ProductParaDTO *dto = [[ProductParaDTO alloc] init];
                
                [dto encodeFromDictionary:dic];
                
                [bookInfoList addObject:dto];
                
                TT_RELEASE_SAFELY(dto);
            }
        }
        return bookInfoList;
    }
    
    return nil;

}
@end
