//
//  HdMsgBox.h
//  HdMsgBoxDemo
//
//  Created by apple on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HdMsgBox : NSObject <MBProgressHUDDelegate>

+ (id)sharedInstance;

//HUD
- (void)hideHUD:(MBProgressHUD*)hud afterDelay:(NSTimeInterval)delay;
- (void)hideHUDInView:(UIView*)view;
- (void)hideAllHUDsInView:(UIView*)view;
- (MBProgressHUD*)showHUDTextOnly:(NSString*)text duration:(NSTimeInterval)duration inView:(UIView*)view;
- (MBProgressHUD*)showHUDLoading:(UIView*)view;
- (MBProgressHUD*)showHUDLoadingWithText:(NSString*)text inView:(UIView*)view;
- (MBProgressHUD*)showHUDLoadingWithDetailsText:(NSString*)text details:(NSString*)details inView:(UIView*)view;
- (MBProgressHUD*)showHUDCustomView:(UIView*)customView inView:(UIView*)view;
- (MBProgressHUD*)showHUDCustomView:(UIView*)customView afterDelay:(NSTimeInterval)delay inView:(UIView*)view;
- (MBProgressHUD*)showHUDCustomView:(UIView*)customView withText:(NSString*)text inView:(UIView*)view;
- (MBProgressHUD*)showHUDCustomView:(UIView*)customView withText:(NSString*)text afterDelay:(NSTimeInterval)delay inView:(UIView*)view;
-(void) showHUDWithMessgae:(NSString *)msg mode:(MBProgressHUDMode)mode InView:(UIView *) view;
-(void) showHUDWithMessgae:(NSString *)msg mode:(MBProgressHUDMode)mode InView:(UIView *) view BelowView : (UIView *) belowView;
//Alert
- (void)showAlertText:(NSString*)text;
- (void)showAlertText:(NSString*)text delegate:(id)delegate;
- (void)showAlertTitle:(NSString*)title text:(NSString*)text;
- (void)showAlertTitle:(NSString*)title text:(NSString*)text delegate:(id)delegate;
- (void)showAlertTitle:(NSString*)title text:(NSString*)text delegate:(id)delegate cancelButtonTitle:(NSString*)cancelButtonTitle okButtonTitle:(NSString*)okButtonTitle;

@end
