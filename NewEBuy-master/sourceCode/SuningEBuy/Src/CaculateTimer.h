//
//  CaculateTimer.h
//  SuningEBuy
//
//  Created by shasha on 11-12-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculateTimer : NSObject{

    NSTimer          *timer_;
    long              pastTime_;
    
}


//@property (nonatomic, retain) NSTimer   *timer;

- (void)timerBegin;
- (void)timerEnd;

@end
