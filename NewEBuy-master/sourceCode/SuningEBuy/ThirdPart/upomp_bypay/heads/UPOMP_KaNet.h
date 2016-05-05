//
//  KaNet.h
//  mylibs
//
//  Created by pei xunjun on 11-11-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UPOMP;

@protocol UPOMP_KaNetDelegate<NSObject>
@required
-(void)netError:(NSError*)error;
-(void)netFinish:(NSData*)data;
@end

@interface UPOMP_KaNet : NSObject {
	NSMutableData *netData;
	NSMutableURLRequest *request;
	NSURLConnection *conn;
	UPOMP *upomp;
	NSMutableString *key;
	BOOL isImage;
    BOOL willRelease;
    BOOL hasTimer;
    NSTimer *timer;
}
- (id)initWithView:(UPOMP*)view;
- (void)start:(NSData*)data URL:(NSString*)url;
- (void)cancel;
-(void)WillRe;
-(void)getImageByURL:(NSString*)url otherURL:(NSString*)otherURL;

@property(readonly)BOOL netComplete;
@property (nonatomic, assign) id <UPOMP_KaNetDelegate> netDelegate;
@end
