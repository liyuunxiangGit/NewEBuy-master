//
//  NBARefreshTableView.m
//  suningNearby
//
//  Created by suning on 14-7-29.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBARefreshTableView.h"
#import "UICCRefreshCommonHeader.h"
#import "NBNearbyTableCell.h"
#import "NBCommentsListViewController.h"    // 评论列表

#import "NBYSHttpService.h"
#import "NBCCSharedData.h"

#import "UIImageView+WebCache.h"

#import "NBYStickItemDTO.h"
#import "NBYDaShangViewController.h"

#import "NBYStickDetailViewController.h"

#import "BMKGeometry.h"

#import "NBYJuBaoView.h"

#import "NBYUtils.h"


@interface NBARefreshTableView () <NBNearbyTableCellDelegate,NBYSHttpServiceDelegate>

@property (nonatomic,strong) UIImageView        *tbHeaderView;

@property (nonatomic,strong) NBYSHttpService    *httpService;
@property (nonatomic,strong) NSMutableArray     *sourceArray;

@property (nonatomic,assign) NSUInteger         xPageIndex;  // default 0
@property (nonatomic,strong) NSString           *xRefreshTime;

@end

@implementation NBARefreshTableView

- (void)setUp {
    CGSize sz             = self.frame.size;
    self.tbHeaderView     = [[UIImageView alloc] initWithFrame:
                             CGRectMake(1.0f,.0f,sz.width-2.0f,100.0f)];
    
    self.tableHeaderView  = _tbHeaderView;
    
    // 数据源
    self.sourceArray      = [NSMutableArray array];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [self setUp];
}

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
                            @"pageCnt":@(kNBYPageLimtCount),
                            @"deviceId":@"xxxxx"};
    NSMutableDictionary *paras = [NSMutableDictionary dictionaryWithDictionary:unit];
    if (nil != _xRefreshTime) {
        [paras setObject:_xRefreshTime forKey:@"refreshTime"];
    }
    
    NSDictionary *userInfo = @{@"pageIndex":pageIndex,@"direction":@(direction)};
    [self.httpService requestHomeFixedModeChannelListWithParas:paras usrInfo:userInfo];
}

// 刷新，重新请求 当前数据列表
- (void)refreshChannelDataList  {
    if (0 == _sourceArray.count) {
        [self.parentCtrler displayOverFlowActivityView];
        
        [_tbHeaderView sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(_channel,@"imageUrl")]
                         placeholderImage:[UIImage imageNamed:@"nby_imgPlaceholder_6"]];
        
        [self uicc_actionHeaderRefreshTableViewDidTrigger];
    }
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
    
    if (indexPath.row == 0
        && nil != _distanceBlock) {
        NSString *distance = EncodeStringFromDic(cell.dto.item, @"distance");
        _distanceBlock([NBYUtils convertDistance:distance.floatValue]);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // todo
    
    NBYStickDetailViewController *ctrler = [[NBYStickDetailViewController alloc] init];
    NBYStickItemDTO *bean = _sourceArray[indexPath.row];
    // 内容id
    ctrler.contId = EncodeStringFromDic(bean.item, @"id");
    [self.parentCtrler.navigationController pushViewController:ctrler animated:YES];
    
}

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
        
        NBARefreshTableView *__weak weakSelf = self;
        
        NBCommentsListViewController *ctrler = [[NBCommentsListViewController alloc] init];
        ctrler.stickItem    = itemDto.item;
        ctrler.updateCommentNumBlock = ^ (NSNumber *commentNum) {
            itemDto.commentNum += (commentNum.integerValue);
            [weakSelf reloadRowsAtIndexPaths:@[itemDto.idxPath]
                            withRowAnimation:UITableViewRowAnimationNone];
            
        };
        [_parentCtrler.navigationController pushViewController:ctrler animated:YES];
    }else if (2 == operation) {
        
        NBARefreshTableView *__weak weakSelf = self;
        
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
        NBARefreshTableView *__weak weakSelf = self;
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
    
    if (CC_NBYHomeFixedModeChannelList == cmd) {
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
                [self reloadData];
                
            } // }}}
            
            if (list.count >= kNBYPageLimtCount) {
                _xPageIndex++;
                self.isCloseLoadMore = NO;
            }else {
                self.isCloseLoadMore = YES;
            }
            
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
            
            NBYStickItemDTO *bean = _sourceArray[idxPath.row];
            NSString *distance = EncodeStringFromDic(bean.item, @"distance");
            _distanceBlock([NBYUtils convertDistance:distance.floatValue]);
        }
    }
}

@end
