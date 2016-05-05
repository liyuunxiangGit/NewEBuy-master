//
//  NBCommentsListViewController.m
//  suningNearby
//
//  Created by suning on 14-8-4.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBCommentsListViewController.h"
#import "NBCommentTableCell.h"
#import "UICCRefreshCommonTableView.h"

#import "NBYSHttpService.h" // http service
#import "NBCCSharedData.h"
#import "LoginViewController.h"


@interface NBCommentsListViewController () <NBYSHttpServiceDelegate,UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UIView       *inputView;
@property (nonatomic,strong) IBOutlet UITextField  *textField0;
@property (nonatomic,strong) IBOutlet UIView       *noCommentsView;

@property (nonatomic,strong) NSMutableArray        *sourceArray;

@property (nonatomic,strong) NBYSHttpService       *httpService;
@property (nonatomic,assign) NSUInteger            xPageIndex;  // default 0
@property (nonatomic,strong) NSString              *xRefreshTime;

@property (nonatomic,assign) NSUInteger            myCommentNum; // default 0

@end

@implementation NBCommentsListViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"评论"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(on_TapGestureRecognizer_responder)];
    [self.refreshTableView addGestureRecognizer:tap];
    
    CGSize sz = self.commonView.frame.size;
    self.noCommentsView.frame = CGRectMake(.0f,.0f,sz.width,sz.height);
    
    self.sourceArray = [NSMutableArray array];
    
    [self displayOverFlowActivityView];
    [self delegate_uiccHeaderRefreshTableViewDidTrigger];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChanged:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
 
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 分页 请求 数据
// direction = 0 上刷新 ; direction = 1 下刷新
- (void)requestGetItemsListWithPage:(NSUInteger)pageIdx direction:(int)direction {
    
    if (pageIdx == 0) {
        self.xRefreshTime = nil;
    }
    
    NSNumber *pageIndex = [NSNumber numberWithUnsignedInteger:pageIdx];
    NSDictionary *unit = @{@"contId":EncodeStringFromDic(_stickItem,@"id"),
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
    [self.httpService requestGetCommentsListWithParas:paras usrInfo:userInfo];
}

- (void)requestSendCommnet {
    
    NSString *comment = _textField0.text;
    NSString *content = [comment stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (nil != content
        && content.length > 0) {
        
        [self displayOverFlowActivityView];
        
        NSDictionary *paras = @{@"contId":EncodeStringFromDic(_stickItem,@"id"),
                               @"u":[NBCCSharedData userInfo],
                               @"pos":[NBCCSharedData postion],
                               @"comment":content};
        [self.httpService requestSendComment:paras];
        
        [_textField0 resignFirstResponder];
    }
}

- (void)on_TapGestureRecognizer_responder {
    [_textField0 resignFirstResponder];
}

#pragma mark - keyboard

- (void)keyboardFrameWillChanged:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGSize sz  = self.inputView.frame.size;
    CGPoint pt = CGPointMake(.0f,self.commonView.frame.size.height-sz.height);
    
    [UIView animateWithDuration:.3f delay:.0f options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.inputView.frame = CGRectMake(.0f,pt.y-keyboardSize.height,sz.width,sz.height);
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)keyboardWasHidden:(NSNotification *)notif {
    
    CGSize sz = self.commonView.frame.size;
    
    self.inputView.frame = CGRectMake(.0f,sz.height-49.0f,sz.width,49.0f);
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // min height 100.0f
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"NBCommentTableCell_identify";
    NBCommentTableCell *cell = (NBCommentTableCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [NBCommentTableCell cell];
    }
    
    cell.idxPath = indexPath;
    cell.commentItem = _sourceArray[indexPath.row];
    
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
    
    if (!self.refreshTableView.isCloseLoadMore) {
        [self requestGetItemsListWithPage:_xPageIndex direction:1];
    }
}

#pragma mark -

- (void)sendComment {
    
    if (![NBCCSharedData isAppLogined]) {
        
        NBCommentsListViewController *__weak weakSelf = self;
        
        LoginViewController *ctrler = [[LoginViewController alloc] init];
        ctrler.dismissViewControllerComplete = ^ {
            [weakSelf requestSendCommnet];
        };
        AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc]
                                                   initWithRootViewController:ctrler];
        [self presentModalViewController:navCtrler animated:YES];
    }else {
        [self requestSendCommnet];
    }
}

- (IBAction)on_sendPublicButton_clicked:(UIButton *)sender {
    [self sendComment];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendComment];
    return YES;
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
    
    if (CC_NBYGetCommentsList == cmd) {
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
                
            } // }}
            
            if (list.count >= kNBYPageLimtCount) {
                _xPageIndex++;
                self.refreshTableView.isCloseLoadMore = NO;
            }else {
                self.refreshTableView.isCloseLoadMore = YES;
            }
            
            if (nil == _sourceArray
                || 0 == _sourceArray.count) {
                [self.commonView insertSubview:self.noCommentsView
                                  belowSubview:self.inputView];
                
            }else {
                [self.noCommentsView removeFromSuperview];
            }
            
        }else {
            [self removeOverFlowActivityView];
            [self presentSheet:error.localizedDescription];
        }
        [self.refreshTableView uicc_setLoadFinishedWithFlag:direction.integerValue];

    }else if (CC_NBYSendComment == cmd) {
        if (nil == error) {
            
            ++_myCommentNum;
            
            _textField0.text = nil;
            self.xRefreshTime = nil;
            [self displayOverFlowActivityView];
            [self delegate_uiccHeaderRefreshTableViewDidTrigger];
            
            [self.refreshTableView setContentOffset:CGPointZero];
            
        }else {
            [self presentSheet:error.localizedDescription];
        }
        [self removeOverFlowActivityView];
    }
}

@end
