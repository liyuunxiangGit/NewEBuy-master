//
//  NBYDaShangViewController.m
//  SuningEBuy
//
//  Created by suning on 14-9-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBYDaShangViewController.h"
#import "UIImageView+WebCache.h"
#import "NBYUtils.h"


@interface NNBYDaShangTableCell : UITableViewCell

@property (nonatomic,strong) UIView      *leftView;
@property (nonatomic,strong) UIImageView *portriatImgView;
@property (nonatomic,strong) UIImageView *portriatMaskView;

@property (nonatomic,strong) UILabel     *nameLabel;
@property (nonatomic,strong) UIImageView *sexTypeImgView;
@property (nonatomic,strong) UILabel     *timeLabel;
@property (nonatomic,strong) UILabel     *contentLabel;

@property (nonatomic,strong) NSDictionary *one;

// 1 第一个且总数未1 或者 最后一个 且总数>=2 ; 其他 0
@property (nonatomic,assign) int portriatMaskProperty;

@end

@implementation NNBYDaShangTableCell

// cell height = 100.0f

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 头像 和 竖线
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(20.0f,.0f,58.0f,100.0f)];
        //self.leftView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_leftView];
        
        self.portriatImgView = [[UIImageView alloc] initWithFrame:CGRectMake(2.0f,2.0f,54.0f,54.0f)];
        _portriatImgView.autoresizingMask = UIViewAutoresizingNone;
         // todo
        _portriatImgView.image = [UIImage imageNamed:@"nnby_portriat"];
        [self.leftView addSubview:_portriatImgView];
        
        self.portriatMaskView = [[UIImageView alloc] initWithFrame:CGRectMake(.0f,.0f,58.0f,100.0f)];
        _portriatMaskView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        UIImage *maskImg = [UIImage imageNamed:@"nnby_portriatMask2"];
//        _portriatMaskView.image = [maskImg resizableImageWithCapInsets:UIEdgeInsetsMake(58.0f,.0f,.0f,.0f)];
        [self.leftView addSubview:_portriatMaskView];
        
        // 名称
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110.0f,2.0f,140.0f,21.0f)];
        _nameLabel.font  = [UIFont systemFontOfSize:15.0f];
        _nameLabel.textColor = [UIColor colorWithRed:112.0f/255.0f
                                               green:112.0f/255.0f
                                                blue:112.0f/255.0f
                                               alpha:1.0f];
        [_nameLabel setText:@"Title"];
        [self.contentView addSubview:_nameLabel];
        
        // 性别标识
        self.sexTypeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(89.0f,2.0f,20.0f,20.0f)];
        _sexTypeImgView.contentMode = UIViewContentModeCenter;
        // todo
        _sexTypeImgView.image = [UIImage imageNamed:@"nnby_sexType_0"];
        [self.contentView addSubview:_sexTypeImgView];
        
        // 时间
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(220.0f,2.0f,80.0f,21.0f)];
        _timeLabel.font = [UIFont systemFontOfSize:13.0f];
        _timeLabel.textColor = [UIColor colorWithRed:187.0f/255.0f
                                               green:187.0f/255.0f
                                                blue:187.0f/255.0f
                                               alpha:1.0f];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_timeLabel setText:L(@"LCTime")];
        [self.contentView addSubview:_timeLabel];
        
        // 内容
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0f,36.0f,200.0f,21.0f)];
        _contentLabel.textColor = _nameLabel.textColor;
        _contentLabel.font = [UIFont systemFontOfSize:15.0f];
        _contentLabel.numberOfLines = 0;
        [_contentLabel setText:L(@"AwardXCloudDiamond")];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)setOne:(NSDictionary *)one {
    _one = one;
    if (nil != _one) {
        
        NSString     *poraitUrl   = EncodeStringFromDic(_one,@"faceUrl");
        NSString     *name        = EncodeStringFromDic(_one,@"nick");
        NSNumber     *sex         = EncodeNumberFromDic(_one,@"sex");
        
        NSString     *score       = EncodeStringFromDic(_one,@"score");
        NSString     *createTime  = EncodeStringFromDic(_one,@"createTime");
        
        if (nil == name
            || name.length == 0) {
            //name = EncodeStringFromDic(u, @"id");
            name = @"用户";
        }
        _nameLabel.text = name;
        
        // 性别 标识
        if (sex.intValue == 1) {
            _sexTypeImgView.image = [UIImage imageNamed:@"nnby_sexType_0"];
        }else {
            _sexTypeImgView.image = [UIImage imageNamed:@"nnby_sexType_1"];
        }
        if (nil != createTime) {
            _timeLabel.text = [NBYUtils dateFormartString:createTime];
        }else {
            _timeLabel.text = nil;
        }
        
        _contentLabel.text = [NSString stringWithFormat:@"%@%@%@",L(@"AwardLe"),((nil==score)?@"":score),L(@"CloudDiamond")];
        
        [_portriatImgView sd_setImageWithURL:[NSURL URLWithString:poraitUrl]
                            placeholderImage:[UIImage imageNamed:@"nnby_portriat"]];
        
    }
}

