//
//  Http.m
//  WingLetter
//
//  Created by Hubert Ryan on 10-8-10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Http.h"
#import "AppDelegate.h"

@implementation Http

+ (ASIFormDataRequest *)sendHttpRequest:(NSString*)funcName 
                                   URL:(NSString*)URL 
                            UrlParaDic:(NSDictionary *)attributesDic
                              Delegate:(id)Delegate 
                        SucessCallback:(SEL)SucessCallback
                          FailCallback:(SEL)FailCallback
{
	if(URL == nil)
    {
		DLog(@"funcName=%@ sendHttpRequest url is nil!\n",URL);
		
		return nil;
	}
	
//	if(![[AppDelegate currentAppDelegate] isNetReachable])
//    {
//		DLog(@" network is unavailable!\n");
//        		
//		return nil;
//	}
	
	DLog(@"funcName=%@ sendHttpRequest url=%@  UrlParaDic=%@\n",funcName,URL,[attributesDic description]);
	
	
	NSURL *url = [[NSURL  alloc] initWithString:URL];
	
	
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];

	if(attributesDic != nil)
    {
		
		NSArray *allKeys = [attributesDic allKeys];
		for(NSString *key in allKeys)
        {

			[request setPostValue:[attributesDic objectForKey:key] forKey:key];
		}
	}	

	[request setDefaultResponseEncoding:NSUTF8StringEncoding];	
	
	[request setDelegate:Delegate];
	
	[request setDidFinishSelector:SucessCallback];
	
	[request setDidFailSelector:FailCallback];
	
	[request startAsynchronous];
	
    TT_RELEASE_SAFELY(url);
    
	return request;
}

+ (ASIFormDataRequest*)sendHttpRequest:(NSString*) funcName  URL:(NSString*)URL isHttps:(BOOL)isHttps UrlParaDic:(NSDictionary *)attributesDic Delegate:(id)Delegate  SucessCallback:(SEL)SucessCallback FailCallback:(SEL)FailCallback
{
	
	if(URL == nil)
    {
		
		DLog(@"funcName=%@ sendHttpRequest url is nil!\n",URL);
		
		return nil;
		
	}
    
//	if(![[AppDelegate currentAppDelegate] isNetReachable])
//    {
//		
//		DLog(@" network is unavailable!\n");
//        		
//		return nil;
//	}
	
	
	DLog(@"funcName=%@ sendHttpRequest url=%@  UrlParaDic=%@\n",funcName,URL,[attributesDic description]);
	
	
	NSURL *url = [[NSURL  alloc] initWithString:URL];
	
	
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	
	if(attributesDic != nil)
    {
		
		NSArray *allKeys = [attributesDic allKeys];
		for(NSString *key in allKeys)
        {
			[request setPostValue:[attributesDic objectForKey:key] forKey:key];
		}
	}	
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];	
	
	[request setDelegate:Delegate];
	
	[request setDidFinishSelector:SucessCallback];
	
	[request setDidFailSelector:FailCallback];
    

    if (isHttps) 
    {
        [request setValidatesSecureCertificate:NO];
    }
    
	
	[request startAsynchronous];
    
    TT_RELEASE_SAFELY(url);
	
	return request;
}


@end