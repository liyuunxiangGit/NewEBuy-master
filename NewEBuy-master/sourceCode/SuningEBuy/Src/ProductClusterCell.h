//
//  ProductClusterCell.h
//  SuningEBuy
//
//  Created by shasha on 12-4-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"DataProductBasic.h"
#import"ToolBarButton.h"
#import "ProductCommandDelegate.h"


@interface ProductClusterCell : UITableViewCell<UIPickerViewDelegate,UIPickerViewDataSource,ToolBarButtonDelegate>{

    ToolBarButton  *colorButton_;
    
    ToolBarButton  *versionButton_;
    
    UILabel        *colorNameLabel_;
    
    UILabel        *versionNameLabel_;
        
    UIPickerView *picker_;
    
    DataProductBasic *items_;
    
    id<ProductCommandDelegate> __weak clusterDelegate_;


}


@property(nonatomic,strong)ToolBarButton     *colorButton; 
@property(nonatomic,strong)ToolBarButton     *versionButton; 
@property(nonatomic,strong)UILabel           *colorNameLabel;
@property(nonatomic,strong)UILabel           *versionNameLabel;
@property(nonatomic,strong)UIPickerView *picker;



@property(nonatomic,strong)DataProductBasic *items;

@property(nonatomic,weak)id<ProductCommandDelegate> clusterDelegate;

-(void) setItems:(DataProductBasic *)aItem;

+ (CGFloat)height;

@end

