//
//  AdModel5ViewController.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AdModel5ViewController.h"
//#import "SuningMainClick.h"
#import "AppDelegate.h"

@implementation AdModel5ViewController

@synthesize activeName = activeName_;
@synthesize define = define_;
@synthesize descTextView = descTextView_;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(activeName_);
    TT_RELEASE_SAFELY(define_);
    TT_RELEASE_SAFELY(descTextView_);
    
}

- (id)init{
	
    self = [super init];
	
    if (self) {
        
       	self.title = self.activeName;//@"";
		
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    if (self.activeName != nil ) {
        
        self.title = self.activeName;
    }
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title];
    
    CGFloat y = self.view.frame.size.height - 92 - 20;
        
    CGSize descLabelSize =  [self getLabelSize];
    
    if (descLabelSize.height!=0 ) {
        
        self.descTextView.contentOffset = CGPointMake(10, 10);
        self.descTextView.contentSize = CGSizeMake(300, descLabelSize.height);
        self.descTextView.frame = CGRectMake(10, 10, 300, y);
        self.descTextView.text = self.define;
        
    }else{
    
        return;
    }
        
}

- (id)initWithAdvertiseId:(NSString*)advertiseId{
    
    self = [super init];
    
    if (self) {
        
       	self.title = self.activeName;//@"";
    
    }
    
    return self;
}


-(UITextView *)descLabel{

    if (!descTextView_) {
        
        descTextView_ = [[UITextView alloc] init];
        
        descTextView_.textColor = [UIColor blackColor];
        
        descTextView_.backgroundColor = RGBCOLOR(239, 239, 239);
        
        descTextView_.editable = NO;
                
        descTextView_.font = [UIFont systemFontOfSize:16];
        
        descTextView_.frame = CGRectZero;
            
        [self.view addSubview:descTextView_];
        
    }
    return descTextView_;
}


-(CGSize)getLabelSize{

    if (self.define == nil || [self.define isEqualToString:@""]) {
        
        return CGSizeZero;
        
    }else{
    
        CGSize size = CGSizeMake(self.descLabel.frame.size.width, 3000);
        
       CGSize labelSize  =  [self.define sizeWithFont:self.descLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap] ;
        
        return labelSize;
    }
}

@end