- (void)setPortriatMaskProperty:(int)portriatMaskProperty {
    _portriatMaskProperty = portriatMaskProperty;
    
    if (0 == _portriatMaskProperty) {
        UIImage *maskImg = [UIImage imageNamed:@"nnby_portriatMask2"];
        _portriatMaskView.image = [maskImg resizableImageWithCapInsets:UIEdgeInsetsMake(58.0f,.0f,.0f,.0f)];
    }else if (1 == _portriatMaskProperty) {
        UIImage *maskImg = [UIImage imageNamed:@"nnby_portriatMask3"];
        _portriatMaskView.image = [maskImg resizableImageWithCapInsets:UIEdgeInsetsMake(58.0f,.0f,.0f,.0f)];
    }
}

@end


#import "NBDaShangView.h"                   // 打赏 积分/云钻 选择视图
#import "NBYSHttpService.h"
#import "NBCCSharedData.h"
#import "LoginViewController.h"


@interface NBYDaShangViewController () <NBYSHttpServiceDelegate>

@property (nonatomic,strong) NBYSHttpService    *httpService;
@property (nonatomic,strong) NSMutableArray     *sourceArray;

@property (nonatomic,assign) NSUInteger         xPageIndex;  // default 0
@property (nonatomic,strong) NSString           *xRefreshTime;

@property (nonatomic,strong) IBOutlet UIView    *rewardView;
@property (nonatomic,strong) IBOutlet UIView    *noCommentsView;

@property (nonatomic,assign) NSUInteger   myCommentNum; // default 0

@end

@implementation NBYDaShangViewController

