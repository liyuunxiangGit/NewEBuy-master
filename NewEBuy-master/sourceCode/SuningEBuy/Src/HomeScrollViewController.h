//
//  HomeScrollViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//


#import "BBScrollViewController.h"
#import "SpecialSubjectService.h"
#import "SNActivityDTO.h"

@interface HomeScrollViewController : BBScrollViewController <SpecialSubjectServiceDelegate, UINavigationControllerDelegate>
{    
    BOOL    isOnSaleLoaded;
}

@property (nonatomic, strong) NSArray *specialSebjectList;
@property (nonatomic, strong) SpecialSubjectService *service;
@property (nonatomic) BOOL    isOnSaleLoaded;


@end
