//
//  NewProductConsultantService.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header     NewProductConsultantService
 @abstract   发表商品咨询信息   
 @author     wangman
 @version    v1.1  12-09-12 
 */

#import "DataService.h"

#import "DataProductBasic.h"

/*!
 @protocol       NewProductConsultantServiceDelegate
 @abstract       NewProductConsultantService的一个代理
 @discussion     发表商品咨询数据回调
 */

@protocol NewProductConsultantServiceDelegate <NSObject>

@optional

/*!
 @method       newProductConsultantCompleted: errorMsg:
 @abstract     发表商品咨询后完成回调
 @param        isSuccess 是否发表成功
 @param        errorMsg 错误信息 
 */

- (void) newProductConsultantCompleted:(BOOL)isSuccess errorMsg:(NSString*)errorMsg;

@end

/*!
 @class       NewProductConsultantService   
 @abstract    发表商品咨询
 */
@interface NewProductConsultantService : DataService
{
    
    HttpMessage                                  *_newProductConsultantHttpMsg;      
    
    id<NewProductConsultantServiceDelegate>       __weak _delegate;
    
}




@property (nonatomic, weak)id<NewProductConsultantServiceDelegate>         delegate;
/*!
 @method      beginSendNewProductConsultantHttpRequest: text:
 @abstract    发送发表商品咨询请求  
 @param       product 商品信息  
 @param       text 商品咨询内容 
 */
- (void) beginSendNewProductConsultantHttpRequest:(DataProductBasic *) product text:(NSString *)text;

@end
