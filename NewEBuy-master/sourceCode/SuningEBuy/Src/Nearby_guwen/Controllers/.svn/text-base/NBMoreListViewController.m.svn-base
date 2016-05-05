//
//  NBMoreListViewController.m
//  suningNearby
//
//  Created by suning on 14-8-1.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBMoreListViewController.h"
#import "NBNearbyTableCell.h"
#import "NBCommentsListViewController.h" // 评论列表
#import "NBDaShangView.h"                // 打赏页面

#import "NBYSHttpService.h"
#import "NBCCSharedData.h"

#import "NBYStickItemDTO.h"
#import "NBYDaShangViewController.h"
#import "NBYStickDetailViewController.h"

#import "NBYJuBaoView.h"

#import "NBYUtils.h"


@interface NBMoreListViewController () <NBNearbyTableCellDelegate,NBYSHttpServiceDelegate>

@property (nonatomic,strong) NBYSHttpService    *httpService;
@property (nonatomic,strong) NSMutableArray     *sourceArray;

@property (nonatomic,assign) NSUInteger         xPageIndex;  // default 0
@property (nonatomic,strong) NSString           *xRefreshTime;

@property (nonatomic,strong) IBOutlet           UIView *rightBarItemView;
@property (nonatomic,strong) IBOutlet           UIView *rightBarButtonView;
@property (nonatomic,strong) IBOutlet           UIButton *tabButton0,*tabButton1;
@property (nonatomic,assign) NSInteger          sortValue; // default 2 最新

@property (nonatomic,strong) IBOutlet UIView              *titleTextView;
@property (nonatomic,strong) IBOutlet UIButton            *titleButton;

@end

@implementation NBMoreListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.isNeedBackItem = NO;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIColor *color = self.refreshTableView.backgroundColor;
    self.refreshTableView.refreshHeaderColor = color;
    self.refreshTableView.refreshFooterColor = color;
    
    UIBarButtonItem *leftbarItem;
    leftbarItem = [[UIBarButtonItem alloc] initWithCustomView:self.titleTextView];
    self.navigationItem.leftBarButtonItem = leftbarItem;
    
    _rightBarButtonView.layer.borderWidth = 2.0f;
    _rightBarButtonView.layer.borderColor = [UIColor colorWithRed:58.0f/255.0f
                                                          green:204.0f/255.0f
                                                           blue:196.0f/255.0f
                                                          alpha:1.0f].CGColor;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarItemView];
    self.navigationItem.rightBarButtonItem = barItem;
    
    //[self setTitle:EncodeStringFromDic(_postionItem, @"pointName")];
    [_titleButton setTitle:EncodeStringFromDic(_postionItem,@"pointName")
                  forState:UIControlStateNormal];
    
    self.sortValue = 2;
    
    self.sourceArray = [NSMutableArray array];
    
    [self displayOverFlowActivityView];
    [self delegate_uiccHeaderRefreshTableViewDidTrigger];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

// 分页 请求 数据
// direction = 0 上刷新 ; direction = 1 下刷新
- (void)requestGetItemsListWithPage:(NSUInteger)pageIdx direction:(int)direction {
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // todo
    NSNumber *pageIndex = [NSNumber numberWithUnsignedInteger:pageIdx];
    NSDictionary *unit = @{@"channelId":EncodeStringFromDic(_channel,@"id"),
                           @"u":[NBCCSharedData userInfo],
                           @"pos":((nil==_postionItem)?@{}:_postionItem),// ?
                           @"pageNo":pageIndex,
                           @"pageCnt":@"20",
                           @"sort":@(_sortValue)};
    NSMutableDictionary *paras = [NSMutableDictionary dictionaryWithDictionary:unit];
    if (nil != _xRefreshTime) {
        [paras setObject:_xRefreshTime forKey:@"refreshTime"];
    }
    
    NSDictionary *userInfo = @{@"pageIndex":pageIndex,@"direction":@(direction)};
    [self.httpService requestHomeMoreModeChannelListWithParas:paras usrInfo:userInfo];
}

