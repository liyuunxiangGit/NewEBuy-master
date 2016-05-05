//
//  SNCommentShareService.h
//  SuningEBuy
//
//  Created by Joe on 14-11-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SNCommentShareServiceDelegate;
@interface SNCommentShareService : DataService

@property(nonatomic,weak)id<SNCommentShareServiceDelegate> delegate;

-(void)validata:(NSString*)orderId customerId:(NSString*)customerId ;
-(void)uploadImage:(NSString*)imagePath token:(NSString*)token orderId:(NSString*)orderId userId:(NSString*)userId imageLocalId:(NSString*)imageId;
-(void)publish:(NSString*)content orderId:(NSString*)orderId partNumer:(NSString*)number isPublic:(BOOL)isPublic productStar:(int)prodcutStar deliverStar:(int)deliverStar serviceStar:(int)deliverStar imageResourceIds:(NSMutableArray*)resouceIds;

@end


@protocol SNCommentShareServiceDelegate <NSObject>

-(void)validataResult:(BOOL)isSuccess token:(NSString*)token;
-(void)imageUploadedResult:(BOOL)isSuccess imageId:(NSString*)imageId resultId:(NSString*)resourceId;
-(void)publishResult:(BOOL)isSuccess commentId:(NSString*)commemtId serviceId:(NSString*)serviceId showId:(NSString*)showId;
@end