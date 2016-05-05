//
//  SecondCategoryCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-10.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SecondCategoryCell.h"
#import "SecondCategoryMarkView.h"
#import "V2SecCategoryDTO.h"

#define IMGVIEW_TAG_BEGIN 100


@implementation SecondCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.contentView.backgroundColor = [UIColor colorWithRed:238.0/255
//                                                           green:235.0/255
//                                                            blue:215.0/255
//                                                           alpha:1.0];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage streImageNamed:@"category_cell_back.png"]];
        image.backgroundColor = [UIColor clearColor];
        image.frame = CGRectMake(0, 0, 320, 80);
        [self.contentView addSubview:image];

        for (int i=0; i<IMG_NUM; i++) {
            
            SecondCategoryMarkView *imgView = [[SecondCategoryMarkView alloc] initWithFrame:CGRectMake(20+i*(IMG_WIDTH+33), 13, IMG_WIDTH, IMG_HEIGHT)];
            imgView.tag = IMGVIEW_TAG_BEGIN+i;
            [self.contentView addSubview:imgView];
            TT_RELEASE_SAFELY(imgView);
            
        }
    }
    return self;
}

-(void)dealloc{
	
    TT_RELEASE_SAFELY(_dateSource);
	
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setCellItem:(NSArray *)dateSource{
    
    self.dateSource = dateSource;
    
    //画界面
    for (int i=0; i<IMG_NUM; i++) {
        
        SecondCategoryMarkView *view = (SecondCategoryMarkView*)[self.contentView viewWithTag:IMGVIEW_TAG_BEGIN+i];
        if (i<[dateSource count]) {
            
            V2SecCategoryDTO *dto = [dateSource objectAtIndex:i];

            view.myDelegate = _myDelegate;
            
            //view.image = [UIImage imageNamed:[NSString stringWithFormat:@"sales_small_%d.png",i+1]];
            [view setSecDto:dto];
            
            view.hidden = NO;
        }
        else{
            view.myDelegate = nil;
            [view setSecDto:nil];
            view.hidden = YES;
        }
        
    }
}
@end
