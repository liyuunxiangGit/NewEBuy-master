//
//  UITableViewCell+BgView.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-9-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (BgView)


- (void)setCoolBgViewWithCellPosition:(CellPosition)position;
- (void)setCoolBgViewWithCellPosition:(CellPosition)position hasLine:(BOOL)hasLine;

@end
