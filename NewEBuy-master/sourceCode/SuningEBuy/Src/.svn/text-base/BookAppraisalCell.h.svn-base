//
//  BookAppraisalCell.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "productToolClass.h"
#import "BookAppraisalDTO.h"
#import "EvaluationView.h"

@interface BookAppraisalCell : UITableViewCell

/*标题栏*/
@property (nonatomic, strong) UILabel *titleLbl;

/*时间栏*/
@property (nonatomic, strong) UILabel *timeLbl;

/*内容栏*/
@property (nonatomic, strong) UILabel *contentLbl;

/*昵称栏*/
@property (nonatomic, strong) UILabel *nameLbl;

/*评价栏*/
@property (nonatomic, strong) EvaluationView *evaluationView;

/*数据源*/
@property (nonatomic, strong) BookAppraisalDTO *dataSource;



- (void)setItem:(BookAppraisalDTO *)item;

+ (CGFloat)height:(BookAppraisalDTO *)item;

-(NSString *)validateName:(NSString *)name;

@end
