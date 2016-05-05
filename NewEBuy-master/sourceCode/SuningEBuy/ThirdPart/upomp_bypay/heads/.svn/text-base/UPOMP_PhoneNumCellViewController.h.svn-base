//
//  UPOMP_PhoneNumCellViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_CellViewController.h"

@interface UPOMP_PhoneNumCellViewController : UPOMP_CellViewController<UITextFieldDelegate>{
    IBOutlet UITextField *myField;
    IBOutlet UIButton* bg;
    IBOutlet UILabel* label;
    NSString *placeholderPhoneNum;
    NSString *placeholderStr;
    NSString *tempTitel;
    NSString *tempKey;
    NSString *value;
    BOOL notitel;
}
-(void)setPlaceholderPhoneNum:(NSString*)str;
-(void)setPlaceholder:(NSString*)str;
-(IBAction)selectBG:(id)sender;
-(void)setKey:(NSString*)tKey;
-(void)setValue:(NSString*)str;
-(BOOL)isSave;
@property BOOL noTitel;
@end
