//
//  NBDynamicViewController.m
//  SuningEBuy
//
//  Created by suning on 14-9-3.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBDynamicViewController.h"
#import "UIImageView+WebCache.h"
#import "NBYUtils.h"


@interface NBDynamicTableCell : UITableViewCell

@property (nonatomic,strong) UIImageView *portriatImgView;
@property (nonatomic,strong) UIImageView *portriatMaskView;

@property (nonatomic,strong) UIView      *backVew;

@property (nonatomic,strong) UILabel     *nameLabel;
@property (nonatomic,strong) UIImageView *sexTypeImgView;

@property (nonatomic,strong) UILabel     *contentLabel;
@property (nonatomic,strong) UIImageView *cntImgView;
@property (nonatomic,strong) UILabel     *timeLabel;

@property (nonatomic,assign) CGFloat     *textHeight;

@property (nonatomic,strong) NSDictionary *one;

@end

@implementation NBDynamicTableCell

+ (CGFloat)baseHeight {
    return 180.f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:242.0f/255.0f
                                               green:242.0f/255.0f
                                                blue:242.0f/255.0f
                                               alpha:1.0f];
        
        CGSize sz = self.frame.size;
        self.backVew = [[UIView alloc] initWithFrame:CGRectMake(35.0f,15.0f,sz.width-45.0f,sz.height-15.f)];
        _backVew.backgroundColor  = [UIColor whiteColor];
        _backVew.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_backVew];
        
        self.portriatImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12.0f,20.0f,40.0f,40.0f)];
        _portriatImgView.image = [UIImage imageNamed:@"nnby_portriat"];
        [self.contentView addSubview:_portriatImgView];
        self.portriatMaskView = [[UIImageView alloc] initWithFrame:CGRectMake(7.0f,15.0f,50.0f,50.0f)];
        _portriatMaskView.image = [UIImage imageNamed:@"nnby_portriatMask_2"];
        [self.contentView addSubview:_portriatMaskView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0f,.0f,160.0f,21.0f)];
        _nameLabel.font = [UIFont systemFontOfSize:15.0f];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.backVew addSubview:_nameLabel];
        
        self.sexTypeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(26.0f,3.0f,15.0f,15.0f)];
        _sexTypeImgView.image = [UIImage imageNamed:@"nnby_sexType_0"];
        [self.backVew addSubview:_sexTypeImgView];
        
        CGSize tSz = self.backVew.frame.size;
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f,17.0f,tSz.width-39.0f,43.0f)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UIFont systemFontOfSize:15.0f];
        _contentLabel.numberOfLines = 2;
        [self.backVew addSubview:_contentLabel];
        
        self.cntImgView = [[UIImageView alloc] initWithFrame:CGRectMake(35.0f,56.0f,80,80.0f)];
        [self.backVew addSubview:_cntImgView];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f,141.0f,200.0f,21.0f)];
        _timeLabel.textColor = [UIColor colorWithRed:153.0f/255.0f
                                                green:153.0f/255.0f
                                                 blue:153.0f/255.0f
                                                alpha:.7f];
        _timeLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.backVew addSubview:_timeLabel];
    }
    return self;
}

- (void)setOne:(NSDictionary *)one {
    _one = one;
    if (nil != _one) {
        
        _contentLabel.text = EncodeStringFromDic(_one,@"content");
        [_cntImgView sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(_one,@"imageUrl")]
                       placeholderImage:nil];
        
        NSString *time  = EncodeStringFromDic(_one,@"time");
        if (nil != time) {
            _timeLabel.text = [NBYUtils dateFormartString:time];
        }else {
            _timeLabel.text = nil;
        }
        NSDictionary *u = EncodeDicFromDic(_one,@"u");
        NSString     *poraitUrl   = EncodeStringFromDic(u,@"faceUrl");
        NSString     *name        = EncodeStringFromDic(u,@"nick");
        NSNumber     *sex         = EncodeNumberFromDic(u,@"sex");
        
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
        
        [_portriatImgView sd_setImageWithURL:[NSURL URLWithString:poraitUrl]
                            placeholderImage:[UIImage imageNamed:@"nnby_portriat"]];
        
        //imageUrl
        NSString     *cntUrl      = EncodeStringFromDic(_one,@"imageUrl");
        [_cntImgView sd_setImageWithURL:[NSURL URLWithString:cntUrl]
                         placeholderImage:[UIImage imageNamed:@"nby_placeholder_2"]];
    }
}

@end


#import "NBYSHttpService.h" // http service
#import "NBCCSharedData.h"
#import "NBYStickDetailViewController.h"

@interface NBDynamicViewController () <NBYSHttpServiceDelegate>

@property (nonatomic,strong) NSMutableArray        *sourceArray;

@property (nonatomic,strong) NBYSHttpService       *httpService;
@property (nonatomic,assign) NSUInteger            xPageIndex;  // default 0
@property (nonatomic,strong) NSString              *xRefreshTime;

@property (nonatomic,strong) IBOutlet UIView       *tbMoreView;

// default 0
@property (nonatomic,assign) NSInteger             tbListMode; // 0 未读的动态列表 1已读取的动态列表

@end

