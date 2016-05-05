//
//  Http.h
//  WingLetter
//
//  Created by Hubert Ryan on 10-8-10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Http : NSObject 


+ (ASIFormDataRequest*)sendHttpRequest:(NSString*)funcName  
                                   URL:(NSString*)URL  
                            UrlParaDic:(NSDictionary *)attributesDic 
                              Delegate:(id)Delegate  
                        SucessCallback:(SEL)SucessCallback 
                          FailCallback:(SEL)FailCallback;

+ (ASIFormDataRequest*)sendHttpRequest:(NSString*)funcName  
                                   URL:(NSString*)URL 
                               isHttps:(BOOL)isHttps 
                            UrlParaDic:(NSDictionary *)attributesDic 
                              Delegate:(id)Delegate 
                        SucessCallback:(SEL)SucessCallback 
                          FailCallback:(SEL)FailCallback;

@end
