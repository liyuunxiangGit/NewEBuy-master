//
//  CategorySearchBar.m
//  SuningEBuy
//
//  Created by lanfeng on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CategorySearchBar.h"

@implementation CategorySearchBar

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 50, 320, 75)];
    
    if (self) {
        self.placeholder = @"suning.com";
        //self.showsCancelButton = YES;
        //self.tintColor = RGBCOLOR(101, 141, 179);
        self.tintColor = [UIColor navTintColor];
        self.barStyle = UIBarStyleBlackTranslucent;
        self.prompt = @" ";
        UIView *segment = [self.subviews objectAtIndex:0];
        UIImage *image = [UIImage imageNamed:@"home_search_bg.png"];
        UIImage *streImage = [image stretchableImageWithLeftCapWidth:0 topCapHeight:image.size.height/2];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];
        imageView.image = streImage;
        [segment addSubview:imageView];
                
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.text = L(@"CTClassificationOfGoods");
        label.frame = CGRectMake(0, 0, 320, 31);
        [self addSubview:label];

    }
    return self;
}

@end
