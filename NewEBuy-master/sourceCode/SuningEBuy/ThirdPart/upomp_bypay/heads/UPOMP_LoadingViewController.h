//
//  UPOMP_LoadingViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UPOMP;

@interface UPOMP_LoadingViewController : UIViewController{
    IBOutlet UIButton *cancelButton;
    IBOutlet UILabel *textLabel;
    IBOutlet UIImageView *bgView;
    IBOutlet UIActivityIndicatorView *act;
    IBOutlet UIView *topBgView;
    IBOutlet UIImageView *blackBG;
    UPOMP *upomp;
    int loadingType;
}
-(IBAction)cancel:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil upomp:(UPOMP*)obj;
-(void)startLoadingByType:(int)type;
-(void)loadingOver;
@end
