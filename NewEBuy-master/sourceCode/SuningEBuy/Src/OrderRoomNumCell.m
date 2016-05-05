//
//  OrderRoomNumCell.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "OrderRoomNumCell.h"

#define fontSize   [UIFont boldSystemFontOfSize:15.0]
#define kTextFieldWidth  160


@implementation OrderRoomNumCell

@synthesize hotelNameLabel=_hotelNameLabel;
@synthesize hotelTypeLabel=_hotelTypeLabel;

@synthesize orderRoomPickerView = _orderRoomPickerView;
@synthesize orderRoomData = _orderRoomData;
@synthesize orderRoomTextField = _orderRoomTextField;
@synthesize orderRoomLabel = _orderRoomLabel;

@synthesize arrowBtn=_arrowBtn;

@synthesize startTime = _startTime;
@synthesize startTimeTextField = _startTimeTextField;
@synthesize endTime = _endTime;
@synthesize endTimeTextField = _endTimeTextField;

@synthesize timeBackground = _timeBackground;
@synthesize delegate = _delegate;

@synthesize hasAddLine;
- (void)dealloc {
    TT_RELEASE_SAFELY(_hotelTypeLabel);
    TT_RELEASE_SAFELY(_hotelNameLabel);
    
    TT_RELEASE_SAFELY(_orderRoomTextField);
    TT_RELEASE_SAFELY(_orderRoomData);
    TT_RELEASE_SAFELY(_orderRoomPickerView);
    TT_RELEASE_SAFELY(_arrowBtn);
    
    TT_RELEASE_SAFELY(_orderRoomLabel);
    TT_RELEASE_SAFELY(_startTime);
    TT_RELEASE_SAFELY(_startTimeTextField);
    TT_RELEASE_SAFELY(_endTime);
    TT_RELEASE_SAFELY(_endTimeTextField);
    
    TT_RELEASE_SAFELY(_timeBackground);
    
}




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];        
		self.autoresizesSubviews = YES;
        
        if (!_orderRoomData) {
            
            _orderRoomData = [[NSArray alloc] initWithObjects:L(@"One suit"),L(@"Two suit"),L(@"Three suit"),L(@"Four suit"),L(@"Five suit"), nil];

        }

    }
    
    return self;
}

- (UILabel *)orderRoomLabel{
    
    if (!_orderRoomLabel) {
        
        _orderRoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.hotelTypeLabel.bottom+5, 100, 30)];
        
        _orderRoomLabel.backgroundColor = [UIColor clearColor];
        
        _orderRoomLabel.font = fontSize;
        
        [self.contentView addSubview:_orderRoomLabel];
        
    }
    
    return _orderRoomLabel;
}


- (UIPickerView *)orderRoomPickerView{
    
    if (!_orderRoomPickerView) {
        _orderRoomPickerView = [[UIPickerView alloc] init];
        _orderRoomPickerView.delegate = self;
        _orderRoomPickerView.dataSource = self;
        _orderRoomPickerView.showsSelectionIndicator = YES;
    }
    return _orderRoomPickerView;
}

