//
//  UPOMP_CardNumCellViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_CellViewController.h"

@interface UPOMP_CardNumCellViewController : UPOMP_CellViewController<UITextViewDelegate>{
    IBOutlet UITextView* myTextView;
    IBOutlet UIButton* bg;
    IBOutlet UILabel* placeholder;
    IBOutlet UIButton *clearButton;
    IBOutlet UIButton *infoButton;
    NSString *value;
    NSString *placeholderStr;
    BOOL isQP;
}
-(IBAction)selectBG:(id)sender;
-(IBAction)clearAct:(id)sender;
-(IBAction)infoAct:(id)sender;
-(void)setValue:(NSString*)str;
-(void)setPlaceholderStr:(NSString*)str;
-(BOOL)isSave;
@property BOOL isQP;
@end
