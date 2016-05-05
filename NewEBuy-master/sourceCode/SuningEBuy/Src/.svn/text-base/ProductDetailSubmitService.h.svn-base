//
//  ProductDetailSubmitService.h
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"
#import "MemberOrderDetailsDTO.h"

@class ProductDetailSubmitService;

@protocol ProductDetailSubmitServiceDelegate <NSObject>
@optional
-(void)ProductDisOrderSubmitHttpRequestCompleteWithService:(ProductDetailSubmitService *)service
                                                 isSuccess:(BOOL)isSuccess;

-(void)CheckURPhotoExistsHttpRequestCompleteWithService:(BOOL)isSubmitDisOrder 
                                      isOrderDetailLoad:(BOOL)isOrderDetailLoad
                                              isSuccess:(BOOL)isSuccess
                                               errorMsg:(NSString*)errorMsg;

@end


@interface ProductDetailSubmitService : DataService
{
    HttpMessage       *_checkURPhotoExistsMsg;
    HttpMessage       *_disorderSumbitMsg;
     CGFloat          percentage;//压缩比
}

@property (nonatomic, weak) id<ProductDetailSubmitServiceDelegate> delegate; 
@property (nonatomic, strong) NSMutableArray                *imageArray;
@property (nonatomic, strong) NSString                      *totalImageString;
@property (nonatomic, assign) BOOL                          isSubmitDisOrder;
@property (nonatomic, assign) BOOL                          isOrderDetailLoad;

- (void)sendSubmitOrderHttpRequest:(MemberOrderDetailsDTO*)meberOrderDetailsDTO 
                        imageArray:(NSMutableArray*)imageArray 
                  totalImageString:(NSString *)totalImageString 
                             title:(NSString*)title 
                           content:(NSString*)content;

-(void)checkURPhotoExistsHttpRequest:(MemberOrderDetailsDTO*)meberOrderDetailsDTO
                    isSubmitDisOrder:(BOOL)isSubmitDisOrder 
                   isOrderDetailLoad:(BOOL)isOrderDetailLoad;

@end