- (ToolBarTextField *)orderRoomTextField{
    
    if (!_orderRoomTextField) {
        _orderRoomTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(120, self.hotelTypeLabel.bottom+5, kTextFieldWidth, 30)];
        _orderRoomTextField.backgroundColor = [UIColor clearColor];
        _orderRoomTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _orderRoomTextField.textAlignment=NSTextAlignmentRight;
        _orderRoomTextField.inputView = self.orderRoomPickerView;
        _orderRoomTextField.delegate = self;
        _orderRoomTextField.tag = 9;
        _orderRoomTextField.toolBarDelegate = self;
        _orderRoomTextField.placeholder = L(@"Please_select_suits");
        _orderRoomTextField.text = L(@"One suit");
        _orderRoomTextField.font = [UIFont systemFontOfSize:15];
//        _orderRoomTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self.contentView addSubview:_orderRoomTextField];
    }
    
    return _orderRoomTextField;
}
-(UIButton*)arrowBtn{
    if (_arrowBtn==nil) {
        _arrowBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
        [_arrowBtn setFrame:CGRectMake(285, self.hotelTypeLabel.bottom+17, 11, 6)];
        [_arrowBtn setBackgroundImage:[UIImage imageNamed:@"arrow_bottom_gray@2x.png"] forState:UIControlStateNormal];
        [_arrowBtn addTarget:self action:@selector(inputRoom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}
- (UILabel *)startTime{
    
    if (!_startTime) {
        
        _startTime = [[UILabel alloc] initWithFrame:CGRectMake(10, self.orderRoomTextField.bottom + 5, 100, 30)];
        
        _startTime.backgroundColor = [UIColor clearColor];
        
        _startTime.font = fontSize;
        
        [self.contentView addSubview:_startTime];
    }
    
    return _startTime;
}


- (UITextField *)startTimeTextField{
    
    if (!_startTimeTextField) {
        
        _startTimeTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, self.orderRoomTextField.bottom + 5, kTextFieldWidth, 30)];
//        _startTimeTextField.placeholder = L(@"Please enter detail address");
        _startTimeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _startTimeTextField.backgroundColor = [UIColor clearColor];
        _startTimeTextField.delegate = self;
        _startTimeTextField.borderStyle = UITextBorderStyleNone;
        _startTimeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _startTimeTextField.textAlignment=NSTextAlignmentRight;
        _startTimeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _startTimeTextField.keyboardType = UIKeyboardTypeDefault;
        _startTimeTextField.userInteractionEnabled = NO;
//        _startTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
        _startTimeTextField.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:_startTimeTextField];
    }
    
    return _startTimeTextField;
}

- (UILabel *)endTime{
    
    if (!_endTime) {
        
        _endTime = [[UILabel alloc] initWithFrame:CGRectMake(10, self.startTimeTextField.bottom + 5, 100, 30)];
        
        _endTime.backgroundColor = [UIColor clearColor];
        
        _endTime.font = fontSize;
        
        [self.contentView addSubview:_endTime];
    }
    
    return _endTime;
}


- (UITextField *)endTimeTextField{
    
    if (!_endTimeTextField) {
        
        _endTimeTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, self.startTimeTextField.bottom + 5, kTextFieldWidth, 30)];
//        _startTimeTextField.placeholder = L(@"Please enter detail address");
        _endTimeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _endTimeTextField.backgroundColor = [UIColor clearColor];
        _endTimeTextField.delegate = self;
        _endTimeTextField.borderStyle = UITextBorderStyleNone;
        _endTimeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _endTimeTextField.textAlignment=NSTextAlignmentRight;
        _endTimeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _endTimeTextField.keyboardType = UIKeyboardTypeDefault;
//        _endTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
        _endTimeTextField.font=[UIFont systemFontOfSize:15];
        _endTimeTextField.userInteractionEnabled = NO;
        [self.contentView addSubview:_endTimeTextField];
    }
    
    return _endTimeTextField;
}

- (UIImageView *)timeBackground{
    
    if (!_timeBackground) {
        
        _timeBackground = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        _timeBackground.image = [UIImage imageNamed:@"hotel_order_text_background.png"];
        
        _timeBackground.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_timeBackground];
    }
    
    return _timeBackground;
}


