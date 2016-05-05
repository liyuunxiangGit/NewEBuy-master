//
//  QueryPlaneCell.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryPlaneCell : UITableViewCell{

    UILabel             *_leftLabel;
    
    UILabel             *_rightLabel;
    
}

@property (nonatomic,strong) UIView         *whiteBackView;
@property (nonatomic,strong) UILabel        *leftLabel;
@property (nonatomic,strong) UILabel        *rightLabel;
@property (nonatomic,strong) UIImageView    *lineView;
@property (nonatomic,strong) UIImageView    *arrowView;

-(void)setItem:(NSInteger)index
      leftItem:(NSString *)leftItem
     rightItem:(NSString *)rightItem;

+(CGFloat)height:(NSInteger)index;


@end
