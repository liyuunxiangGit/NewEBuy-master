//
//  ReturnGoodsNumberViewCell.h
//  SuningEBuy
//
//  Created by zl on 14-11-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReturnGoodsNumberCellDelegate <NSObject>
@optional
-(void)valueChange:(NSUInteger)number;
@end
@interface ReturnGoodsNumberViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* numberLab;
@property(nonatomic,strong)UIButton*  btnAdd;
@property(nonatomic,strong)UIButton* btnDelete;
@property(nonatomic,strong)UITextField* textNumber;
@property(nonatomic,assign)id<ReturnGoodsNumberCellDelegate> delegate;
@end
