//
//  ServiceStackViewController.h
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceStackViewController : CommonViewController
{
    
    UIView                      *_serviceTrack;
    
    UIView                      *_serviceApply;

}

@property (nonatomic, strong) UIView            *serviceTrack;

@property (nonatomic, strong) UIView            *serviceApply;

@end
