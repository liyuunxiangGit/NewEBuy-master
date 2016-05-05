//
//  UPOMP_ViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_CellViewController.h"
@class UPOMP;

@interface UPOMP_ViewController : UIViewController{
    UPOMP *upomp;
    BOOL isKeyBarUP;
    BOOL isScoll;
    UITableView *tabelView;
    UPOMP_CellViewController *myCell;
    int netIndex;
    BOOL tabelViewScoll;
}
-(void)upData:(int)index;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil upomp:(UPOMP*)obj;
- (void)keyboardWasShown:(NSNotification *) notif;
- (void)scrollToRow;
- (void)viewUP;
- (void)viewDown;
-(void)noSelectMyCell;
-(void)nextCell;
-(void)prevCell;
-(void)hiddenCell;
-(void)restScoll;
-(void)checkCellArray:(int)index;
-(void)setMyCell:(UPOMP_CellViewController*)cell;
-(void)getKeysAndValues:(NSMutableArray*)xArray key:(NSMutableArray*)xKey value:(NSMutableArray*)xValue;
-(BOOL)checkCellRule:(NSMutableArray*)xArray;
-(void)setAlertTitel:(NSString*)tString info:(NSString*)iString;
-(void)setSelectAlertTitel:(NSString*)tString info:(NSString*)iString;
-(void)netCancel;
- (void)rowToSelectedCell;
-(void)selectACT:(int)type;
@end
