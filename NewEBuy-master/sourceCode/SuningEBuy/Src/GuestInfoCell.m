//
//  GuestInfoCell.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "GuestInfoCell.h"
#import "Preferences.h"

#define fontSize   [UIFont boldSystemFontOfSize:15.0]
#define kTextFieldWidth  160


@implementation GuestInfoCell

@synthesize dateList = _dateList;

@synthesize username = _username;
@synthesize usernameTextField = _usernameTextField;

@synthesize arriveTime = _arriveTime;
@synthesize arriveTimePicker = _arriveTimePicker;
@synthesize arriveTimeTextField = _arriveTimeTextField;
@synthesize arrowBtn=_arrowBtn;

@synthesize leaveTime = _leaveTime;
//@synthesize leaveTimePicker = _leaveTimePicker;
@synthesize leaveTimeTextField = _leaveTimeTextField;
@synthesize delegate = _delegate;
@synthesize checkInTime = _checkInTime;

@synthesize earliestArriveTime = _earliestArriveTime;
@synthesize lastestArriveTime = _lastestArriveTime;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_dateList);
    
    TT_RELEASE_SAFELY(_usernameTextField);
    TT_RELEASE_SAFELY(_username);
    
    TT_RELEASE_SAFELY(_arriveTimeTextField);
    TT_RELEASE_SAFELY(_arriveTimePicker);
    TT_RELEASE_SAFELY(_arriveTime);
    
    TT_RELEASE_SAFELY(_leaveTimeTextField);
//    TT_RELEASE_SAFELY(_leaveTimePicker);
    TT_RELEASE_SAFELY(_leaveTime);
    TT_RELEASE_SAFELY(_checkInTime);
    
    TT_RELEASE_SAFELY(_earliestArriveTime);
    TT_RELEASE_SAFELY(_lastestArriveTime);
    
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor whiteColor];        
        
		self.autoresizesSubviews = YES;
                
        if (!_dateList) {
            _dateList = [[NSArray alloc] initWithObjects:@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",
                                                         @"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00", @"18:00",nil];
//            ,@"16:00",@"17:00", @"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"
        }
        
    }
    
    return self;
}


- (UILabel *)username{
    
    if (!_username) {
        
        _username = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _username.backgroundColor = [UIColor clearColor];
        
        _username.font = fontSize;
        
        [self.contentView addSubview:_username];
        
    }
    return _username;
}

- (UITextField *)usernameTextField{
    
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _usernameTextField.backgroundColor = [UIColor clearColor];
        _usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _usernameTextField.textAlignment=NSTextAlignmentRight;
        _usernameTextField.delegate = self;
        _usernameTextField.tag = 9;
        _usernameTextField.placeholder = L(@"Please enter guest name");
        _usernameTextField.font = [UIFont systemFontOfSize:15];
//        _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self.contentView addSubview:_usernameTextField];
    }
    return _usernameTextField;
}


- (UILabel *)arriveTime{
    
    if (!_arriveTime) {
        
        _arriveTime = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _arriveTime.font = fontSize;
        
        _arriveTime.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_arriveTime];
        
    }
    return _arriveTime;
}


- (UIPickerView *)arriveTimePicker{
    
    if (!_arriveTimePicker) {
        _arriveTimePicker = [[UIPickerView alloc] init];
//        _arriveTimePicker.datePickerMode = UIDatePickerModeTime;
        _arriveTimePicker.hidden = NO;
        _arriveTimePicker.tag = 1;
        _arriveTimePicker.delegate = self;
        _arriveTimePicker.dataSource = self;
        _arriveTimePicker.showsSelectionIndicator = YES;

//        _arriveTimePicker.date = [NSDate date];
//        [_arriveTimePicker addTarget:self
//                              action:@selector(changeDate:)
//                    forControlEvents:UIControlEventValueChanged];
    }
    return _arriveTimePicker;
}

