//
//  NBNearByViewController.m
//  suningNearby
//
//  Created by suning on 14-7-29.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBNearByViewController.h"

#import "NBARefreshTableView.h"
#import "NBBRefreshTableView.h"

#import "NBHomeMenu.h"                      // 首页菜单
#import "NBPublishViewController.h"         // 发布页面

#import "NBMagicPictureViewController.h"

#import "NBDynamicViewController.h"

#import "NBNUnreadView.h"

#import "NBCCSharedData.h"
#import "NBYSHttpService.h" // http service

#import "LoginViewController.h"

#import "LocateCityCommand.h"

#import "NBYPostionView.h"

#define kNBYTabButtonTag 9999


@interface NBNearByViewController () <NBHomeMenuDelegate,
                                    UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate,
                                    UIActionSheetDelegate,
                                    NBMagicPictureViewControllerDelegate,
                                    NBYSHttpServiceDelegate,
                                    UIScrollViewDelegate>

@property (nonatomic,strong) IBOutlet UIView              *titleTextView;

@property (nonatomic,strong) IBOutlet UIView              *iView;
@property (nonatomic,strong) IBOutlet UIScrollView        *tabButtonsView;
@property (nonatomic,strong) IBOutlet UIScrollView        *tabScrollView;

@property (nonatomic,strong) NSMutableArray *tabsButtonArr;

// 身边精华 固定频道列表
@property (nonatomic,strong) IBOutlet NBYPostionView      *tab0PostionView;
@property (nonatomic,strong) IBOutlet NBARefreshTableView *tab0RefreshTableView;

@property (nonatomic,strong) NBHomeMenu      *publicMenu;

@property (nonatomic,strong) NBNUnreadView   *unreadDynamicView;

@property (nonatomic,strong) UIButton        *navRightButton;
@property (nonatomic,strong) UIImageView     *navRightExpIcon;

@property (nonatomic,assign) NSInteger       selectedTabCategory; // default 0

@property (nonatomic,strong) NBYSHttpService *httpService;
// 数据源
@property (nonatomic,strong) NSArray         *channels; // 频道

//
@property (nonatomic,assign) BOOL            isGettingDynamicUnreadCnt;

@property (nonatomic,strong) IBOutlet UIView    *errorView;

@end


@implementation NBNearByViewController

- (void)dealloc {
    
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
    self.isNeedBackItem = NO;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bSupportPanUI = NO;
    
    [self setUpUI];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self displayOverFlowActivityView];
    //定位
    NBNearByViewController *__weak weakSelf = self;
    LocateCityCommand *cmd_ = [[LocateCityCommand alloc] init];
    cmd_.timeOutDefault = 60.0;
    [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
        if (cmd_.responseStatus == LocateCitySuccess) {
    
            [NBCCSharedData shared].coordinate = cmd_.coordinate;
            [NBCCSharedData shared].addressDictionary = cmd_.addressInfoDic;
    
            // 请求获取频道配置
            [weakSelf displayOverFlowActivityView];
            [weakSelf.httpService requestHomeChannelsList];
            
        }else {
            [weakSelf presentSheet:L(@"DearLocateFailBeSureServiceAvaible")];
            [weakSelf removeOverFlowActivityView];
        }
    }];
}