- (void)initDatasource:(NSArray *)array{
    
    if (array == nil) {
        return;
    }
    
    if (!self.hasAddLine) {
        UIImageView* topLineImage=[self newLineImageView];
        [self.contentView addSubview:topLineImage];
    }
    
    
    self.hotelNameLabel.text=[array objectAtIndex:0];
    self.hotelTypeLabel.text=[array objectAtIndex:1];
    
    if (!self.hasAddLine) {
        UIImageView* hotelTitleLineImageView=[self newLineImageView];
        hotelTitleLineImageView.top=self.hotelTypeLabel.bottom+4.5;
        [self.contentView addSubview:hotelTitleLineImageView];
    }
    
    
    self.orderRoomLabel.text = L(@"BTRoomOrderNumber");
    self.orderRoomTextField.tag = 2;
    self.startTime.text =L(@"BTComeTime");
    [self.contentView addSubview:self.arrowBtn];;
    
    if (!self.hasAddLine) {
        UIImageView* orderRoomLineImageView=[self newLineImageView];
        orderRoomLineImageView.top=self.orderRoomLabel.bottom+4.5;
        [self.contentView addSubview:orderRoomLineImageView];
    }
    
    
    if (!self.hasAddLine) {
        UIImageView* startTimeLineImageView=[self newLineImageView];
        startTimeLineImageView.top=self.startTime.bottom+4.5;
        [self.contentView addSubview:startTimeLineImageView];
    }
    
    
    self.startTimeTextField.text = [array objectAtIndex:2];
    self.endTime.text = L(@"BTLeaveTime");
    self.endTimeTextField.text = [array objectAtIndex:3];
    
    if (!self.hasAddLine) {
        UIImageView* endTimeLineImageView=[self newLineImageView];
        endTimeLineImageView.top=self.endTime.bottom+4.5;
        [self.contentView addSubview:endTimeLineImageView];
    }
    
    
    self.hasAddLine=1;
    
    
}
-(UILabel*)hotelNameLabel{
    if (_hotelNameLabel==nil) {
        _hotelNameLabel= [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 25)];
        _hotelNameLabel.backgroundColor = [UIColor clearColor];
        _hotelNameLabel.numberOfLines = 0;
        _hotelNameLabel.textColor=[UIColor light_Black_Color];
        _hotelNameLabel.font = [UIFont boldSystemFontOfSize:16];
        
        [self.contentView addSubview:_hotelNameLabel];
    }
    return _hotelNameLabel;
}

-(UILabel*)hotelTypeLabel
{
    if (_hotelTypeLabel==nil) {
        _hotelTypeLabel= [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 25)];
        _hotelTypeLabel.backgroundColor = [UIColor clearColor];
        _hotelTypeLabel.numberOfLines = 0;
        _hotelTypeLabel.textColor=[UIColor dark_Gray_Color];
        _hotelTypeLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.contentView addSubview:_hotelTypeLabel];

    }
    return _hotelTypeLabel;
}
-(UIImageView*)newLineImageView
{
    UIImageView* lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
    [lineImage setImage:img];
    
    return lineImage;
}
-(void)inputRoom
{
    [self.orderRoomTextField becomeFirstResponder];
}
#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.orderRoomData count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.orderRoomData objectAtIndex:row];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor = [UIColor clearColor];
    [label setText:[self.orderRoomData objectAtIndex:row]];
    label.font  = [UIFont boldSystemFontOfSize:15.0];
    [label setTextAlignment:UITextAlignmentCenter];
    return label;
    
}

- (void)doneButtonClicked:(id)sender{
    
    NSInteger certificateTypeRow = [self.orderRoomPickerView selectedRowInComponent:0];
    self.orderRoomTextField.text = [self.orderRoomData objectAtIndex:certificateTypeRow];

    if ([_delegate conformsToProtocol:@protocol(OrderRoomNumDelegate)]) {
        if ([_delegate respondsToSelector:@selector(selectOrderRoomNum:)]) {
            [_delegate selectOrderRoomNum:[NSString stringWithFormat:@"%d",certificateTypeRow+1]];
        }
    }

    
    [self.orderRoomTextField resignFirstResponder];
    
}

- (void)cancelButtonClicked:(id)sender{
    
    [self.orderRoomPickerView resignFirstResponder];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return NO;
} 


@end
