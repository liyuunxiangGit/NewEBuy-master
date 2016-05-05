//
//  LotteryTypeCell.h
//  SuningLottery
//
//  Created by lizhen xiao on 12-9-25.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol DoubleColorBallCellDelegate;

@interface LotteryTypeCell : UITableViewCell{
    
    id<DoubleColorBallCellDelegate>__weak delegate;
}

@property(nonatomic,strong) UIButton *doublecolorBotton;
@property(nonatomic,strong) UILabel  *doublecolorlabel;

@property(nonatomic,strong) UIButton *superLottoButton;
@property(nonatomic,strong) UILabel  *superLottoLabel;

@property(nonatomic,strong) UIImageView *shadowImageView;

@property(nonatomic,strong) UIImageView *shadowImageView2;

@property(nonatomic,weak) id <DoubleColorBallCellDelegate>delegate;

- (void)setView:(NSArray*)flag;
-(void)setViewlbl:(NSArray *)lbl;

@end


@protocol DoubleColorBallCellDelegate <NSObject>

@optional
-(void)doubleColorBallCell:(NSString *)buttonName;

-(void)ballfromcell:(UIButton *)sender;

@end
