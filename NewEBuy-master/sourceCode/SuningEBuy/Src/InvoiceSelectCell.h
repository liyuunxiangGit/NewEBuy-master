//
//  InvoiceSelectCell.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-4-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceSelectCell : UITableViewCell

@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIImageView   *selectImgView;

- (void)setTitle:(NSString *)title canSelect:(BOOL)canSelect;
- (void)setItem:(NSString *)title isSelect:(BOOL)isSelect;

@end