- (IBAction)on_barItemTabButton_clicked:(UIButton *)sender {
    if (!sender.selected) {
        self.sortValue = sender.tag;
        
        _tabButton0.selected = NO;
        _tabButton1.selected = NO;
        
        sender.selected = YES;
        
//        [_sourceArray removeAllObjects];
//        [self.refreshTableView reloadData];
        
        self.xRefreshTime = nil;
        
        self.rightBarItemView.userInteractionEnabled = NO;
        
        [self displayOverFlowActivityView];
        [self delegate_uiccHeaderRefreshTableViewDidTrigger];
    }
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NBYStickItemDTO *dto = _sourceArray[indexPath.row];
    NSArray *rewards  = EncodeArrayFromDic(dto.item, @"rewardList");
    if (nil == rewards
        || rewards.count == 0) {
        return 486.0f;
    }else {
        return 530.0f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"NBNearbyTableCell_A_identify";
    NBNearbyTableCell *cell = (NBNearbyTableCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [NBNearbyTableCell cellWithTemplate:0];
        cell.delegate = self;
    }
    
    cell.dto = _sourceArray[indexPath.row];
    cell.dto.idxPath = indexPath;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NBYStickDetailViewController *ctrler = [[NBYStickDetailViewController alloc] init];
    NBYStickItemDTO *bean = _sourceArray[indexPath.row];
    bean.idxPath = indexPath;
    // 内容id
    ctrler.contId = EncodeStringFromDic(bean.item,@"id");
    [self.navigationController pushViewController:ctrler animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.refreshTableView uicc_actionScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.refreshTableView uicc_actionScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

#pragma mark - UICCRefreshCommonTableViewDelegate

- (void)delegate_uiccHeaderRefreshTableViewDidTrigger {
    _xPageIndex = 0;
    [self requestGetItemsListWithPage:0 direction:0];
}

- (void)delegate_uiccFooterRefreshTableViewDidTrigger {
    
    if (!self.refreshTableView.isCloseLoadMore) {
        [self requestGetItemsListWithPage:_xPageIndex direction:1];
    }
}

#pragma mark -

- (void)onPerformJuBao:(NBYStickItemDTO *)itemDto {
    
    [self displayOverFlowActivityView];
    NSDictionary *paras = @{@"contId":EncodeStringFromDic(itemDto.item,@"id"),
                            @"u":[NBCCSharedData userInfo],
                            @"pos":[NBCCSharedData postion]};
    [self.httpService requestReportPublishStick:paras];
}

// 1评论，2打赏，3举报
- (void)delegate_NBNearbyTableCell_operetion:(int)operation
                                        item:(NBYStickItemDTO *)itemDto {
    
    NBMoreListViewController *__weak weakSelf = self;
    
    if (1 == operation) {
        NBCommentsListViewController *ctrler = [[NBCommentsListViewController alloc] init];
        ctrler.stickItem    = itemDto.item;
        ctrler.updateCommentNumBlock = ^ (NSNumber *commentNum) {
            itemDto.commentNum += (commentNum.integerValue);
            [weakSelf.refreshTableView reloadRowsAtIndexPaths:@[itemDto.idxPath]
                            withRowAnimation:UITableViewRowAnimationNone];
            
        };
        [self.navigationController pushViewController:ctrler animated:YES];
    }else if (2 == operation) {
        
        NBYDaShangViewController *ctrler = [[NBYDaShangViewController alloc] init];
        ctrler.stickItem    = itemDto.item;
        ctrler.updateCommentNumBlock = ^ (NSNumber *dashangNum) {
            itemDto.dashangNum += (dashangNum.integerValue);
            [weakSelf.refreshTableView reloadRowsAtIndexPaths:@[itemDto.idxPath]
                            withRowAnimation:UITableViewRowAnimationNone];
            
        };
        [self.navigationController pushViewController:ctrler animated:YES];
    }else if (3 == operation) {
        // {{{
        CGSize sz = self.commonView.frame.size;
        
        NBYJuBaoView *jubaoAlertView = [NBYJuBaoView view];
        jubaoAlertView.frame = CGRectMake(.0f,.0f,sz.width,sz.height);
        
        jubaoAlertView.jubaoBlock = ^{
            [weakSelf onPerformJuBao:itemDto];
        };
        [self.commonView addSubview:jubaoAlertView];
        // }}}
    }
}

#pragma mark - http service

- (NBYSHttpService *)httpService {
    
    if (nil == _httpService) {
        _httpService = [[NBYSHttpService alloc] init];
        _httpService.delegate = self;
    }
    return _httpService;
}

- (void)delegate_nbys_httpService_result:(NSDictionary *)result
                                 usrInfo:(NSDictionary *)userInfo
                                   error:(NSError *)error
                                     cmd:(E_CMDCODE)cmd {
    
    if (CC_NBYNormalMoreModeChannelList == cmd) {
        NSNumber *direction = userInfo[@"direction"];
        NSNumber *pageIndex = userInfo[@"pageIndex"];
        if (nil == error) {
            NSDictionary *data      = result[@"data"];
            NSArray      *list      = data[@"list"];
            
            self.xRefreshTime       = EncodeStringFromDic(data,@"refreshTime");
            
            if (list.count > 0) { // {{{
                
                if (direction.integerValue == 0
                    || pageIndex.integerValue == 0) { // Refresh
                    if (_sourceArray.count > 0) {
                        [_sourceArray removeAllObjects];
                    }
                }
                
                // load more
                for (NSDictionary *one in list) {
                    
                    NBYStickItemDTO *dto = [[NBYStickItemDTO alloc] init];
                    dto.item             = one;
                    
                    [_sourceArray addObject:dto];
                }
                [self.refreshTableView reloadData];
                
            } // }}}
            
            if (list.count >= kNBYPageLimtCount) {
                _xPageIndex++;
                self.refreshTableView.isCloseLoadMore = NO;
            }else {
                self.refreshTableView.isCloseLoadMore = YES;
            }
            
        }else {
            [self presentSheet:error.localizedDescription];
        }
        
        [self removeOverFlowActivityView];
        [self.refreshTableView uicc_setLoadFinishedWithFlag:direction.integerValue];
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.rightBarItemView.userInteractionEnabled   = YES;
        
    }else if (CC_NBYReportPublish == cmd) {
        
        if (nil == error) {
            [self presentSheet:L(@"PVReportSuceess")];
        }else {
            [self presentSheet:error.localizedDescription];
        }
        [self removeOverFlowActivityView];
    }
}

@end
