//
//  ActiveMyIntegerViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-9-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "TPKeyboardAvoidingTableView.h"
#import "AddressInfoPickerView.h"
#import "ToolBarTextField.h"
#import "OHAttributedLabel.h"
#import "MyIntegralService.h"
#import "NSAttributedString+Attributes.h"
#import "ValidationService.h"
#import "CheckCodeService.h"
#import "Calculagraph.h"

@interface ActiveMyIntegerViewController : CommonViewController<UITextFieldDelegate,ToolBarTextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,MyIntegralServiceeDelegate,CheckCodeServiceDelegate>

@property (nonatomic, strong) Calculagraph          *calculagraph;
- (id)initWithIntegral:(NSString *)integral;

@end
