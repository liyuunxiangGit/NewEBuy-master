//
//  UPOMP_CheckImageCellViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_CellViewController.h"
#import "UPOMP_KaNet.h"

@interface UPOMP_CheckImageCellViewController : UPOMP_CellViewController<UITextFieldDelegate,UPOMP_KaNetDelegate>{
    IBOutlet UITextField *myField;
    IBOutlet UILabel* label;
    IBOutlet UIButton* bg;
    IBOutlet UIButton *imageButton;
    IBOutlet UIActivityIndicatorView *actview;
    BOOL isLoading;
    BOOL isLoadWhenLoad;
    BOOL noTitel;
    int netIndex;
    UPOMP_KaNet *net;
    NSString *validateCodeUrl;
}
-(IBAction)selectBG:(id)sender;
-(IBAction)reloadImage:(id)sender;
@property BOOL isLoading;
@property BOOL isLoadWhenLoad;
@property BOOL noTitel;
@end
