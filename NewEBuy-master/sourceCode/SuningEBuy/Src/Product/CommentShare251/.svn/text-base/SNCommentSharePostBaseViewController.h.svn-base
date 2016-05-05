//
//  SNCommentShareCreateViewController.h
//  SuningEBuy
//
//  Created by Joe on 14-11-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNCommentShareService.h"

typedef enum {
    SNCommentSharePost_All = 0,
    SNCommentSharePost_NoSerivce
}SNCommentSharePost_Type;

@interface SNCommentSharePostBaseViewController : CommonViewController<UITextFieldDelegate,UITextViewDelegate,SNCommentShareServiceDelegate>

@property(nonatomic,assign)SNCommentSharePost_Type type;
@property(nonatomic,strong)NSMutableArray  *selectImages;   //评价选择的照片
@property(nonatomic,strong)NSString  *text;                 //评价输入的内容
@property(nonatomic,assign)int productStarValue;                 //产品评价得分
@property(nonatomic,assign)int logisticsStarValue;               //物流评价得分
@property(nonatomic,assign)int serviceStarValue;                 //服务评价得分
@property(nonatomic,assign)BOOL isPublic;                   //是否公开

@property(nonatomic,strong)SNCommentShareService *service;  //网络服务类

-(void)startValidateCanPulish:(NSString*)orderId customerId:(NSString*)customerId ;
-(void)startUploadImages:(NSMutableArray*)images token:(NSString*)token orderId:(NSString*)orderId userId:(NSString*)userId imageLocalId:(NSMutableArray*)imageIds;


@end
