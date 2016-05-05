//
//  HotelIntroduceViewController.h
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelOrderBaseViewController.h"

#import "HotelIntroduceDTO.h"

#import "HotelIntroduceTitelCell.h"

@interface HotelIntroduceViewController : HotelOrderBaseViewController<UITextViewDelegate>
{
    ASIFormDataRequest                  *sendCommendASIHTTPRequest;
    
    BOOL            isLoaderOK;

}

@property (nonatomic, strong) HotelIntroduceDTO *postDto;

@property (nonatomic, strong) HotelIntroduceDTO *parseDto;

@property (nonatomic, strong) HotelIntroduceTitelCell *titelView;


@property (nonatomic, strong) UITextView *contentTextView;

@end
