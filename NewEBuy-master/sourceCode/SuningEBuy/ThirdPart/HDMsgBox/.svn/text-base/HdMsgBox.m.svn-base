//
//  HdMsgBox.m
//  HdMsgBoxDemo
//
//  Created by apple on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HdMsgBox.h"

#define ALTER_YES_TITLE  @"是"
#define ALTER_NO_TITLE @"否"
#define ALTER_CLOSE_TITLE @"关闭"
#define ALTER_TIP_TITLETEXT @"提示"

@implementation HdMsgBox

+ (id)sharedInstance {
    static id state;
    if (!state) state = [[self alloc] init];
    return state;
}

- (void)dealloc
{
    [super dealloc];
}

//HUD
- (void)hideHUD:(MBProgressHUD *)hud afterDelay:(NSTimeInterval)delay {
    if (hud) [hud hide:YES afterDelay:delay];
}

- (void)hideHUDInView:(UIView*)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

- (void)hideAllHUDsInView:(UIView*)view {
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

- (MBProgressHUD*)showHUDTextOnly:(NSString*)text duration:(NSTimeInterval)duration inView:(UIView*)view {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
	hud.mode = MBProgressHUDModeText;
    hud.delegate = self;
	hud.detailsLabelText = text;
	hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
	[hud hide:YES afterDelay:duration];
    //hud.userInteractionEnabled = NO;
    return [hud autorelease];
}

- (MBProgressHUD*)showHUDLoading:(UIView*)view {
    return [self showHUDLoadingWithText:nil inView:view];
}

- (MBProgressHUD*)showHUDLoadingWithText:(NSString*)text inView:(UIView*)view {
    return [self showHUDLoadingWithDetailsText:text details:nil inView:view];
}

- (MBProgressHUD*)showHUDLoadingWithDetailsText:(NSString*)text details:(NSString*)details inView:(UIView*)view {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
	hud.mode = MBProgressHUDModeIndeterminate;
    hud.delegate = self;
    hud.labelText = text;
    hud.detailsLabelText = details;
    [hud show:YES];
    return [hud autorelease];
}

- (MBProgressHUD*)showHUDCustomView:(UIView*)customView inView:(UIView*)view {
    return [self showHUDCustomView:customView withText:nil inView:view];
}
-(void) showHUDWithMessgae:(NSString *)msg mode:(MBProgressHUDMode)mode InView:(UIView *) view
{
    MBProgressHUD  *HUD = [[[MBProgressHUD alloc] initWithView: view] autorelease];
    HUD.mode = mode;
    [view addSubview:HUD];
    HUD.labelText = msg;
    [HUD show:YES];
    
}
- (MBProgressHUD*)showHUDCustomView:(UIView*)customView afterDelay:(NSTimeInterval)delay inView:(UIView*)view {
    return [self showHUDCustomView:customView withText:nil afterDelay:delay inView:view];
}

- (MBProgressHUD*)showHUDCustomView:(UIView*)customView withText:(NSString*)text inView:(UIView*)view {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
	hud.mode = MBProgressHUDModeCustomView;
    hud.customView = customView;
    hud.delegate = self;
    hud.labelText = text;
    [hud show:YES];
    return [hud autorelease];
}
-(void) showHUDWithMessgae:(NSString *)msg mode:(MBProgressHUDMode)mode InView:(UIView *) view BelowView : (UIView *) belowView
{
     MBProgressHUD  *HUD = [[[MBProgressHUD alloc] initWithView: view] autorelease];
    HUD.mode = mode;
    [view insertSubview:HUD belowSubview:belowView];
    HUD.labelText = msg;
    [HUD show:YES];
    // [self performSelector:@selector(hideHUDAfterDelay:) withObject:[NSNumber numberWithInt:15]];
}

- (MBProgressHUD*)showHUDCustomView:(UIView*)customView withText:(NSString*)text afterDelay:(NSTimeInterval)delay inView:(UIView*)view {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
	hud.mode = MBProgressHUDModeCustomView;
    hud.customView = customView;
    hud.delegate = self;
    hud.labelText = text;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
    return [hud autorelease];
}

//Alert
- (void)showAlertText:(NSString*)text {
    [self showAlertTitle:@"提示" text:text delegate:nil cancelButtonTitle:ALTER_CLOSE_TITLE okButtonTitle:nil];
}

- (void)showAlertText:(NSString*)text delegate:(id)delegate {
    [self showAlertTitle:@"提示" text:text delegate:delegate cancelButtonTitle:ALTER_CLOSE_TITLE okButtonTitle:nil];
}

- (void)showAlertTitle:(NSString*)title text:(NSString*)text {
    [self showAlertTitle:title text:text delegate:nil cancelButtonTitle:ALTER_CLOSE_TITLE okButtonTitle:nil];
}

- (void)showAlertTitle:(NSString*)title text:(NSString*)text delegate:(id)delegate {
    [self showAlertTitle:title text:text delegate:delegate cancelButtonTitle:ALTER_CLOSE_TITLE okButtonTitle:nil];
}

- (void)showAlertTitle:(NSString*)title text:(NSString*)text delegate:(id)delegate cancelButtonTitle:(NSString*)cancelButtonTitle okButtonTitle:(NSString*)okButtonTitle {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:text 
                                                   delegate:delegate
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:okButtonTitle, nil];
    [alert show];
    [alert release];
     
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD*)hud {
	// Remove HUD from screen when the HUD was hidded
	[hud removeFromSuperview];
//	[hud release];
	hud = nil;
}

@end