- (ToolBarTextField *)arriveTimeTextField{
    
    if (!_arriveTimeTextField) {
        _arriveTimeTextField = [[ToolBarTextField alloc] initWithFrame:CGRectZero];
        _arriveTimeTextField.backgroundColor = [UIColor clearColor];
        _arriveTimeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _arriveTimeTextField.textAlignment=NSTextAlignmentRight;
        _arriveTimeTextField.inputView = self.arriveTimePicker;
        _arriveTimeTextField.delegate = self;
        _arriveTimeTextField.tag = 9;
//        _arriveTimeTextField.text = @"12:00";
        _arriveTimeTextField.text=self.earliestArriveTime;
        _arriveTimeTextField.toolBarDelegate = self;
        _arriveTimeTextField.placeholder = L(@"Please select arrive time");
        _arriveTimeTextField.font = [UIFont systemFontOfSize:15];
//        _arriveTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self.contentView addSubview:_arriveTimeTextField];
    }
    
    return _arriveTimeTextField;
}
-(UIButton*)arrowBtn{
    if (_arrowBtn==nil) {
        _arrowBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
        [_arrowBtn setFrame:CGRectMake(285, self.arriveTimeTextField.bottom+17, 11, 6)];
        [_arrowBtn setBackgroundImage:[UIImage imageNamed:@"arrow_bottom_gray@2x.png"] forState:UIControlStateNormal];
        [_arrowBtn addTarget:self action:@selector(inputArriveTime) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_arrowBtn];
    }
    return _arrowBtn;
}


- (UILabel *)leaveTime{
    
    if (!_leaveTime) {
        
        _leaveTime = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _leaveTime.backgroundColor = [UIColor clearColor];
        
        _leaveTime.font = fontSize;
        
        [self.contentView addSubview:_leaveTime];
        
    }
    return _leaveTime;
}


//- (UIDatePicker *)leaveTimePicker{
//    
//    if (!_leaveTimePicker) {
//        _leaveTimePicker = [[UIDatePicker alloc] init];
//        _leaveTimePicker.datePickerMode = UIDatePickerModeTime;
//        _leaveTimePicker.hidden = NO;
//        _leaveTimePicker.tag = 2;
//        _leaveTimePicker.date = [NSDate date];
//        [_leaveTimePicker addTarget:self
//                              action:@selector(changeDate:)
//                    forControlEvents:UIControlEventValueChanged];
//
//    }
//    return _leaveTimePicker;
//}

- (ToolBarTextField *)leaveTimeTextField{
    
    if (!_leaveTimeTextField) {
        _leaveTimeTextField = [[ToolBarTextField alloc] initWithFrame:CGRectZero];
        _leaveTimeTextField.backgroundColor = [UIColor clearColor];
        _leaveTimeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _leaveTimeTextField.textAlignment=NSTextAlignmentRight;
//        _leaveTimeTextField.inputView = self.leaveTimePicker;
        _leaveTimeTextField.delegate = self;
        _leaveTimeTextField.userInteractionEnabled = NO;
        _leaveTimeTextField.tag = 9;
//        _leaveTimeTextField.text = @"15:00";
        _leaveTimeTextField.text=self.lastestArriveTime;
        _leaveTimeTextField.toolBarDelegate = self;
        _leaveTimeTextField.placeholder = L(@"Please select leave time");
        _leaveTimeTextField.font = [UIFont systemFontOfSize:15];
//        _leaveTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    
    return _leaveTimeTextField;
}

-(UIImageView*)newLineImageView
{
    UIImageView* lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
    [lineImage setImage:img];

    return lineImage;
}
-(void)inputArriveTime
{
    [self.arriveTimeTextField becomeFirstResponder];
}
#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.dateList count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.dateList objectAtIndex:row];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor = [UIColor clearColor];
    [label setText:[self.dateList objectAtIndex:row]];
    label.font  = [UIFont boldSystemFontOfSize:15.0];
    [label setTextAlignment:UITextAlignmentCenter];
    return label;
    
}

