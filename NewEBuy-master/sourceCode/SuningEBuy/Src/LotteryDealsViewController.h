//
//  LotteryDealsViewController.h
//  SuningLottery
//
//  Created by lyywhg on 13-4-12.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderService.h"
#import "ChooseDate.h"
#import "LotteryOrderDto.h"
#import "LotteryDealsCell.h"
#import "LotteryDealsDto.h"
#import "UITableViewMoreCell.h"
#import "LotteryDealsSerialNumberDto.h"
#import "PageRefreshTableViewController.h"

#define kShowAll           0
#define kShowBingo         1

typedef NS_ENUM(NSInteger, RequestDifference)
{
    TypeDifferent = 0,
    BingoDiferent = 1,
    PageDifferent = 2,
    NoneDifferent = 3
};


@interface LotteryDealsViewController : PageRefreshTableViewController<UITableViewDataSource,OrderServiceDelegate,UITableViewDelegate>
{
    NSInteger                       dealsType_;        //订单类型0 代购 1追号
    NSInteger                       showBingoOrNot_;   //展示中奖或未中奖 0 展示中奖 1展示全部
    NSInteger                       currentPage_;      //当前页  起始值为1
    NSInteger                       totalPage_;        //总页数
    
    NSInteger                       last_dealsType_;       //上次显示的订单类型
    NSInteger                       last_showBingoOrNot_;  //上次显示的是否是全部的
    NSInteger                       last_currentPage_;      //上次请求的页数
    BOOL                            isFirstLoad_;          //是否是第一次加载
}


@property (nonatomic, strong)       UIButton     *showBingoBtn;
@property (nonatomic, strong)       UIButton     *showAllBtn;

@property (nonatomic, strong)       UIButton     *dealTypeChooseBtn;
@property (nonatomic, strong)       UIImageView  *dealTypeTriangle;    //类别选择旁边的三角

@property (nonatomic, strong)       UIView       *popUpChooseView;
@property (nonatomic, strong)       UIImageView  *popActionSheet;   //弹出的白框
@property (nonatomic, strong)       UITableView  *dealTypeChooseView; //顶部类型选择框

@property (nonatomic, strong)       UIView       *centerNoneDataView;  //无数据时的显示视图

@property (nonatomic, strong)       UILabel      *tip;   //无数据提示语

@property (nonatomic, strong)       UIButton     *goToLotteryHallBtn;  //无数据按钮

@property (nonatomic, strong)       OrderService *dealsListService;  //数据请求服务类

@property (nonatomic, assign)       BOOL         isFormLotteryHall;

@property (nonatomic,strong) UIImageView                 *alertImageV;
-(id)initDataCaiPiao;


@end
