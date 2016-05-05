//
//  CategoryItemCell.h
//  SuningEBuy
//
//  Created by zhaojw on 11-9-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "V2FristCategoryDTO.h"
#import "SecondCategoryCell.h"

#define DetailCEllMaxNum 3

#define DetailCellH 80

@interface CategoryItemCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>{
    
	UILabel                *_menuTitleLbl;
    
    UILabel                *_firMenuTitleLbl;
	
	EGOImageView           *_menuImageView;
	
	V2FristCategoryDTO   *_item;
    
    BOOL                   _isSelect;
}

@property (nonatomic)BOOL    isSelect;

@property(nonatomic,strong) UILabel      *firMenuTitleLbl;
@property(nonatomic,strong) UILabel      *menuTitleLbl;
@property(nonatomic,strong) UIImageView     *footViewBack;
@property(nonatomic,strong) EGOImageView  *menuImageView;

@property(nonatomic,strong) V2FristCategoryDTO *item;

@property (nonatomic,weak)id myDelegate;

/***********************new UI ***************/
@property(nonatomic,strong) UIImageView *cellSeparatorLine;
@property(nonatomic,strong) UIImageView  *specailLine;
@property(nonatomic,strong) UILabel     *firstDesLbl;

@property(nonatomic,strong) UITableView *detailTable;
/***********************new UI ***************/

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat) height:(id*)item;

-(void) setItem:(V2FristCategoryDTO *)aItem withDescription:(NSString *)des;


@end