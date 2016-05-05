//
//  NewProductInfoDescribeCell.h
//  SuningEBuy
//
//  Created by xmy on 18/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaulContendWidth  280

#define kContendWidthWitnMark 280 //270

#define kDefaulContendFont    12

@interface NewProductInfoDescribeCell : UITableViewCell
{
    @public
    UIImageView *_sepLine;
}

@property (nonatomic, strong) UILabel *infoLbl;

@property (nonatomic, copy) NSString *infoString;

//xmy

@property (nonatomic, retain)UILabel *nameLbl;

@property (nonatomic, retain)UIImageView *backView;

@property (nonatomic,retain)UIImageView *topLine;

-(void) setInfoString:(NSString *)aItem WithBool:(BOOL)isLoad;


- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat) height:(NSString *)astring;

@end
