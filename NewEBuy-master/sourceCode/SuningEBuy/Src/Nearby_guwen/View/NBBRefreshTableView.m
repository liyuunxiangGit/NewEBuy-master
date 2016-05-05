//
//  NBBRefreshTableView.m
//  suningNearby
//
//  Created by suning on 14-7-29.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBBRefreshTableView.h"
#import "NBNearbyTableCell.h"

#import "NBMoreListViewController.h"        // 地理位置 分组，更多

#import "NBCommentsListViewController.h"    // 评论列表

#import "NBYSHttpService.h"
#import "NBCCSharedData.h"

#import "UIImageView+WebCache.h"

#import "NBYStickItemDTO.h"

#import "NBStickGroupView.h" // tableView section

#import "NBYDaShangViewController.h"
#import "NBYStickDetailViewController.h"

#import "BMKGeometry.h"

#import "NBYJuBaoView.h"

#import "NBYUtils.h"


@interface NBBRefreshTableView () <NBNearbyTableCellDelegate,NBYSHttpServiceDelegate>

@property (nonatomic,strong) UIImageView *tbHeaderView;

@property (nonatomic,strong) NBYSHttpService    *httpService;
@property (nonatomic,strong) NSMutableArray     *sourceArray;

@property (nonatomic,assign) NSUInteger         xPageIndex;  // default 0
@property (nonatomic,strong) NSString           *xRefreshTime;

@end

@implementation NBBRefreshTableView

- (void)intializeUI {
    CGSize sz             = self.frame.size;
    self.tbHeaderView     = [[UIImageView alloc] initWithFrame:CGRectMake(1.0f,.0f,sz.width-2.0f,100.0f)];
    
    self.tableHeaderView  = _tbHeaderView;
    
    self.sourceArray = [NSMutableArray array];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self intializeUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self intializeUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self intializeUI];
    }
    return self;
}

#pragma mark - 

// 分页 请求 数据
// direction = 0 上刷新 ; direction = 1 下刷新
- (void)requestGetItemsListWithPage:(NSUInteger)pageIdx direction:(int)direction {
    
    if (pageIdx == 0) {
        self.xRefreshTime = nil;
    }
    // todo
    NSNumber *pageIndex = [NSNumber numberWithUnsignedInteger:pageIdx];
    NSDictionary *unit = @{@"channelId":EncodeStringFromDic(_channel,@"id"),
                           @"u":[NBCCSharedData userInfo],
                           @"pos":[NBCCSharedData postion],
                           @"pageNo":pageIndex,
                           @"pageCnt":@"20",
                           @"distance":@"1000", // 1000m
                           @"deviceId":@"xxxxx",
                           @"posLimitContCnt":@"2"};
    NSMutableDictionary *paras = [NSMutableDictionary dictionaryWithDictionary:unit];
    if (nil != _xRefreshTime) {
        [paras setObject:_xRefreshTime forKey:@"refreshTime"];
    }
    NSDictionary *userInfo = @{@"pageIndex":pageIndex,
                               @"direction":@(direction)};
    [self.httpService requestHomeNormalModeChannelListWithParas:paras
                                                        usrInfo:userInfo];
}

// 刷新，重新请求 当前数据列表
- (void)refreshChannelDataList {
    if (0 == _sourceArray.count) {
        
        [self.parentCtrler displayOverFlowActivityView];
        
        [self uicc_actionHeaderRefreshTableViewDidTrigger];
        
        [_tbHeaderView sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(_channel,@"imageUrl")]
                         placeholderImage:[UIImage imageNamed:@"nby_imgPlaceholder_6"]];
    }
}

