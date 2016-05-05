//
//  NJPageScrollViewCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJPageScrollViewCell : UIView
{
    @private
    NSString    *_reuseIdentifier;
}


@property (nonatomic, readwrite, copy) NSString *reuseIdentifier;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)prepareForReuse;

@end
