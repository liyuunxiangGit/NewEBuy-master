//
//  ;
//  suningNearby
//
//  Created by suning on 14-8-8.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBMagicImgButton.h"

@interface NBMagicImgButton ()
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel     *titleLbl;
@end

@implementation NBMagicImgButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGSize sz = frame.size;
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(.0f,.0f,sz.width,sz.height-26.0f)];
        _iconView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:.1f];
        [self addSubview:_iconView];
        
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(.0f,
                                                                    _iconView.frame.origin.y+_iconView.frame.size.height+5.0f,
                                                                    sz.width,
                                                                    21.0f)];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont boldSystemFontOfSize:14.0f];
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLbl];
        
        [self addTarget:self action:@selector(on_clicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    if (nil != image) {
        self.iconView.image = image;
    }
}

- (void)setTitle:(NSString *)title {
    if (nil != title) {
        self.titleLbl.text = title;
    }
}

- (void)on_clicked {
    if (nil != _selectedComplete) {
        _selectedComplete(_iconView.image,@(self.tag));
    }
}

@end
