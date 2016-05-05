//
//  SNCommentShareImagesView.h
//  SuningEBuy
//
//  Created by Joe on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNSInputImagesView.h"
@interface SNCommentShareImagesView : UIView
@property(nonatomic,strong)SNSInputImagesView *imageView;
@property(nonatomic,assign)int height;
-(void)reSize;
@end

#import "DLStarRatingControl.h"
@interface SNCommentShareStar : UIView
@property(nonatomic,strong)DLStarRatingControl *star;
@property(nonatomic,strong)UILabel     *hintLabel;
@end


@protocol SNCommentShareDelegate <NSObject>
-(void)tap:(id)sender;

@end
@interface SNCommentShareSelecter : UIView
@property(nonatomic,assign)id<SNCommentShareDelegate> delegate;
@property(nonatomic,retain)UILabel  *hintLable;
@property(nonatomic,assign)BOOL selected;
@end