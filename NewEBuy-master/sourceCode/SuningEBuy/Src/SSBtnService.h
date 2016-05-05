//
//  SSBtnService.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SingleBtn : UIButton



@property(nonatomic,strong)NSString *btnValue;
@end

@interface SSBtnService : NSObject



@property (nonatomic,strong)NSArray *btnArray;


-(void)touchbtn:(SingleBtn *)btn;

-(NSString *)singleValue;
@end
