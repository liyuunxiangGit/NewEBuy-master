//
//  BoardingItemCell.h
//  SuningEBuy
//
//  Created by david on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardingInfoDTO.h"

typedef enum {
    CellItemName = 1,
    CellItemCertificateType,
    CellITemCertificate,
    CELlItemBirthday
}CellItemType;

@interface BoardingItemCell : UITableViewCell<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    
    CellItemType        itemType_;
}

@property(nonatomic,strong) NSArray         *certiList;
@property(nonatomic,strong) BoardingInfoDTO *boardingInfoDto;


-(void)refreshCell:(CellItemType)cellType;

-(void)resignTextField;

@end