- (void)setUpUI {
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:self.titleTextView];
    self.navigationItem.leftBarButtonItem = barItem;
    
    self.tab0RefreshTableView.parentCtrler = self;
    self.tabScrollView.delegate = self;
    
    // {{{ custom navigation bar item
    UIView *barItemView = [[UIView alloc] initWithFrame:CGRectMake(.0f,.0f,110.0f,44.0f)];
    UIButton *leftBt = [[UIButton alloc] initWithFrame:CGRectMake(.0f,.0f,46.0f,44.0f)];
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(.0f,-5.0f,.0f,.0f);
    [leftBt setImage:[UIImage imageNamed:@"nb_lingdang"] forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(on_dynamicButton_clicked)
     forControlEvents:UIControlEventTouchUpInside];
    [barItemView addSubview:leftBt];
    
    self.unreadDynamicView = [[NBNUnreadView alloc] initWithFrame:CGRectMake(20.0f,7.0f,16.0f,16.0f)];
    [_unreadDynamicView setBadgeValue:nil];
    [barItemView addSubview:_unreadDynamicView];
    
    UILabel *vLine = [[UILabel alloc] initWithFrame:CGRectMake(42.0f,5.0f,1.0f,34.0f)];
    vLine.backgroundColor = [UIColor colorWithRed:223.0f/255.0f
                                            green:223.0f/255.0f
                                             blue:226.0f/255.0f
                                            alpha:1.0f];
    [barItemView addSubview:vLine];
    
    self.navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(46.0f,.0f,64.0f,44.0f)];
    _navRightButton.tag = 0;
    [_navRightButton setImage:[UIImage imageNamed:@"nb_publicIcon"] forState:UIControlStateNormal];
    _navRightButton.titleEdgeInsets = UIEdgeInsetsMake(2.0f,6.0f,.0f,.0f);
    _navRightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_navRightButton setTitleColor:[UIColor colorWithRed:58.0f/255.0f
                                                   green:204.0f/255.0f
                                                    blue:196.0f/255.0f
                                                   alpha:1.0f]
                          forState:UIControlStateNormal];
    [_navRightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [_navRightButton setTitle:@"发布" forState:UIControlStateNormal];
    [_navRightButton addTarget:self action:@selector(on_expandMenuButton:)
              forControlEvents:UIControlEventTouchUpInside];
    
    self.navRightExpIcon = [[UIImageView alloc] initWithFrame:CGRectMake(58.0f,23.0f,6.0f,7.0f)];
    _navRightExpIcon.image = [UIImage imageNamed:@"nb_publicIcon_exp"];
    [_navRightButton addSubview:_navRightExpIcon];
    
    [barItemView addSubview:_navRightButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barItemView];
    // }}}
    
    self.tabScrollView.contentSize = CGSizeMake(self.view.frame.size.width,
                                                _tabScrollView.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // UIScrollView 会重置 contentOffset = CGPointMake(.0f,.0f);
    for (UIButton *tab in _tabButtonsView.subviews) {
         if (tab.isSelected) {
             NSUInteger idx = [_tabButtonsView.subviews indexOfObject:tab];
             _tabScrollView.contentOffset = CGPointMake(idx*self.view.frame.size.width,.0f);
             break;
         }
     }
    
    
    if (!_isGettingDynamicUnreadCnt
        && (nil != _channels && _channels.count > 0)) {
        if ([NBCCSharedData isAppLogined]) { // 登录情况下 才请求动态未读数字
            self.isGettingDynamicUnreadCnt = YES;
            // todo
            NSDictionary *paras = @{@"u":[NBCCSharedData userInfo]};
            [self.httpService requestGetDynamicNoticeCount:paras];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGSize sz = self.tabScrollView.frame.size;
    int pageIndex = scrollView.contentOffset.x / sz.width;
    
    UIButton *sender = [self.tabsButtonArr objectAtIndex:pageIndex];
    if (!sender.selected) {
        [self selectTab:sender scroll:NO];
    }
}

#pragma mark - dynamic create ui

- (UIButton *)tabButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(.0f,.0f,80.0f,36.0f)];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:85/255.0f green:210/255.0f blue:204/255.0f alpha:1.0f]
                 forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    
    [button addTarget:self
               action:@selector(on_headerTabsSwitch_clicked:)
               forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)createTabs {
    
    [self.tabButtonsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tabScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.tabsButtonArr = [NSMutableArray array];
    
    self.tabButtonsView.contentSize = CGSizeMake(80.0f*_channels.count,36.0f);
    for (NSInteger i = 0; i < self.channels.count; ++i) {
        NSDictionary *one = _channels[i];
        UIButton *bt = [self tabButton];
        if (0 == i) {
            bt.selected = YES;
        }
        bt.tag = (kNBYTabButtonTag+i);
        bt.frame = CGRectMake(i*80.0f,.0f,80.0f,36.0f);
        [bt setTitle:EncodeStringFromDic(one,@"name") forState:UIControlStateNormal];
        [_tabButtonsView addSubview:bt];

        [self.tabsButtonArr addObject:bt];
    }
}

- (void)createTableViews {
    
    CGFloat h = self.tabScrollView.frame.size.height;
    CGSize sz = self.tabScrollView.frame.size;
    for (int i = 0; i < _channels.count; ++i) {
        if (0 == i) {
            
            self.tab0PostionView.frame        = CGRectMake(.0f,.0f,sz.width,h);
            
            self.tab0RefreshTableView.frame   = CGRectMake(.0f,.0f,sz.width,h);
            self.tab0RefreshTableView.channel = _channels[0];
            self.tab0RefreshTableView.tag     = kNBYTabButtonTag;
            self.tab0RefreshTableView.parentCtrler = self;
            
            NBYPostionView *__weak weakPosView = self.tab0PostionView;
            
            self.tab0RefreshTableView.distanceBlock = ^ (NSString *text) {
                [weakPosView setTitle:text];
            };
            
            self.tab0RefreshTableView.parentView = _iView;
            [self.tabScrollView addSubview:self.tab0PostionView];
        }else {
            
            CGRect frame = CGRectMake(i*sz.width,.0f,sz.width,h);
            NBYPostionView *posView = [[NBYPostionView alloc] initWithFrame:frame];
            
            NBBRefreshTableView *nRefreshTableView = nil;
            
            nRefreshTableView = [[NBBRefreshTableView alloc] initWithFrame:CGRectMake(.0f,.0f,sz.width, sz.height)
                                                                     style:UITableViewStylePlain];
            nRefreshTableView.parentCtrler = self;
            nRefreshTableView.channel      = _channels[i];
            nRefreshTableView.tag          = (kNBYTabButtonTag+i);
            
            NBYPostionView *__weak weakPosView = posView;
            nRefreshTableView.distanceBlock = ^ (NSString *text) {
                [weakPosView setTitle:text];
            };
            
            nRefreshTableView.parentView = _iView;
            [posView addSubview:nRefreshTableView];

            [self.tabScrollView addSubview:posView];
        }
    }
    
    self.tabScrollView.contentSize = CGSizeMake(sz.width*_channels.count,h);
}


#pragma mark -

//- (void)updatePublicButtonByTab:(NSInteger)tag {
//    _navRightButton.tag     = (tag - kNBYTabButtonTag);
//    _navRightExpIcon.hidden = YES;
//    if (0 ==  _navRightButton.tag) {
//        _navRightExpIcon.hidden = NO;
//        [_navRightButton setImage:[UIImage imageNamed:@"nb_publicIcon"] forState:UIControlStateNormal];
//    }else if (1 ==  _navRightButton.tag) {
//        [_navRightButton setImage:[UIImage imageNamed:@"nb_publicIcon_1"] forState:UIControlStateNormal];
//    }else if (2 ==  _navRightButton.tag) {
//        [_navRightButton setImage:[UIImage imageNamed:@"nb_publicIcon_2"] forState:UIControlStateNormal];
//    }else if (3 ==  _navRightButton.tag) {
//        [_navRightButton setImage:[UIImage imageNamed:@"nb_publicIcon_3"] forState:UIControlStateNormal];
//    }
//}

- (void)selectTab:(UIButton *)sender scroll:(BOOL)bScroll {
    if (!sender.selected) {
        for (UIButton *tab in _tabButtonsView.subviews) {
            tab.selected = NO;
        }
        sender.selected = YES;
        if (bScroll) {
            CGPoint pt = CGPointMake(((sender.tag-kNBYTabButtonTag)*self.view.frame.size.width),.0f);
            [_tabScrollView setContentOffset:pt animated:YES];
        }
        
        //[self updatePublicButtonByTab:sender.tag];
        
        self.selectedTabCategory = (sender.tag-kNBYTabButtonTag);
        
        if (0 == sender.tag) {
            [_tab0RefreshTableView refreshChannelDataList];
        }else {
            
            NBBRefreshTableView *nRefreshTableView = (NBBRefreshTableView *)[self.tabScrollView viewWithTag:sender.tag];
            if ([nRefreshTableView respondsToSelector:@selector(refreshChannelDataList)]) {
                [nRefreshTableView refreshChannelDataList];
            }
        }
    }
}

- (void)on_headerTabsSwitch_clicked:(UIButton *)sender {
    
    if (!sender.selected) {
        
        NSUInteger idx = (sender.tag-kNBYTabButtonTag);
        CGPoint pt = CGPointMake((idx*self.view.frame.size.width),.0f);
        [_tabScrollView setContentOffset:pt animated:NO];
       
        [self selectTab:sender scroll:NO];
    }
}

- (NBHomeMenu *)publicMenu {
    if (nil == _publicMenu) {
        
        CGSize sz = self.iView.frame.size;
        
        _publicMenu = [[NBHomeMenu alloc] initWithFrame:CGRectMake(.0f,.0f,sz.width,sz.height)];
        _publicMenu.hidden      = YES;
        _publicMenu.delegate    = self;
        [self.iView addSubview:_publicMenu];
    }
    if (nil == _publicMenu.channels) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sort != 0"];
        _publicMenu.channels = [self.channels filteredArrayUsingPredicate:predicate];
    }
    
    return _publicMenu;
}

- (void)presentLoginViewController {
    LoginViewController *ctrler = [[LoginViewController alloc] init];
    ctrler.dismissViewControllerComplete = ^ {
        
        self.isGettingDynamicUnreadCnt = YES;
        // todo
        [self.httpService requestGetDynamicNoticeCount:@{@"u":[NBCCSharedData userInfo]}];
    };
    AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc]
                                               initWithRootViewController:ctrler];
    [self presentModalViewController:navCtrler animated:YES];
}

