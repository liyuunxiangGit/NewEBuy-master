//
//  Calculagraph.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////

@interface Calculagraph : NSObject 
{
@private
    CGFloat time_;
    
    CGFloat timeOut_;
        
    NSTimer *timer_;
    
    BOOL    _validate;
}

@property (nonatomic, assign) CGFloat time;

@property (nonatomic, assign) CGFloat timeOut;

@property (nonatomic, assign) CGFloat repeatInterval;   //default is 1

- (CGFloat)seconds;

- (void)start;

- (void)stop;


- (BOOL)isValidate;

@end