//-(void) changeDate:(id)sender{
//    
//    UIDatePicker *picker = (UIDatePicker *)sender;
//    
//    if (picker.tag == 1) {
//        
//        NSDate * selected = [self.arriveTimePicker date];
////        NSString * date = [selected description];
//        self.arriveTimeTextField.text = [Preferences hourMinute:selected];    
//    }
//    else{
//        
//        NSDate * selected = [self.leaveTimePicker date];
////        NSString * date = [selected description];
//        self.leaveTimeTextField.text = [Preferences hourMinute:selected];   
//    } 
//}

- (void)cancelButtonClicked:(id)sender{
//    if ([self.arriveTimeTextField isFirstResponder]) {
        
        [self.arriveTimeTextField resignFirstResponder];
//    }
//    else{
//        [self.leaveTimeTextField resignFirstResponder];
//    }
}

- (void)doneButtonClicked:(id)sender{

    NSInteger certificateTypeRow = [self.arriveTimePicker selectedRowInComponent:0];

    self.arriveTimeTextField.text = [self.dateList objectAtIndex:certificateTypeRow];
    
    //本地存储最早到店面时间
    self.earliestArriveTime=[self.dateList objectAtIndex:certificateTypeRow];
    
    NSString *arr = self.checkInTime;
    
    NSString *currentDate = [Preferences currentSystemTime];
    
    if ([currentDate hasPrefix:arr]) {
        
        if ([self convertDateToString:[currentDate substringWithRange:NSMakeRange(11, 2)]] >= [self convertDateToString:[self.arriveTimeTextField.text substringWithRange:NSMakeRange(0, 2)]]) {
            
            self.arriveTimeTextField.text = @"";
    
            if ([_delegate conformsToProtocol:@protocol(GuestInfoCellDelegate) ]) {
                if ([_delegate respondsToSelector:@selector(setArriveTime:leaveTime:)]) {
                    [_delegate setArriveTime:self.arriveTimeTextField.text leaveTime:self.leaveTimeTextField.text];
                }
            }
            return;        
        }
    }

    if (certificateTypeRow <= 9) {
        self.leaveTimeTextField.text = [self.dateList objectAtIndex:certificateTypeRow + 3];
        self.lastestArriveTime=[self.dateList objectAtIndex:certificateTypeRow + 3];
    }
    else{
        self.leaveTimeTextField.text = [self.dateList objectAtIndex:12];
        self.lastestArriveTime=[self.dateList objectAtIndex:12];
    }
    
    [self.arriveTimeTextField resignFirstResponder];
    
    if ([_delegate conformsToProtocol:@protocol(GuestInfoCellDelegate) ]) {
        if ([_delegate respondsToSelector:@selector(setArriveTime:leaveTime:)]) {
            [_delegate setArriveTime:self.earliestArriveTime leaveTime:self.lastestArriveTime];
        }
    }
    
//    }
//    else{
//        NSDate * selected = [self.leaveTimePicker date];
//        NSString * date = [selected description];
//        NSLog(@"=========   ======%@",date);
//        self.leaveTimeTextField.text = [Preferences hourMinute:selected];    
//        [self.leaveTimeTextField resignFirstResponder];        
//    }
}


- (int)convertDateToString:(NSString *)string{
    
    int date = 0;
    
    if ([string hasPrefix:@"0"]) {
        
        date = [[string substringToIndex:1] intValue];
    }
    else{
        date = [string intValue];
    }
    
    return date;
}


