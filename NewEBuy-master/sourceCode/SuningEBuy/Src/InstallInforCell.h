//
//  InstallInforCell.h
//  SuningEBuy
//
//  Created by wei xie on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ServiceDetailDTO.h"

#define kServiceOrderName   @"serviceOrderName"
#define kServiceStatus      @"serviceStatus"
#define kTempString         @"tempString"
#define kWorkerName         @"workerName"
#define kWorkerTel          @"workerTel"

@interface InstallInforCell : UITableViewCell{
    
}

@property (nonatomic, strong) ServiceDetailDTO *installInforDto;

@property (nonatomic, strong) UILabel        *orderTypeLabel;

@property (nonatomic, strong) UILabel        *orderTypeDesLabel;

@property (nonatomic, strong) UILabel        *serviceStateLabel;

@property (nonatomic, strong) UILabel        *serviceStateDesLabel;

@property (nonatomic, strong) UILabel        *installTimeLab;

@property (nonatomic, strong) UILabel        *installTimeDesLab;

@property (nonatomic, strong) UILabel        *typeLabel;

@property (nonatomic, strong) UILabel        *typesLabel;

@property (nonatomic, strong) UILabel        *phoLabel;

@property (nonatomic, strong) UILabel        *phoneLabel;

- (id)initWithReuseIndetifier:(NSString *)reuseIndetifier;

- (void)setInstallInforCellContent:(ServiceDetailDTO *)inforDto;

@end