#pragma mark - tableView delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NBYStickGrpItemDTO *grpItem = _sourceArray[section];
    
    NBStickGroupView *secView = [NBStickGroupView stickGroupView];
    secView.section = section;
    secView.title   = grpItem.pointName;
    secView.clickedSection = ^ (NSNumber *nSection) {
        NBMoreListViewController *ctrler = [[NBMoreListViewController alloc] init];
        ctrler.channel      = _channel;
        ctrler.postionItem  = [grpItem postion];
        [_parentCtrler.navigationController pushViewController:ctrler animated:YES];

    };
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NBYStickGrpItemDTO *grpItem = _sourceArray[indexPath.section];
    NBYStickItemDTO    *dto     = grpItem.stickItems[indexPath.row];
    NSArray *rewards  = EncodeArrayFromDic(dto.item, @"rewardList");
    if (nil == rewards
        || rewards.count == 0) {
        return 486.0f;
    }else {
        return 530.0f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NBYStickGrpItemDTO *grpItem = _sourceArray[section];
    return (grpItem.stickItems.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"NBNearbyTableCell_A_identify";
    NBNearbyTableCell *cell = (NBNearbyTableCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [NBNearbyTableCell cellWithTemplate:0];
        cell.delegate = self;
    }
    NBYStickGrpItemDTO *grpItem = _sourceArray[indexPath.section];
    cell.dto = grpItem.stickItems[indexPath.row];
    cell.dto.idxPath = indexPath;
    
    if (indexPath.section == 0
        && indexPath.row == 0
        && nil != _distanceBlock) {
        NSString *distance = EncodeStringFromDic(cell.dto.item, @"distance");
        _distanceBlock([NBYUtils convertDistance:distance.floatValue]);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NBYStickDetailViewController *ctrler = [[NBYStickDetailViewController alloc] init];
    NBYStickGrpItemDTO *grpItem = _sourceArray[indexPath.section];
    NBYStickItemDTO *bean = grpItem.stickItems[indexPath.row];
    // 内容id
    ctrler.contId = EncodeStringFromDic(bean.item,@"id");
    [self.parentCtrler.navigationController pushViewController:ctrler animated:YES];
}


#pragma mark - header and footer refresh

- (void)uicc_actionHeaderRefreshTableViewDidTrigger {
    [super uicc_actionHeaderRefreshTableViewDidTrigger];
    _xPageIndex = 0;
    [self requestGetItemsListWithPage:0 direction:0];
}

- (void)uicc_actionFooterRefreshTableViewDidTrigger {
    [super uicc_actionFooterRefreshTableViewDidTrigger];
    
    if (!self.isCloseLoadMore) {
        [self requestGetItemsListWithPage:_xPageIndex direction:1];
    }else {
        [self uicc_setLoadFinishedWithFlag:1];
    }
}

#pragma mark -

- (void)onPerformJuBao:(NBYStickItemDTO *)itemDto {
    
    [self.parentCtrler displayOverFlowActivityView];
    NSDictionary *paras = @{@"contId":EncodeStringFromDic(itemDto.item,@"id"),
                            @"u":[NBCCSharedData userInfo],
                            @"pos":[NBCCSharedData postion]};
    [self.httpService requestReportPublishStick:paras];
}

// 1评论，2打赏，3举报
- (void)delegate_NBNearbyTableCell_operetion:(int)operation
                                        item:(NBYStickItemDTO *)itemDto {
    if (1 == operation) {
        NBBRefreshTableView *__weak weakSelf = self;
        NBCommentsListViewController *ctrler = [[NBCommentsListViewController alloc] init];
        ctrler.stickItem    = itemDto.item;
        ctrler.updateCommentNumBlock = ^ (NSNumber *commentNum) {
            itemDto.commentNum += (commentNum.integerValue);
            [weakSelf reloadRowsAtIndexPaths:@[itemDto.idxPath]
                            withRowAnimation:UITableViewRowAnimationNone];
            
        };
        [_parentCtrler.navigationController pushViewController:ctrler animated:YES];
    }else if (2 == operation) {
        NBBRefreshTableView *__weak weakSelf = self;
        
        NBYDaShangViewController *ctrler = [[NBYDaShangViewController alloc] init];
        ctrler.stickItem    = itemDto.item;
        ctrler.updateCommentNumBlock = ^ (NSNumber *dashangNum) {
            itemDto.dashangNum += (dashangNum.integerValue);
            [weakSelf reloadRowsAtIndexPaths:@[itemDto.idxPath]
                            withRowAnimation:UITableViewRowAnimationNone];
            
        };
        [_parentCtrler.navigationController pushViewController:ctrler animated:YES];
    }else if (3 == operation) {
        
        // {{{
        CGSize sz = self.parentView.frame.size;
        
        NBYJuBaoView *jubaoAlertView = [NBYJuBaoView view];
        jubaoAlertView.frame = CGRectMake(.0f,.0f,sz.width,sz.height);
        NBBRefreshTableView *__weak weakSelf = self;
        jubaoAlertView.jubaoBlock = ^ () {
            [weakSelf onPerformJuBao:itemDto];
        };
        [self.parentView addSubview:jubaoAlertView];
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
    
    if (CC_NBYHomeNormalModeChannelList == cmd) {
        
        NSNumber *direction = userInfo[@"direction"];
        NSNumber *pageIndex = userInfo[@"pageIndex"];
        if (nil == error) {            
            NSDictionary *data      = result[@"data"];
            NSArray      *list      = data[@"list"];
            
            self.xRefreshTime       = EncodeStringFromDic(data,@"refreshTime");
            
            if (list.count > 0) { // {{{ // 分组（地理位置分组）
            
                if (direction.integerValue == 0
                    || pageIndex.integerValue == 0) { // Refresh
                    if (_sourceArray.count > 0) {
                        [_sourceArray removeAllObjects];
                    }
                }
                
                // load more
                for (NSDictionary *one in list) { // 分组（地理位置分组）
                    
                    NBYStickGrpItemDTO *dto = [[NBYStickGrpItemDTO alloc] init];
                    dto.point           = EncodeArrayFromDic(one,@"point");
                    dto.userLocation    = EncodeArrayFromDic(one,@"userLocation");
                    dto.pointName       = EncodeStringFromDic(one,@"pointName");
                    dto.distance        = EncodeStringFromDic(one,@"distance");
                    dto.prov            = EncodeStringFromDic(one,@"prov");
                    dto.city            = EncodeStringFromDic(one,@"city");
                    dto.area            = EncodeStringFromDic(one,@"area");
                    
                    NSArray *list2      = EncodeArrayFromDic(one,@"list");
                    for (NSDictionary *two in list2) { // 成员 (分许下成员列表)
                        
                        NBYStickItemDTO *bean = [[NBYStickItemDTO alloc] init];
                        bean.item             = two;
                        [dto.stickItems addObject:bean];
                    }
                    
                    [_sourceArray addObject:dto];
                }
                [self reloadData];
                
                if (list.count >= kNBYPageLimtCount) {
                    _xPageIndex++;
                    self.isCloseLoadMore = NO;
                }else {
                    self.isCloseLoadMore = YES;
                }
            } // }}}
        }else {
            [self.parentCtrler presentSheet:error.localizedDescription];
        }
        
        [self.parentCtrler removeOverFlowActivityView];
        [self uicc_setLoadFinishedWithFlag:direction.integerValue];
        
    }else if (CC_NBYReportPublish == cmd) {
        if (nil == error) {
            [self.parentCtrler presentSheet:L(@"PVReportSuceess")];
        }else {
            [self.parentCtrler presentSheet:error.localizedDescription];
        }
        [self.parentCtrler removeOverFlowActivityView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    
    if (nil != _distanceBlock) {
        CGSize sz = self.frame.size;
        NSIndexPath *idxPath = [self indexPathForRowAtPoint:CGPointMake(.0f,sz.height/2.0f+scrollView.contentOffset.y)];
        if (nil != idxPath
            && nil != _distanceBlock) {
            
            NBYStickGrpItemDTO *grpItem = _sourceArray[idxPath.section];
            NBYStickItemDTO    *bean    = grpItem.stickItems[idxPath.row];
        
            NSString *distance = EncodeStringFromDic(bean.item, @"distance");
           _distanceBlock([NBYUtils convertDistance:distance.floatValue]);
        }
    }
}

@end
