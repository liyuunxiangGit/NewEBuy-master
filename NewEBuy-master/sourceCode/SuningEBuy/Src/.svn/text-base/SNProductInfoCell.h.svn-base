//
//  SNProductInfoCell.h
//  SuningEBuy
//
//  Created by Joe on 14-11-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNProductInfoCell : UITableViewCell

@property(nonatomic,retain)NSString *userName;
@property(nonatomic,assign)int star;
@property(nonatomic,assign)int likeCount;
@property(nonatomic,retain)NSString *detailText;
@property(nonatomic,retain)NSString *timeText;//包含评论日期、卖家、商品颜色、样式规格等
@property(nonatomic,retain)NSString *followCommentText;
@property(nonatomic,retain)NSString *followCommentTime;
@property(nonatomic,retain)NSString *officeCommentHead;
@property(nonatomic,retain)NSString *officeCommentText;
@property(nonatomic,retain)NSMutableArray *images;

-(void)clean;
-(void)refresh;

+(float)heightWithDeailText:(NSString*)text hasImages:(BOOL)hasImage hasFollowComment:(NSString*)followComment andTime:(NSString*)time hasOfficeComment:(NSString*)officeComment andHead:(NSString*)head;


@end
