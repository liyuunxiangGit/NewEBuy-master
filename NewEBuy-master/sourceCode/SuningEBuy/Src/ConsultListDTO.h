//
//  ConsultList.h
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultListDTO : NSObject
@property (nonatomic,strong) NSString *nickname;                          //用户昵称

@property (nonatomic,strong) NSString *modeltype;                          //咨询类型

@property (nonatomic,strong) NSString *content;                          //咨询内容

@property (nonatomic,strong) NSString *createtime;                          //咨询时间

@property (nonatomic,strong) NSString *answer;                          //咨询回复

@property (nonatomic,strong) NSString *suppliername;                          //供应商名称

@property (nonatomic,strong) NSString *usefulcount;                          //满意数

@property (nonatomic,strong) NSString *unusefulcount;                         //不满意数

@property (nonatomic,strong) NSString *articleId;                          //咨询ID

@property (nonatomic,strong) NSString *totalcnt;                            //总页数
-(void)encodeFromDictionary:(NSDictionary *)dic;
@end

@interface SendConsultListDTO : NSObject
@property (nonatomic,strong) NSString *subcodeflag;                          //通子码标识  0-通码，1-子码

@property (nonatomic,strong) NSString *suppliercode;                        //供应商编码

@property (nonatomic,assign) BOOL isbook;                        //图书电器标识 true-图书，false-电器

@property (nonatomic,strong) NSString *partnumber;                        //18位商品编码

@property (nonatomic,strong) NSString *modeltype;                        //咨询类型 4-全部,5-产品咨询,6-库存配送,7-发票保修,8-支付信息,9-促销优惠,10-其他问题


@end

@interface MyConsultDTO : NSObject
@property (nonatomic,strong) NSString *centryname;                          //商品名称

@property (nonatomic,strong) NSString *modeltype;                          //咨询类型

@property (nonatomic,strong) NSString *content;                          //咨询内容

@property (nonatomic,strong) NSString *createtime;                          //咨询时间

@property (nonatomic,strong) NSString *answer;                          //咨询回复

@property (nonatomic,strong) NSString *suppliername;                          //供应商名称

@property (nonatomic,strong) NSString *usefulcount;                         //满意数

@property (nonatomic,strong) NSString *unusefulcount;                          //不满意数

@property (nonatomic,strong) NSString *totalcnt;                            //总页数

-(void)encodeFromDictionary:(NSDictionary *)dic;

@end

@interface SendPublishConsultDTO : NSObject

@property (nonatomic,strong) SendConsultListDTO *subcodeflag;

@property (nonatomic,strong) NSString *content;                          //内容

@property (nonatomic,strong) NSString *cflag;                            //c店

@property (nonatomic,strong) NSString *uuid;                          //uuid

@property (nonatomic,strong) NSString *vCode;                            //图形验证码


@end


@interface ConsultNumDetailsDTO : NSObject

@property (nonatomic,strong) NSString *totalCount;                        //全部咨询数

@property (nonatomic,strong) NSString *proCount;                          //产品咨询数

@property (nonatomic,strong) NSString *invtCount;                            //库存配送咨询数

@property (nonatomic,strong) NSString *faCount;                          //发票咨询数

@property (nonatomic,strong) NSString *payCount;                            //支付咨询数

@property (nonatomic,strong) NSString *promCount;                            //促销咨询数

@property (nonatomic,strong) NSString *othCount;                            //其他咨询

-(void)encodeFromDictionary:(NSDictionary *)dic;


@end


@interface ModelTypeList : NSObject

@property (nonatomic,strong) NSString *modelType;                       //咨询id

@property (nonatomic,strong) NSString *modelName;                       //咨询类型名称

@end