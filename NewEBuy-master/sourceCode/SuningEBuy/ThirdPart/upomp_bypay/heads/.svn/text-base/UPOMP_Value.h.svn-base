//
//  UPOMP_Value.h
//  UPOMP
//
//  Created by pei xunjun on 11-11-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UPOMP_KaBase64.h"
#import "UPOMP_Ka3Des.h"
#import "UPOMP_KaRSA.h"
#import "UPOMP_KaMD5.h"
#import "UPOMP_KaPinBlock.h"

typedef enum UPOMP_AppType {
	UPOMP_CP_UpPay,
	UPOMP_CP_UpLogin,
	UPOMP_CP_UpRegister,
	UPOMP_CP_UpAccountManager,
	UPOMP_CP_UpPanManager
} UPOMP_AppType;

typedef enum UPOMP_ViewID {
    UPOMP_CP_Main,
    UPOMP_CP_QuickPay,
    UPOMP_CP_OrdinaryPay,
    UPOMP_CP_OrdinaryPayPassWord,
    UPOMP_CP_PayFinish,
    UPOMP_CP_QuickRegist,
    UPOMP_CP_RegistFinish,
    UPOMP_CP_UserMain,
    UPOMP_CP_ChangePassword,
    UPOMP_CP_ChangePhone,
    UPOMP_CP_CardMain,
    UPOMP_CP_CardNum,
    UPOMP_QuickCard,
    UPOMP_CP_CardPassword,
    UPOMP_CP_CardFinish,
    UPOMP_PayErrorFinish,
    UPOMP_MoreRegist,
    UPOMP_CardListOP,
    UPOMP_CardListQP,
    UPOMP_ForgetPassword,
    UPOMP_RestPassword,
    UPOMP_QuickCardFinish,
    UPOMP_About
} UPOMP_ViewID;

@interface UPOMP_Value : NSObject {
	
}
- (UITextField*)textFieldStyleByFrame:(CGRect)rect textDelegate:(id)delegate returnKeyType:(UIReturnKeyType)returnKeyType keyboardType:(UIKeyboardType)keyboardType;
- (UIButton*)buttonStyleWithPoint:(CGPoint)point Titel:(NSString*)titel imageURL:(NSString*)url;
- (UIButton*)textFieldButtonStyleWithPoint:(CGPoint)point Titel:(NSString*)titel imageURL:(NSString*)url;
- (UILabel*)tipsTextLabelStyleWithText:(NSString*)text;
- (NSBundle*)getMyBundle;
- (NSString*)getMyBundlePath:(NSString*)filename;
- (NSString*)decodeWithRSA3Des:(NSString*)str;
- (NSString*)formatAmt:(NSString*)str;
- (NSString*)formatPassword:(NSString*)str;
- (NSString*)formatTime:(NSString*)str;
- (NSString*)formatPhoneNum:(NSString *)str;
- (NSString*)formatCardNum:(NSString *)str;
- (NSMutableString*)formatCardName:(NSDictionary*)dic hasDefault:(BOOL)def;
- (BOOL)checkIsChinese:(NSString*)str;
- (BOOL)amtchString:(NSString*)str checkString:(NSString*)checkStr;
- (void)animateEaseInEaseOut:(CALayer*)laye delegate:(id)del;
- (void)animation_FadeIN_OUT_FromRight:(UIView *)theView delegate:(id)d;
- (void)animation_FadeIN_OUT_FromLeft:(UIView *)theView delegate:(id)d;
- (void)animation_FadeIN_OUT_UP:(UIView *)theView delegate:(id)d;
- (void)animation_FadeIN_OUT_DOWN:(UIView *)theView delegate:(id)d;
@property (nonatomic,readonly)UPOMP_KaBase64 *base64;
@property (nonatomic,readonly)UPOMP_Ka3Des *_3Des;
@property (nonatomic,readonly)UPOMP_KaRSA *rsa;
@property (nonatomic,readonly)UPOMP_KaMD5 *md5;
@property (nonatomic,readonly)UPOMP_KaPinBlock *pinBlock;
@end
