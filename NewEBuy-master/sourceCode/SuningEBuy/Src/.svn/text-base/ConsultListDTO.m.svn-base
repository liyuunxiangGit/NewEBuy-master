//
//  ConsultList.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ConsultListDTO.h"

@implementation ConsultListDTO
-(void)encodeFromDictionary:(NSDictionary *)dic{
    if (dic == nil) {
        return;
    }
    
    self.nickname = EncodeStringFromDic(dic, @"nickname");
    self.modeltype = EncodeStringFromDic(dic, @"modeltype");
    NSString *str = EncodeStringFromDic(dic, @"content");
    str = [str stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];

    NSString* string1 = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.content = string1;
    self.content = [self.content stringByReplacingOccurrencesOfString:@"<br/><br/>" withString:@"\n"];
    self.createtime = EncodeStringFromDic(dic, @"createtime");
    self.answer = EncodeStringFromDic(dic, @"answer");
    NSString *str1 = EncodeStringFromDic(dic, @"answer");
    str1 = [str1 stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];

    NSString* string2 = [str1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.answer = string2;
    self.answer = [self.answer stringByReplacingOccurrencesOfString:@"<br/><br/>" withString:@"\n"];

    self.suppliername = EncodeStringFromDic(dic, @"suppliername");
    self.usefulcount = EncodeStringFromDic(dic, @"usefulcount");
    self.unusefulcount = EncodeStringFromDic(dic, @"unusefulcount");
    self.articleId = EncodeStringFromDic(dic, @"articleId");

    
}

@end

@implementation SendPublishConsultDTO


@end
@implementation  MyConsultDTO

-(void)encodeFromDictionary:(NSDictionary *)dic{
    if (dic == nil) {
        return;
    }
    
    self.centryname = EncodeStringFromDic(dic, @"centryname");
    self.centryname = [NSString stringWithFormat:@"%@:%@",L(@"ProductName"),self.centryname];
    self.modeltype = EncodeStringFromDic(dic, @"modeltype");
    NSString *str = EncodeStringFromDic(dic, @"content");
    str = [str stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    NSString* string1 = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.content = string1;    self.createtime = EncodeStringFromDic(dic, @"createtime");
    NSString *str1 = EncodeStringFromDic(dic, @"answer");
    str1 = [str1 stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    NSString* string2 = [str1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.answer = string2;
    
    self.suppliername = EncodeStringFromDic(dic, @"suppliername");
    self.usefulcount = EncodeStringFromDic(dic, @"usefulcount");
    self.unusefulcount = EncodeStringFromDic(dic, @"unusefulcount");
    if (string2.length!=0 || !string2) {
        if (!self.suppliername) {
            self.answer = [NSString stringWithFormat:@"%@%@:%@",self.suppliername,L(@"Reply"),self.answer];
        }
        else{
            self.answer = [NSString stringWithFormat:@"%@:%@",L(@"SuningReply"),self.answer];
            
        }
    }
    else{
        self.answer = @"";

    }
}



@end

@implementation ConsultNumDetailsDTO

-(void)encodeFromDictionary:(NSDictionary *)dic{
    if (dic == nil) {
        return;
    }
    
    self.totalCount = EncodeStringFromDic(dic, @"totalCount");
    self.proCount = EncodeStringFromDic(dic, @"proCount");
    self.invtCount = EncodeStringFromDic(dic, @"invtCount");
    self.faCount = EncodeStringFromDic(dic, @"faCount");
    self.payCount = EncodeStringFromDic(dic, @"payCount");
    self.promCount = EncodeStringFromDic(dic, @"promCount");
    self.othCount = EncodeStringFromDic(dic, @"othCount");
    
}


@end

@implementation SendConsultListDTO

@end

@implementation ModelTypeList

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end