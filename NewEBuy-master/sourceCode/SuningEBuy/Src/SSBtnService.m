//
//  SSBtnService.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SSBtnService.h"

@implementation SingleBtn

@end

@implementation SSBtnService



-(void)touchbtn:(SingleBtn *)btn{
    
    for (SingleBtn *obj in _btnArray) {
        
        if (obj == btn) {
            
            if (NO == btn.isSelected) {
                
                btn.selected = YES;
            }
        }
        else{
            
            obj.selected = NO;
        }
    }
}

-(NSString *)singleValue{
    
    for (SingleBtn *obj in _btnArray) {
        
        if (YES == obj.isSelected) {
            
            
            return obj.btnValue;
        }

    }

    return nil;
}
@end