@implementation NBDynamicViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:L(@"PageTitleDynamic")];
    
    UIColor *color = self.refreshTableView.backgroundColor;
    self.refreshTableView.refreshHeaderColor = color;
    self.refreshTableView.refreshFooterColor = color;
    
    self.sourceArray = [NSMutableArray array];
    
    [self displayOverFlowActivityView];
    [self delegate_uiccHeaderRefreshTableViewDidTrigger];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setTbListMode:(NSInteger)tbListMode {
//    _tbListMode = tbListMode;
//    
//    self.xPageIndex   = 0;
//    self.xRefreshTime = nil;
//}

// 分页 请求 数据
// direction = 0 上刷新 ; direction = 1 下刷新
- (void)requestGetItemsListWithPage:(NSUInteger)pageIdx direction:(int)direction {
    
    // noticeTimestamp
    if (pageIdx == 0) {
        self.xRefreshTime = nil;
    }
    // todo
    NSNumber *pageIndex = [NSNumber numberWithUnsignedInteger:pageIdx];
    NSDictionary *unit = @{@"u":[NBCCSharedData userInfo],
                           @"pos":[NBCCSharedData postion],
                           @"pageNo":pageIndex,
                           @"pageCnt":@"20",
                           @"noticeType":@(_tbListMode)};
    NSMutableDictionary *paras = [NSMutableDictionary dictionaryWithDictionary:unit];
    if (nil != _xRefreshTime) {
        //[paras setObject:_xRefreshTime forKey:@"refreshTime"];
        [paras setObject:_xRefreshTime forKey:@"noticeTimestamp"];
    }
    
    NSDictionary *userInfo = @{@"pageIndex":pageIndex,@"direction":@(direction)};
    [self.httpService requestGetDynamicsNoticeListWithParas:paras usrInfo:userInfo];
}

- (IBAction)on_loadMoreHistoryButton_clicked {
    
    if (_tbListMode == 1) {
        self.refreshTableView.tableFooterView.userInteractionEnabled = NO;
        
        if (0 == self.refreshTableView.tableFooterView.tag) {
            [self displayOverFlowActivityView];
            [self delegate_uiccHeaderRefreshTableViewDidTrigger];
        }else {
            if (!self.refreshTableView.isCloseLoadMore) {
                [self displayOverFlowActivityView];
                [self delegate_uiccFooterRefreshTableViewDidTrigger];
            }
        }
    }
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [NBDynamicTableCell baseHeight];
    
//    NSDictionary *one = _sourceArray[indexPath.row];
//    NSString *text = EncodeStringFromDic(one,@"content");
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NBYStickDetailViewController *ctrler = [[NBYStickDetailViewController alloc] init];
    NSDictionary *one = _sourceArray[indexPath.row];
    // 内容 id
    ctrler.contId     = EncodeStringFromDic(one, @"contId");
    [self.navigationController pushViewController:ctrler animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"NBDynamicTableCell_identify";
    NBDynamicTableCell *cell = (NBDynamicTableCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [[NBDynamicTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:identify];
    }
    
    cell.one = _sourceArray[indexPath.row];
    
    return cell;
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
    
    if (_tbListMode == 1
        &&!self.refreshTableView.isCloseLoadMore) {
        [self requestGetItemsListWithPage:_xPageIndex direction:1];
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
    
    if (CC_NBYGetDynamicNoticesList == cmd) {
        NSNumber *direction = userInfo[@"direction"];
        NSNumber *pageIndex = userInfo[@"pageIndex"];
        if (nil == error) {
            
            [self removeOverFlowActivityView];
            
            NSArray  *list      = result[@"data"];
            
            //self.xRefreshTime       = EncodeStringFromDic(result,@"refreshTime");
            
            if (list.count > 0) { // {{{
                
                if (direction.integerValue == 0
                    || pageIndex.intValue == 0
                    || _tbListMode == 0) { // Refresh
                    if (_sourceArray.count > 0) {
                        [_sourceArray removeAllObjects];
                    }
                }
                
                // load more
                [self.sourceArray addObjectsFromArray:list];
                
                [self.refreshTableView reloadData];
            } // }}
            
            if (_tbListMode == 1) { // 获取历史的 不是未读的 未读的不分页
                if (list.count >= kNBYPageLimtCount) {
                    _xPageIndex++;
                    self.refreshTableView.isCloseLoadMore = NO;
                }else {
                    self.refreshTableView.isCloseLoadMore = YES;
                }
                self.refreshTableView.tableFooterView = nil;
                if (self.xRefreshTime == nil
                    && _sourceArray.count > 0) {
                    self.xRefreshTime = EncodeStringFromDic(_sourceArray.firstObject,@"time");
                }
            }else {
                if (nil == self.refreshTableView.tableFooterView) {
                    self.refreshTableView.tableFooterView = self.tbMoreView;
                    self.refreshTableView.tableFooterView.tag = 0;
                }else {
                    self.refreshTableView.tableFooterView.userInteractionEnabled = YES;
                    self.refreshTableView.tableFooterView.tag = 1;
                }
                self.refreshTableView.isCloseLoadMore = YES;
            }
            
            self.tbListMode = 1;
            
        }else {
            [self removeOverFlowActivityView];
            [self presentSheet:error.localizedDescription];
        }
        [self.refreshTableView uicc_setLoadFinishedWithFlag:direction.integerValue];
    }
}

@end
