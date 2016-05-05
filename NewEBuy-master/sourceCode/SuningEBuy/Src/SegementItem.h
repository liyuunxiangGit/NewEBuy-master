//
//  SegementItem.h
//  SuningEBuy
//
//  Created by david on 14-2-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ItemArrowNone = 1,
    ItemArrowUp,
    ItemArrowDown
}ItemArrowType;

@interface SegementItem : UIButton

@property(nonatomic,assign) BOOL    isUp;
@property(nonatomic,copy)   NSString *upIconName;
@property(nonatomic,copy)   NSString *downIconName;
@property(nonatomic,copy)   NSString *upSelectedName;
@property(nonatomic,copy)   NSString *downSelectedName;


-(void)setSelected:(BOOL)selected arrowType:(ItemArrowType)type;

@end
