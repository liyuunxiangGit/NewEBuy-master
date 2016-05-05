//
//  serialNumberCell.h
//  SuningEBuy
//
//  Created by DP on 3/11/12.
//  Copyright (c) 2012 zhaofk. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"
#import <UIKit/UIKit.h>
#import "MYEbuyCoumonDTO.h"

@interface serialNumberCell : UITableViewCellEx{
    
    //易购券接口dto
    MYEbuyCoumonDTO *_item;
    
    //易购券号
    UILabel    *_serialNumberLbl;
    
}


@property(nonatomic,strong) MYEbuyCoumonDTO *item;

@property(nonatomic,strong) UILabel    *serialNumberLbl;

-(void) setItem:(MYEbuyCoumonDTO *)aItem;

@end
