//
//  NewProductAppraisalDTO.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewProductAppraisalDTO.h"

@implementation NewProductAppraisalDTO


-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.productReviewId = NotNilAndNull([dic objectForKey:@"productReviewId"])?[dic objectForKey:@"productReviewId"]:@"";
    self.nickname = NotNilAndNull([dic objectForKey:@"nickname"])?[dic objectForKey:@"nickname"]:@"";
    self.logonId = NotNilAndNull([dic objectForKey:@"logonId"])?[dic objectForKey:@"logonId"]:@"";
    self.anonFlag = NotNilAndNull([dic objectForKey:@"anonFlag"])?[dic objectForKey:@"anonFlag"]:@"";
    self.bestTag = NotNilAndNull([dic objectForKey:@"bestTag"])?[dic objectForKey:@"bestTag"]:@"";
    self.qualityStar = NotNilAndNull([dic objectForKey:@"qualityStar"])?[dic objectForKey:@"qualityStar"]:@"";
    self.reviewTime = NotNilAndNull([dic objectForKey:@"reviewTime"])?[dic objectForKey:@"reviewTime"]:@"";
    self.title = NotNilAndNull([dic objectForKey:@"title"])?[dic objectForKey:@"title"]:@"";
    self.advantage = NotNilAndNull([dic objectForKey:@"advantage"])?[dic objectForKey:@"advantage"]:@"";
    self.disadvantage = NotNilAndNull([dic objectForKey:@"disadvantage"])?[dic objectForKey:@"disadvantage"]:@"";
    self.content = NotNilAndNull([dic objectForKey:@"content"])?[dic objectForKey:@"content"]:@"";
    self.supplierName = NotNilAndNull([dic objectForKey:@"supplierName"])?[dic objectForKey:@"supplierName"]:@"";
    self.suplReviewId = NotNilAndNull([dic objectForKey:@"suplReviewId"])?[dic objectForKey:@"suplReviewId"]:@"";

    
    NSString *__suplContent = [dic objectForKey:@"suplContent"];
    if (IsStrEmpty(__suplContent)) {
        self.suplContent = @"";//@"[追加]：我是谁我是神人你是谁你是谁书书是是谁你是谁书书是是谁你是谁书书是是谁你是谁书书是是你是谁你睡熟";
    }else{
        self.suplContent = [NSString stringWithFormat:@"[%@]：%@",L(@"Product_Append"),__suplContent];
    }
    
}
@end
