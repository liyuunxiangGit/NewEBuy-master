//
//  BoardingItemCell.m
//  SuningEBuy
//
//  Created by david on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BoardingItemCell.h"

@interface BoardingItemCell()

@property(nonatomic,strong) UILabel       *leftLbl;
@property(nonatomic,strong) UITextField   *rightFld;
@property(nonatomic,strong) UIPickerView  *certiPickerView;
@property(nonatomic,strong) UIToolbar     *keyboardDoneButtonView;
@property(nonatomic,strong) UIDatePicker  *datePicker;
@property(nonatomic,strong) UIToolbar     *birthdayKeyboardDoneButtonView;

@end


@implementation BoardingItemCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        UIView *whiteView = [[UIView alloc]init];
        whiteView.backgroundColor = [UIColor whiteColor];
        self.backgroundView = whiteView;
        
    }
    return self;
}

#pragma mark -
#pragma mark 刷新视图
-(void)refreshCell:(CellItemType)cellType{
    
    itemType_ = cellType;
    
    switch (cellType) {
            
        case CellItemName:
        {
            self.leftLbl.text = L(@"user name:");
            
            if (_boardingInfoDto.firstName) {
                self.rightFld.text = _boardingInfoDto.firstName;
            }else{
                self.rightFld.placeholder = L(@"BTPleaseInputName");
            }
            break;
        }
        case CellItemCertificateType:{
            
            self.leftLbl.text = L(@"BTCredentialsKind");
            self.rightFld.inputView = self.certiPickerView;
            self.rightFld.inputAccessoryView = self.keyboardDoneButtonView;
            if (_boardingInfoDto.cardType) {
                int index = [self.boardingInfoDto.cardType intValue];
                if (index == 9) {
                    index = 6;
                }
                self.rightFld.text = [self.certiList objectAtIndex:index];
            }else{
                self.rightFld.text = L(@"BTIdentityCard");
            }
            break;
        }
        case CellITemCertificate:{
            
            self.leftLbl.text = L(@"BTCredentialsNumber");
            if (_boardingInfoDto.idCode) {
                self.rightFld.text = _boardingInfoDto.idCode;
            }else{
                self.rightFld.placeholder = L(@"BTPleaseInputCredentialsNumber");
            }
            break;
        }
        default:{
            self.leftLbl.text = L(@"BTBirthdayDate");
            self.rightFld.inputView = self.datePicker;
            self.rightFld.inputAccessoryView = self.birthdayKeyboardDoneButtonView;
            if (_boardingInfoDto.birthday) {
                if(_boardingInfoDto.birthday.length>10) {
                    NSString *tmpStr = [_boardingInfoDto.birthday substringToIndex:10];
                    self.rightFld.text = tmpStr;
                }else{
                    self.rightFld.text = _boardingInfoDto.birthday;
                }
            }else{
                self.rightFld.placeholder = L(@"BTPleaseInputBirthdayDate");
            }
            break;
        }
    }
}

#pragma mark -
#pragma mark 隐藏键盘
-(void)resignTextField{
    
    [self.rightFld resignFirstResponder];
}

#pragma mark -
#pragma mark UIView 

-(UILabel *)leftLbl{
    if (!_leftLbl) {
        _leftLbl = [[UILabel alloc]init];
        _leftLbl.backgroundColor = [UIColor clearColor];
        _leftLbl.frame = CGRectMake(15, 0, 80, 44);
        _leftLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_leftLbl];
    }
    return _leftLbl;
}

-(UITextField *)rightFld{
    
    if (!_rightFld) {
        _rightFld = [[UITextField alloc]init];
        _rightFld.backgroundColor = [UIColor clearColor];
        _rightFld.frame = CGRectMake(100, 0, 200, 44);
        _rightFld.font = [UIFont systemFontOfSize:14];
        _rightFld.returnKeyType = UIReturnKeyDone;
        _rightFld.delegate = self;
        _rightFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.contentView addSubview:_rightFld];
    }
    return _rightFld;
}


#pragma mark -
#pragma mark 选择证件类型
- (UIPickerView *)certiPickerView
{
    
    if (!_certiPickerView)
    {
        _certiPickerView = [[UIPickerView alloc] init];
        _certiPickerView.delegate = self;
        _certiPickerView.dataSource = self;
        _certiPickerView.showsSelectionIndicator = YES;
        _certiPickerView.opaque = NO;
    }
    
    return _certiPickerView;
}

- (UIToolbar *)keyboardDoneButtonView
{
    if (!_keyboardDoneButtonView)
    {
        _keyboardDoneButtonView = [[UIToolbar alloc] init];
        _keyboardDoneButtonView.barStyle = UIBarStyleBlack;
        _keyboardDoneButtonView.translucent = YES;
        [_keyboardDoneButtonView sizeToFit];
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Cancel")
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self
                                                                        action:@selector(pickerCancelClicked)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Ok")
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(pickerDoneClicked)];
        [_keyboardDoneButtonView setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
    }
    return _keyboardDoneButtonView;
    
}

-(void)pickerCancelClicked{
    
    [self.rightFld resignFirstResponder];
}

-(void)pickerDoneClicked{
    
    NSInteger index = [self.certiPickerView selectedRowInComponent:0];
    
    self.rightFld.text = [self.certiList objectAtIndex:index];
    
    if(index == 6){
        
        self.boardingInfoDto.cardType = [NSString stringWithFormat:@"%d",index+3];
        
    }else{
        
        self.boardingInfoDto.cardType = [NSString stringWithFormat:@"%d",index];
    }
    
    [self.rightFld resignFirstResponder];
}


#pragma mark -
#pragma mark 选择出生日期
- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.date = [NSDate date];
    }
    return _datePicker;
}

- (UIToolbar *)birthdayKeyboardDoneButtonView
{
    if (!_birthdayKeyboardDoneButtonView)
    {
        _birthdayKeyboardDoneButtonView = [[UIToolbar alloc] init];
        _birthdayKeyboardDoneButtonView.barStyle = UIBarStyleBlack;
        _birthdayKeyboardDoneButtonView.translucent = YES;
        [_birthdayKeyboardDoneButtonView sizeToFit];
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Cancel")
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self
                                                                        action:@selector(datePickerCancelClicked)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Ok")
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(datePickerDoneClicked)];
        [_birthdayKeyboardDoneButtonView setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
    }
    return _birthdayKeyboardDoneButtonView;
    
}

-(void)datePickerCancelClicked
{
    [self.rightFld resignFirstResponder];
}

-(void)datePickerDoneClicked{
    
    NSDate *date = [self.datePicker date];
    NSString *str = [NSDate stringFromDate:date withFormat:@"yyyy-MM-dd"];
    self.boardingInfoDto.birthday = str;
    self.rightFld.text = str;
    [self.rightFld resignFirstResponder];
}

#pragma mark -
#pragma mark UIPickViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.certiList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [self.certiList objectAtIndex:row];
    
    return title;
}

#pragma mark -
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (itemType_) {
            
        case CellItemName:
        {
            self.boardingInfoDto.firstName = textField.text;
            break;
        }
        case CellITemCertificate:{
            self.boardingInfoDto.idCode = textField.text;
            break;
        }
        default:
            break;
    }
}


@end
