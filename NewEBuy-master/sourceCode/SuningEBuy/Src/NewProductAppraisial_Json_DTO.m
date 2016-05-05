//
//  NewProductAppraisial_Json_DTO.m
//  SuningEBuy
//
//  Created by cjw on 14/11/11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewProductAppraisial_Json_DTO.h"
#import "ProductUtil.h"

@implementation NewProductAppraisial_Json_DTO

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    //self.productReviewId = NotNilAndNull([dic objectForKey:@"productReviewId"])?[dic objectForKey:@"productReviewId"]:@"";
    NSDictionary *user = NotNilAndNull([dic objectForKey:@"user"])?[dic objectForKey:@"user"]:@"";
    self.nickname = NotNilAndNull([user objectForKey:@"nickName"])?[user objectForKey:@"nickName"]:@"";
    //self.logonId = NotNilAndNull([dic objectForKey:@"logonId"])?[dic objectForKey:@"logonId"]:@"";
    //self.anonFlag = NotNilAndNull([dic objectForKey:@"anonFlag"])?[dic objectForKey:@"anonFlag"]:@"";
    //self.bestTag = NotNilAndNull([dic objectForKey:@"bestTag"])?[dic objectForKey:@"bestTag"]:@"";
    self.score = NotNilAndNull([dic objectForKey:@"score"])?[dic objectForKey:@"score"]:@"";
    self.publishTime = NotNilAndNull([dic objectForKey:@"publishTime"])?[dic objectForKey:@"publishTime"]:@"";
    //self.title = NotNilAndNull([dic objectForKey:@"title"])?[dic objectForKey:@"title"]:@"";
    //self.advantage = NotNilAndNull([dic objectForKey:@"advantage"])?[dic objectForKey:@"advantage"]:@"";
    //self.disadvantage = NotNilAndNull([dic objectForKey:@"disadvantage"])?[dic objectForKey:@"disadvantage"]:@"";
    self.content = NotNilAndNull([dic objectForKey:@"content"])?[dic objectForKey:@"content"]:@"";
    self.supplierName = NotNilAndNull([dic objectForKey:@"supplierName"])?[dic objectForKey:@"supplierName"]:@"";
    //self.suplReviewId = NotNilAndNull([dic objectForKey:@"suplReviewId"])?[dic objectForKey:@"suplReviewId"]:@"";
    self.images = [NSMutableArray array];
    NSArray *imageDic = IsArrEmpty([dic objectForKey:@"images"])?nil:[dic objectForKey:@"images"];
    for(NSDictionary *dtoDic in imageDic)
    {
        NSString *productCode = NotNilAndNull([dtoDic objectForKey:@"url"])?[dtoDic objectForKey:@"url"]:@"";
        if (productCode.length != 0) {
            
//            NSString *codeString;
//
//            if ([productCode length] < 18){
//                codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];
//            }else{
//                codeString = productCode;
//            }
//            
//            NSString *str =  [NSString stringWithFormat:@"%@/%@_1_%dx%d.jpg",
//                              kImageServerHost,
//                              codeString,
//                              55,
//                              55];
            NSURL *str = [NSURL URLWithString:[NSString stringWithFormat:@"http://image.suning.cn/uimg/ZR/share_order/%@_100x100.jpg",productCode]];
            
            [_images addObject:str];
        }
    }
    /*
    NSString *__suplContent = [dic objectForKey:@"suplContent"];
    if (IsStrEmpty(__suplContent)) {
        self.suplContent = @"";//@"[追加]：我是谁我是神人你是谁你是谁书书是是谁你是谁书书是是谁你是谁书书是是谁你是谁书书是是你是谁你睡熟";
    }else{
        self.suplContent = [NSString stringWithFormat:@"[%@]：%@",L(@"Product_Append"),__suplContent];
    }*/
    
}

@end
