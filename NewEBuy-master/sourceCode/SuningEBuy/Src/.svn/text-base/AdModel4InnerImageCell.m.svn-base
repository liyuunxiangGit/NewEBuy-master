//
//  AdModel4InnerImageCell.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AdModel4InnerImageCell.h"


@implementation AdModel4InnerImageCell

@synthesize innerAdimageView = innerAdImageView_;
@synthesize innerAdImageURL = innerAdImageURL_;

- (void)dealloc {
    TT_RELEASE_SAFELY(innerAdImageView_);
    TT_RELEASE_SAFELY(innerAdImageURL_);
   
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
	self = [super initWithReuseIdentifier:reuseIdentifier];
    
	if (self) {
        
        self.userInteractionEnabled = YES;
        
	}
	
	return self;
}

- (void)setInnerAdImageURL:(NSURL *)innerAdImageURL{


    if (innerAdImageURL != innerAdImageURL_) {
        
        
        innerAdImageURL_ = innerAdImageURL;        
           
        self.innerAdimageView.imageURL = self.innerAdImageURL;
        
        self.innerAdimageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 135);
        
    }else{
    
        return;
    }
}

- (EGOImageViewEx *)innerAdimageView{

    if (!innerAdImageView_) {
        
        
        innerAdImageView_ = [[EGOImageViewEx alloc] init];
        
        innerAdImageView_.backgroundColor = [UIColor whiteColor];
        
        innerAdImageView_.contentMode =  UIViewContentModeScaleToFill;
        
        [self.contentView addSubview:innerAdImageView_];
        
    }
    
    return innerAdImageView_;
}

@end
