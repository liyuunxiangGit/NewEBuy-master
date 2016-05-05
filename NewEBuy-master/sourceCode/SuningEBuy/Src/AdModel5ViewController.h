//
//  AdModel5ViewController.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdModel5ViewController : CommonViewController{ 
    
    NSString *activeName_;
    NSString *define_;
    UITextView  *descTextView_;

}

@property (nonatomic, copy) NSString *activeName;
@property (nonatomic, copy) NSString *define;
@property (nonatomic ,strong) UITextView  *descTextView;

-(CGSize)getLabelSize;

- (id)initWithAdvertiseId:(NSString*)advertiseId;


@end