- (void)initDataSourceWithRoomNum:(NSString *)roomNum isChangeRoomNum:(BOOL)isChangeRoomNum checkInTime:(NSString *)checkInTime earliestArriveTime:(NSString *)time1 lastestArriveTime:(NSString *)time2 guestInfo:(NSDictionary *)guestInfo{
    
    if (!isChangeRoomNum) {
        
        return;
    }
    self.checkInTime = checkInTime;
    
    
    
    UIImageView* topLineImage=[self newLineImageView];
    [self.contentView addSubview:topLineImage];
    
    for (int i = 0; i< [roomNum intValue]; i ++) {
        
        UILabel *username= [[UILabel alloc] initWithFrame:CGRectZero];        
        username.backgroundColor = [UIColor clearColor];
        username.font = fontSize;
        username.frame = CGRectMake(10, 5 + 35 * i, 100, 30);
        username.tag = i;
        username.text = [NSString stringWithFormat:@"%@%d%@",L(@"BTHotelPartOne"),i+1,L(@"BTGuestName")];
        [self.contentView addSubview:username];

        UITextField  *usernameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        usernameTextField.frame = CGRectMake(120, 5 + 35 * i, kTextFieldWidth, 30);
        usernameTextField.tag = i;
        usernameTextField.returnKeyType = UIReturnKeyDone;
        usernameTextField.backgroundColor = [UIColor clearColor];
        usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        usernameTextField.delegate = self;
        
        NSString *guestName = [guestInfo objectForKey:[NSString stringWithFormat:@"%d",i]];
        if (guestName == nil || [guestName isEqualToString:@""]) {
//            usernameTextField.text = @"请输入房间客人姓名";
        }
        else
        {
            usernameTextField.text = guestName;
        }
        usernameTextField.placeholder = L(@"Please enter guest name");
        usernameTextField.textAlignment=NSTextAlignmentRight;
//        usernameTextField.font = [UIFont fontWithName:@"Heiti k" size:15.0];
        usernameTextField.font=[UIFont systemFontOfSize:15];
//        usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self.contentView addSubview:usernameTextField];
        
        UIImageView* lineImage=[self newLineImageView];
        lineImage.top=usernameTextField.bottom+4.5;
        [self.contentView addSubview:lineImage];
        
    }
    self.arriveTimeTextField.text=time1;
    self.leaveTimeTextField.text=time2;
    [self.contentView addSubview:self.leaveTimeTextField];
    [self.contentView addSubview:self.leaveTime];
    [self.contentView addSubview:self.arriveTime];
    [self.contentView addSubview:self.arriveTimeTextField];
    [self.contentView addSubview:self.arrowBtn];


    self.arriveTime.frame = CGRectMake(10, 5 + 35*[roomNum intValue], 100, 30);
    self.arriveTimeTextField.frame = CGRectMake(120, 5 + 35*[roomNum intValue], kTextFieldWidth, 30);
    self.arriveTime.text = L(@"BTEarlyArriveTime");
    self.arrowBtn.top=self.arriveTimeTextField.top+12;
    
//    self.arriveTimeTextField.text = @"";
    self.leaveTime.frame = CGRectMake(10, self.arriveTimeTextField.bottom + 5, 100, 30);
    self.leaveTimeTextField.frame = CGRectMake(120, self.arriveTimeTextField.bottom + 5, kTextFieldWidth, 30);
    self.leaveTime.text = L(@"BTLaterArriveTime");
//    self.leaveTimeTextField.text = @"";
    
    UIImageView* arriveLineImage=[self newLineImageView];
    arriveLineImage.top=self.arriveTimeTextField.bottom+4.5;
    [self.contentView addSubview:arriveLineImage];
    
    UIImageView* leaveLineImage=[self newLineImageView];
    leaveLineImage.top=self.leaveTimeTextField.bottom+4.5;
    [self.contentView addSubview:leaveLineImage];

}

-(void)textFieldDidEndEditing:(UITextField *)textField{
      
    if ([_delegate conformsToProtocol:@protocol(GuestInfoCellDelegate) ]) {
        if ([_delegate respondsToSelector:@selector(setGuestName:withTag:)]) {
            [_delegate setGuestName:textField.text withTag:textField.tag];
        }
    }
    
    [textField resignFirstResponder];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.arriveTimeTextField) {
        
        return NO;
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    
    return NO;
}


@end
