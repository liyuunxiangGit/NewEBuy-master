//
//  UPOMP_KaTextFieldToolBarViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UPOMP_MainViewController;

@interface UPOMP_KaTextFieldToolBarViewController : UIViewController{
    IBOutlet UIBarButtonItem *nextItem;
    IBOutlet UIBarButtonItem *prevItem;
    IBOutlet UIBarButtonItem *hiddenItem;
    IBOutlet UIBarButtonItem *spaceItem;
    UPOMP_MainViewController *mainView;
}
-(IBAction)next:(id)sender;
-(IBAction)prev:(id)sender;
-(IBAction)hidden:(id)sender;
- (void)setprevEnabled:(BOOL)b;
- (void)setnextEnabled:(BOOL)b;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil mainview:(UPOMP_MainViewController*)obj;
@end
