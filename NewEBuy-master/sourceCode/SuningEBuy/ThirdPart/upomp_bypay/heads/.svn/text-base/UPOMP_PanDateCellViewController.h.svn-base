//
//  UPOMP_PanDateCellViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_CellViewController.h"

@interface UPOMP_PanDateCellViewController : UPOMP_CellViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    IBOutlet UITextField *myField;
    IBOutlet UILabel* label;
    IBOutlet UIButton* bg;
    IBOutlet UIButton *infoButton;
    IBOutlet UIPickerView *picker;
    IBOutlet UILabel *yLabel;
    IBOutlet UILabel *mLabel;
    IBOutlet UIView *pickerBG;
    BOOL isUP;
    NSMutableArray *yyArray;
    NSMutableArray *mmArray;
    int year;
    int yyRow;
    int mmRow;
    BOOL noTitel;
}
-(IBAction)selectBG:(id)sender;
-(IBAction)infoAct:(id)sender;
@property BOOL noTitel;
@end
