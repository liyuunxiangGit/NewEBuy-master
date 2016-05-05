//
//  UITableViewCellEx.h
//  SuningEBuy
//
//  Created by zhaojw on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UITableViewCellEx : UITableViewCell {

	EGOImageView *_iconImageView;
	
	UILabel    *_titleLbl;
	
	UILabel    *_subtitleLbl;
}

@property(nonatomic,strong) EGOImageView *iconImageView;

@property(nonatomic,strong) UILabel      *titleLbl;

@property(nonatomic,strong) UILabel      *subtitleLbl;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

/**
 *  add by zhangbeibei:20141021
 *  更新cell中商品的价格图片
 */
- (void)updateCellProductPriceImage;

@end