- (void)on_expandMenuButton:(UIButton *)sender {
    
    if ([NBCCSharedData isAppLogined]) {
        
        self.publicMenu.hidden = !self.publicMenu.hidden;
        
//        if (0 == sender.tag) {
//            self.publicMenu.hidden = !self.publicMenu.hidden;
//        }else {
//            [self showActionSheet];
//        }
    }else {
        [self presentLoginViewController];
    }
}

- (void)on_dynamicButton_clicked {
    
    if ([NBCCSharedData isAppLogined]) { // 登录情况下 才请求动态未读数字
        
        NBDynamicViewController *ctrler = [[NBDynamicViewController alloc] init];
        [self.navigationController pushViewController:ctrler animated:YES];
        
        _unreadDynamicView.badgeValue = nil;
    }else {
        [self presentLoginViewController];
    }
}

- (void)delegate_NBHomeMenu_selected:(NSDictionary *)channel {
    
    self.selectedTabCategory = [_channels indexOfObject:channel];
    
    [self showActionSheet];
}

#pragma mark - add

- (void)showActionSheet {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"从相册选择",@"拍照", nil];
    [sheet showInView:self.view];
}

- (void)GetPhotoToModifyPortrait:(UIImagePickerControllerSourceType)sourceType {
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    
    UIImagePickerController *ctrler = [[UIImagePickerController alloc]init];
    ctrler.delegate      = self;
    ctrler.sourceType    = sourceType;
    ctrler.allowsEditing = YES;
    [self presentViewController:ctrler animated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (0 == buttonIndex) {         // choose photo
        [self GetPhotoToModifyPortrait:UIImagePickerControllerSourceTypePhotoLibrary];
    }else if (1 == buttonIndex) {   // take photo
        [self GetPhotoToModifyPortrait:UIImagePickerControllerSourceTypeCamera];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSData *imgData = UIImageJPEGRepresentation(editedImage,1.0f);
        //NSLog(@"s:%lu",imgData.length/1024);
        if (imgData.length > (1024*1024)/4/*250k左右*/) {
            imgData = UIImageJPEGRepresentation(editedImage,.0f);
            //NSLog(@"c:%lu",imgData.length/1024);
        }
        
        NBMagicPictureViewController *ctrler = [[NBMagicPictureViewController alloc] init];
        ctrler.delegate      = self;
        ctrler.selectedImage = [UIImage imageWithData:imgData];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrler];
        nav.navigationBarHidden = YES;
        [self presentViewController:nav animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)delegate_MagicPictureViewController_composedImage:(UIImage *)composedImg {
    NBPublishViewController *ctrler = [[NBPublishViewController alloc] init];
    ctrler.passedImage              = composedImg;
    ctrler.category                 = _selectedTabCategory;
    ctrler.channel                  = _channels[_selectedTabCategory];
    [self.navigationController pushViewController:ctrler animated:YES];
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
                                 usrInfo:(id)userInfo
                                   error:(NSError *)error
                                     cmd:(E_CMDCODE)cmd {
    
    if (nil == error) {
        
        if (CC_NBYGetHomeChannels == cmd) {
            
            if (nil != _errorView) {
                [_errorView removeFromSuperview];
                self.errorView = nil;
            }
            
            self.channels = result[@"data"];
            
            [self createTabs];
            
            if (nil != _channels
                && _channels.count > 0) { // {{{ --- --- ---
                // 创建 频道下 数据源 列表
                [self createTableViews];
                // 加载收个tab频道下 数据列表
                [self.tab0RefreshTableView refreshChannelDataList];
                
                if (!_isGettingDynamicUnreadCnt) {
                    
                    if ([NBCCSharedData isAppLogined]) { // 登录情况下 才请求动态未读数字
                        self.isGettingDynamicUnreadCnt = YES;
                        // todo
                        NSDictionary *paras = @{@"u":[NBCCSharedData userInfo]};
                        [self.httpService requestGetDynamicNoticeCount:paras];
                    }
                }
                
                self.navigationItem.rightBarButtonItem.enabled = YES;
                
            }// }}} --- --- ---
        }else if (CC_NBYGetDynamicNoticeCount == cmd) {
            _unreadDynamicView.badgeValue = EncodeStringFromDic(result,@"data");
        }
        
    }else {
        [self removeOverFlowActivityView];
        [self presentSheet:error.localizedDescription];
        
         if (CC_NBYGetHomeChannels == cmd
             && nil != _errorView) {
             CGSize sz = _iView.frame.size;
             self.errorView.frame = CGRectMake(.0f,.0f,sz.width,sz.height);
             [self.iView addSubview:_errorView];
         }
    }
    
    if (CC_NBYGetDynamicNoticeCount == cmd) {
        self.isGettingDynamicUnreadCnt = NO;
    }
}

@end
