//
//  UPOMP.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_Value.h"
#import "UPOMP_MainViewController.h"
#import "UPOMP_BootViewController.h"
#import "UPOMP_KaTextFieldToolBarViewController.h"
#import "UPOMP_KaTBXML.h"

@protocol UPOMPDelegate<NSObject>
@required
-(void)viewClose:(NSData*)data;
@end

@interface UPOMP : UIViewController<UIAlertViewDelegate>{
    UPOMP_Value *defaultValue;
    UPOMP_MainViewController *mainView;
    UPOMP_BootViewController *bootView;
    UPOMP_KaTextFieldToolBarViewController *textFieldToolBar;
    BOOL viewClose;
    UIAlertView *alert;
}
-(void)checkClose;
- (void)loadingOver;
- (BOOL)getConfigInfos;
- (void)setXmlData:(NSData*)data;
- (void)closeView:(NSData*)data;
- (NSData*)getXML:(NSString*)myDes;
- (BOOL)saveXMLbyTag:(NSString*)tag xmlElement:(UPOMP_TBXMLElement*)root xml:(UPOMP_KaTBXML*)xml;
- (BOOL)saveXMLbyTag_onLine:(NSString*)tag xmlElement:(UPOMP_TBXMLElement*)root xml:(UPOMP_KaTBXML*)xml;
- (NSData*)setPostDataByAppName:(NSString*)appName keys:(NSArray*)keys values:(NSArray*)values anotherInfo:(NSString *)anotherStr;
@property (nonatomic, assign) id <UPOMPDelegate> viewDelegate;
@property (nonatomic,retain)  UPOMP_Value *defaultValue;
@property (nonatomic,retain) UPOMP_MainViewController *mainView;
@property (nonatomic,readonly) UPOMP_KaTextFieldToolBarViewController *textFieldToolBar;
@property (nonatomic,readonly) NSArray *t1;
@property (nonatomic,readonly) NSArray *t2;
@property (nonatomic,readonly) NSArray *t3;
@property (nonatomic,readonly) NSArray *t4;
@property (nonatomic,readonly) NSMutableDictionary *upompDictionary;
@end
