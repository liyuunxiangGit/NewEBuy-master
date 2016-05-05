//
//  UPOMP_ErrorInfoViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UPOMP;

@interface UPOMP_ErrorInfoViewController : UIViewController{
    IBOutlet UIButton *cancelButton;
    IBOutlet UIButton *okButton;
    IBOutlet UILabel *textLabel;
    IBOutlet UIImageView *bgView;
    IBOutlet UIView *topBgView;
    IBOutlet UIImageView *blackBG;
    IBOutlet UIImageView *errorIcon;
    int selcetType;
    UPOMP *upomp;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil upomp:(UPOMP*)obj;
-(IBAction)cancel:(id)sender;
-(IBAction)ok:(id)sender;
-(void)setErrorInfo:(NSString*)str errorType:(int)type;
-(void)setErrorInfo:(NSString*)str backButtonStr:(NSString*)bStr okButtonStr:(NSString*)oStr type:(int)type;
@end
