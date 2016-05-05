//
//  CardDetailBaseDTO.h
//  SuningEBuy
//
//  Created by YANG on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface CardDetailBaseDTO : BaseHttpDTO

@property (nonatomic, strong) NSString *custNum;          //会员编号
@property (nonatomic, strong) NSString *sysHeadPicFlag;   //是否系统头像
@property (nonatomic, strong) NSString *sysHeadPicNum;    //头像编号
@property (nonatomic, strong) NSString *imgData;          //头像图片（自定义头像，base64编码）


@end
