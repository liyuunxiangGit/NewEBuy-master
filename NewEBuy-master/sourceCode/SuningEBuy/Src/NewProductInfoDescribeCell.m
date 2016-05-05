//
//  NewProductInfoDescribeCell.m
//  SuningEBuy
//
//  Created by xmy on 18/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewProductInfoDescribeCell.h"


#define kDefualCellHight      10

@implementation NewProductInfoDescribeCell

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
        
		self.contentView.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (UILabel*)nameLbl
{
    if(!_nameLbl)
    {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, 280, 30)];
        
        _nameLbl.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
        
        _nameLbl.textAlignment = UITextAlignmentLeft;
        
        _nameLbl.font = [UIFont boldSystemFontOfSize:12];
        
        _nameLbl.backgroundColor = [UIColor clearColor];
        
    }
    
    return _nameLbl;
}

-(UILabel *)infoLbl{
    
    if (!_infoLbl) {
        
        _infoLbl = [[UILabel alloc] init];
        
        _infoLbl.frame = CGRectMake(20, 5, kDefaulContendWidth, 5);
        
        _infoLbl.backgroundColor = [UIColor clearColor];
        
        _infoLbl.textAlignment = UITextAlignmentLeft;
        
        _infoLbl.textColor = [UIColor colorWithRed:112.0/255 green:112.0/255 blue:112.0/255 alpha:1];
        
        _infoLbl.font = [UIFont systemFontOfSize:kDefaulContendFont];
        
        _infoLbl.lineBreakMode = UILineBreakModeWordWrap;
        
        _infoLbl.numberOfLines = 0;
        
        [self addSubview:_infoLbl];
        
    }
    
    return _infoLbl;
    
}

- (UIImageView*)backView
{
    if(!_backView)
    {
        _backView = [[UIImageView alloc] init];
        
        [_backView setImage:[UIImage imageNamed:@"yellowbackground.png"]];
        
        _backView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _backView;
}

-(UIImageView *)topLine{
    
    if (!_topLine) {
        
        _topLine = [[UIImageView alloc]init];
        
        _topLine.backgroundColor = [UIColor clearColor];
        
        _topLine.image = [UIImage streImageNamed:@"new_order_line.png"];
    }
    return _topLine;
}

-(void) setInfoString:(NSString *)aItem WithBool:(BOOL)isLoad{
    
//    if(isLoad == YES)
//    {
//        self.backView.image = [UIImage streImageNamed:@"yellow_mid.png"];
//        
//    }
//    else
//    {
//        self.backView.image = [UIImage streImageNamed:@"yellow_buttom.png"];
//    }
//    
//    self.backgroundView = self.backView;
    
    _infoString = aItem;
        
    CGSize labelsize = [_infoString sizeWithFont:self.infoLbl.font constrainedToSize:CGSizeMake(self.infoLbl.frame.size.width, 300) lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect frame = self.infoLbl.frame;
    
    frame.size.height = labelsize.height;
    
    self.infoLbl.frame = frame;
    
    self.infoLbl.text = _infoString;
   
/*
//    //xmy
//    if(isLoad == YES)
//    {
//        self.nameLbl.text = @"装箱清单";
//        
//        self.nameLbl.frame = CGRectMake(20, 6, 280, 30);
//        
//        [self addSubview:self.nameLbl];
//        
//        frame.origin.y = self.nameLbl.origin.y+self.nameLbl.frame.size.height;
//        
//        self.infoLbl.frame = frame;
//        
//        if (!_sepLine)
//        {
//            _sepLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_cellSeparatorLine.png"]];
//        }
//        
//        if(IsStrEmpty(_infoString))
//        {
//            _sepLine.frame = CGRectMake(10, self.nameLbl.bottom+2, 300, 1);
//
//        }
//        else
//        {
//            _sepLine.frame = CGRectMake(10, self.infoLbl.bottom+2, 300, 1);
//
//        }
//
//        [self addSubview:_sepLine];
//
//    }
//    else
//    {
//        _sepLine.image = nil;
//
////        for(UIImageView *lineV in self.contentView.subviews)
////        {
////            if(lineV.image == [UIImage imageNamed:@"category_cellSeparatorLine.png"])
////            {
////                [lineV removeFromSuperview];
////            }
////        }
//        
//        frame.origin.y = 0;
//        
//        self.infoLbl.frame = frame;
//    }
 */
   

}

- (void) dealloc {
    
    TT_RELEASE_SAFELY(_infoLbl);
    
    TT_RELEASE_SAFELY(_infoString);
    
}

+ (CGFloat) height:(NSString *)astring{
    
    CGFloat cellHight = kDefualCellHight;
    
    if (astring == nil) {
        return cellHight;
    }
    UIFont *couendFont = [UIFont systemFontOfSize:kDefaulContendFont];
    
    DLog(@"height couend =%@", astring);
    
    CGSize labelsize = [astring sizeWithFont:couendFont constrainedToSize:CGSizeMake(kDefaulContendWidth, 300) lineBreakMode:UILineBreakModeWordWrap];
    
    cellHight += labelsize.height;
    
    return cellHight;
    
}  

@end
