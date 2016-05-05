//
//  ProductDisImgeCell.m
//  SuningEBuy
//
//  Created by xy ma on 12-2-27.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ProductDisImgeCell.h"

@implementation ProductDisImgeCell

@synthesize productDisImageURL = productDisImageURL_;
@synthesize productDisImageView = productDisImageView_;
@synthesize dataSource = dataSource_;

- (void)dealloc{
    TT_RELEASE_SAFELY(productDisImageURL_);
    TT_RELEASE_SAFELY(productDisImageView_);
    TT_RELEASE_SAFELY(dataSource_);
}


- (void)setItem:(ProductDisImgeDTO *)item{
    if (item == nil)
    {
        return;
    }
    self.dataSource = item;
      
    if (item.productDisImageClickURL == nil || [item.productDisImageClickURL  isEqualToString:@""]) 
    {
         DLog(@"item.productDisImageClickURL is null");
    }else
        
    {

    self.productDisImageView.imageURL = self.dataSource.productDisImageURL;
    
    self.productDisImageURL = self.dataSource.productDisImageClickURL;
    
        }

    [super setNeedsLayout];
}

- (void)setItemByImage:(UIImage *)image{
    if (image == nil)
    {
        return;
    }else
        
    {
        
        self.productDisImageView.image = image;
        
    }
    
    [super setNeedsLayout];
}


#pragma mark -
#pragma mark view setters

- (EGOImageView *)productDisImageView
{
    if (!productDisImageView_) {
		
		productDisImageView_ = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
		
		productDisImageView_.backgroundColor =[UIColor whiteColor];
        
        productDisImageView_.contentMode = UIViewContentModeScaleAspectFill;
        
        productDisImageView_.delegate = self;
        
        productDisImageView_.layer.borderWidth = 0.5;
        
        productDisImageView_.layer.cornerRadius = 5;
        
        productDisImageView_.layer.masksToBounds = YES;
        
        productDisImageView_.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
       // productDisImageView_.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        [self.contentView addSubview:productDisImageView_];
	}
	
	return productDisImageView_;
}
@end
