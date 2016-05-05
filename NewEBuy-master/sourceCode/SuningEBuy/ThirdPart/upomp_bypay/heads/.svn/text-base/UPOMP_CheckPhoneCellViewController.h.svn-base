//
//  UPOMP_CheckPhoneCellViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_CellViewController.h"
#import "UPOMP_KaNet.h"

@interface UPOMP_CheckPhoneCellViewController : UPOMP_CellViewController<UITextFieldDelegate,UPOMP_KaNetDelegate>{
    IBOutlet UIButton *smsButton;
    IBOutlet UITextField *myField;
    IBOutlet UILabel* label;
    IBOutlet UIButton* bg;
    UPOMP_KaNet *net;
    NSTimer *timer;
    BOOL canReLoad;
    int countDownIndex;
    UPOMP_CheckPhoneCellViewController *phoneCell;
    NSString *phoneNum;
    BOOL isGetSMS;
    int secureInfo;
    int misc;
    BOOL hasLoadData;
    BOOL willRelease;
    BOOL notitel;
    BOOL isRest;
    BOOL isUseMainCount;
    BOOL isUseAddCardMainCount;
    NSDate *date;
//    BOOL isUseLoginCount;
}
-(IBAction)selectBG:(id)sender;
-(IBAction)reloadSMS:(id)sender;
-(void)setPhoneNum:(NSString*)num;
-(void)setPhoneNumCell:(id)cell;
-(void)setHasLoadData;
-(void)setWillRelease;
@property int secureInfo;
@property int misc;
@property BOOL hasLoadData;
@property BOOL notitel;
@property BOOL isRest;
@property BOOL isUseMainCount;
@property BOOL isUseAddCardMainCount;
@property BOOL isGetSMS;
//@property BOOL isUseLoginCount;
@end