- (void)dealloc {
    
    if (nil != _updateCommentNumBlock
        && _myCommentNum > 0) {
        _updateCommentNumBlock(@(_myCommentNum));
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:L(@"PageTitleAwardDetails")];
    
    self.refreshTableView.refreshHeaderColor = [UIColor whiteColor];
    self.refreshTableView.refreshFooterColor = [UIColor whiteColor];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(.0f,
                                                                  .0f,self.view.frame.size.width,
                                                                  20.0f)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.refreshTableView.tableHeaderView = headerView;
    
    self.sourceArray = [NSMutableArray array];
    
    [self displayOverFlowActivityView];
    [self delegate_uiccHeaderRefreshTableViewDidTrigger];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"NNBYDaShangTableCell_identify";
    NNBYDaShangTableCell *cell = (NNBYDaShangTableCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [[NNBYDaShangTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    if (_sourceArray.count == 1) {
        cell.portriatMaskProperty = 1;
    }else { // > 1
        if (0 != indexPath.row
                  && (indexPath.row == _sourceArray.count - 1)) {
            cell.portriatMaskProperty = 1;
        }else {
             cell.portriatMaskProperty = 0;
        }
    }
    
    cell.one = _sourceArray[indexPath.row];
    
    return cell;
}

#pragma arguments

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

// 分页 请求 数据
// direction = 0 上刷新 ; direction = 1 下刷新
- (void)requestGetItemsListWithPage:(NSUInteger)pageIdx direction:(int)direction {
    
    if (pageIdx == 0) {
        self.xRefreshTime = nil;
    }
    NSNumber *pageIndex = [NSNumber numberWithUnsignedInteger:pageIdx];
    NSString *contId    = EncodeStringFromDic(_stickItem,@"id");
    NSDictionary *unit = @{@"contId":((nil==contId)?@"":contId),
                           @"u":[NBCCSharedData userInfo],
                           @"pos":[NBCCSharedData postion],
                           @"pageNo":pageIndex,
                           @"pageCnt":@"20",
                           @"sort":@"0"};
    NSMutableDictionary *paras = [NSMutableDictionary dictionaryWithDictionary:unit];
    if (nil != _xRefreshTime) {
        [paras setObject:_xRefreshTime forKey:@"refreshTime"];
    }
    
    NSDictionary *userInfo = @{@"pageIndex":pageIndex,@"direction":@(direction)};
    [self.httpService requestGetRewardsList:paras usrInfo:userInfo];
}

- (void)beginDoReward:(NSDictionary *)item comment:(NSString *)content {
    
    [self displayOverFlowActivityView];
    
    NSString *score = EncodeStringFromDic(item,@"score");
    score = ((nil == score) ? @"" : score);
    NSString *contId = EncodeStringFromDic(_stickItem,@"id");
    contId = ((nil == contId) ? @"" : contId);
    
    NSDictionary *tu = EncodeDicFromDic(_stickItem,@"u");
    NSString *toUId = EncodeStringFromDic(tu, @"id");
    toUId = ((nil == toUId) ? @"" : toUId);
    
    NSString *loginId = [NBCCSharedData userId];
    
    score = [PasswdUtil encryptData:[score dataUsingEncoding:NSUTF8StringEncoding]
                            forUser:((nil==loginId)?@"":loginId)];
    
    toUId = [PasswdUtil encryptData:[toUId dataUsingEncoding:NSUTF8StringEncoding]
                            forUser:((nil==loginId)?@"":loginId)];
    
    NSDictionary *paras = @{@"score":score,
                           @"u":[NBCCSharedData userInfo],
                           @"pos":[NBCCSharedData postion],
                           @"contId":contId,
                           @"toUId":toUId,
                           @"comment":((nil==content)?@"":content)};
    
    [self.httpService requestDoReward:paras];
}

- (void)showDaShangSelectedView {
    
    NBDaShangView *view = [NBDaShangView showDaShangViewAtWindow];
    view.parentCtrler = self;
    NBYDaShangViewController *__weak weakSelf = self;
    view.selectedBlock = ^(NSDictionary *item,NSString *content) {
        [weakSelf beginDoReward:item comment:content];
    };
}

- (IBAction)on_dashangButon_clicked:(UIButton *)sender {
    
    if ([NBCCSharedData isAppLogined]) {
        
        NSDictionary *cu = [NBCCSharedData userInfo];
        NSDictionary *u  = EncodeDicFromDic(_stickItem, @"u");
        if ([EncodeStringFromDic(cu,@"id") isEqualToString:EncodeStringFromDic(u,@"id")]) {
            
            [self presentSheet:L(@"CantAwardYouself")];
            return;
        }else {
            [self showDaShangSelectedView];
        }
    }else {
        
        NBYDaShangViewController *__weak weakSelf = self;
        
        LoginViewController *ctrler = [[LoginViewController alloc] init];
        ctrler.dismissViewControllerComplete = ^ {
            [weakSelf showDaShangSelectedView];
        };
        AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc]
                                                   initWithRootViewController:ctrler];
        [self presentModalViewController:navCtrler animated:YES];
    }
}

#pragma mark - http 

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
    
    if (CC_NBYGetDaShangsList == cmd) {
        NSNumber *direction = userInfo[@"direction"];
        NSNumber *pageIndex = userInfo[@"pageIndex"];
        if (nil == error) {
            
            [self removeOverFlowActivityView];
            
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
                [self.sourceArray addObjectsFromArray:list];
                [self.refreshTableView reloadData];
                
                if (list.count >= kNBYPageLimtCount) {
                    _xPageIndex++;
                    self.refreshTableView.isCloseLoadMore = NO;
                }else {
                    self.refreshTableView.isCloseLoadMore = YES;
                }
                
            } // }}
            
            if (nil == _sourceArray
                || 0 == _sourceArray.count) {
                [self.commonView insertSubview:self.noCommentsView
                                  belowSubview:self.rewardView];
            }else {
                [self.noCommentsView removeFromSuperview];
            }
            
        }else {
            [self removeOverFlowActivityView];
            [self presentSheet:error.localizedDescription];
        }
        [self removeOverFlowActivityView];
        [self.refreshTableView uicc_setLoadFinishedWithFlag:direction.integerValue];
        
    }else if (CC_NBYDoReward == cmd) {
        
        if (nil == error) {
            // todo
            
            self.xRefreshTime = nil;
            [self displayOverFlowActivityView];
            [self delegate_uiccHeaderRefreshTableViewDidTrigger];
            
            _myCommentNum++;
            
            [self.refreshTableView setContentOffset:CGPointZero];
            
        }else {
            [self presentSheet:error.localizedDescription];
        }
        [self removeOverFlowActivityView];
    }
}


@end
