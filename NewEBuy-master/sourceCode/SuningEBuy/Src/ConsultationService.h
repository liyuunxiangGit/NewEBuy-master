//
//  ConsultationService.h
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "ConsultListDTO.h"

@protocol ConsultationDelegate <NSObject>
@optional
- (void)GetConsultListDelegate:(NSArray *)list error:(NSString *)error;

- (void)GetConsultCountDelegate:(NSString *)consultnum error:(NSString *)error;

- (void)GetMyConsultDelegate:(NSArray *)consultnum error:(NSString *)error;

- (void)PublishConsultDelegate:(BOOL)issuccess error:(NSString *)error;

- (void)GetConsultNumDelegate:(BOOL)issuccess error:(NSString *)error ConsultDTO:(ConsultNumDetailsDTO *)dto;

- (void)GetConsultSatisfactionDelegate:(BOOL)issuccess error:(NSString *)error;

-(void)GetConsultationTypeDelegate:(BOOL)issuccess error:(NSString *)error list:(NSArray *)list;
@end


@interface ConsultationService : DataService
{
    HttpMessage        *ListHttpMsg;

}
@property (nonatomic, weak) id<ConsultationDelegate> delegate;

- (void)SendConsultlistHttpRequest:(SendConsultListDTO *)senddto currentpage:(int)page;

- (void)SendConsultcountHttpRequest:(SendConsultListDTO *)senddto;

- (void)SendMyConsultlistHttpRequest:(int)page;

- (void)SendpublishHttpRequest:(SendPublishConsultDTO *)dto;

- (void)SendConsultnumDetailHttpRequest:(SendConsultListDTO *)senddto;


-(void)SendConsultSatisfactionHttpRequest:(NSString *)articleId isbook:(NSString *)isbook isflag:(NSString *)isflag;

-(void)SendConsultationType;
@end
