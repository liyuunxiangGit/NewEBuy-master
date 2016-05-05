//
//  UPOMP_PinCellViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_CellViewController.h"
#import "UPOMP_KeyBoardView.h"

@interface UPOMP_PinCellViewController :  UPOMP_CellViewController<UITextFieldDelegate,UPOMP_KeyBoardViewDelegate>{
    IBOutlet UITextField *myField;
    IBOutlet UILabel* label;
    IBOutlet UIButton* bg;
    UPOMP_KeyBoardView *keyBoard;
    NSString *cardNum;
    int maxLenght;
    NSString *tempTitel;
    BOOL noTitel;
}
-(IBAction)selectBG:(id)sender;
-(void)setCardNum:(NSString *)card;
-(void)setTitle:(NSString *)title;
@property int maxLenght;
@property BOOL noTitel;
@end
