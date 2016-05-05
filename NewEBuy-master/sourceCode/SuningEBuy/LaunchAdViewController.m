//
//  LaunchAdViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-3-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LaunchAdViewController.h"
#import "SNCache.h"
#import "SystemInfo.h"
#import "AddressInfoDAO.h"
#import "SNActivityViewController.h"
#import "HomeScrollViewController.h"
#import "SNRouter.h"

@interface LaunchAdViewController ()
{
    CFAbsoluteTime resignTime;
}



@end

@implementation LaunchAdViewController

- (void)dealloc
{
    TT_RELEASE_SAFELY(_adImageView);
    SERVICE_RELEASE_SAFELY(_DMService);
    TT_RELEASE_SAFELY(_dmImageView);
    TT_RELEASE_SAFELY(_dmResultDto);
    TT_RELEASE_SAFELY(_dmInfoDict);
    
     dimissBlock = nil;
    
    [SNRouter cancelCurrentTask];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        needToSpecailView = NO;
        _isPush = NO;
    }
    return self;
}

- (void)setDismissBlock:(SNBasicBlock)block
{
    if (block != dimissBlock) {
        dimissBlock = [block copy];
    }
}


- (void)showOnWindow:(UIWindow *)window
{
    [self.view addSubview:self.dmImageView];
    
    [window addSubview:self.view];
    
    [window bringSubviewToFront:self.view];
}


- (UIImageView *)adImageView
{
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] init];
        CGRect frame = [UIScreen mainScreen].bounds;
        _adImageView.frame = frame;
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        NSString *imageName = [SystemInfo is_iPhone_5]?@"Default-568h.png":@"Default.png";
        _adImageView.image = [UIImage imageNamed:imageName];
        _adImageView.userInteractionEnabled = YES;
    }
    return _adImageView;
}

-(EGOImageViewEx *)dmImageView{
    
    if (!_dmImageView) {
        
        _dmImageView = [[EGOImageViewEx alloc] init];
        
        CGRect frame = [UIScreen mainScreen].bounds;
        
        self.view.frame = frame;
        
        _dmImageView.frame = frame;
        
        _dmImageView.image = [UIImage imageWithData:[_dmInfoDict objectForKey:@"imagedata"]];
        
        /*if ([SystemInfo is_iPhone_5]) {
            _dmImageView.frame = CGRectMake(frame.origin.x, 170, frame.size.width, 225);
        }else{
            _dmImageView.frame = CGRectMake(frame.origin.x, 150, frame.size.width, 225);
        }*/
        
        _dmImageView.placeholderImage = nil;
        
        _dmImageView.exDelegate = self;
    }
    
    
    return _dmImageView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self.view addSubview:self.adImageView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(dismissAd) withObject:nil afterDelay:3];
}

- (void)dismissAd
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissAd) object:nil];

    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.alpha = 0.0;
                     }completion:^(BOOL isFinish){
                         [self.view removeFromSuperview];
                         if (dimissBlock) {
                             dimissBlock();
                         }
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark EGOImageViewExDelegate
- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx{
    //八连版
    sourceTitle = @"DM";
    if (0 == [[_dmInfoDict objectForKey:@"advertType"] length]) {
        
        return;
    }
//    _dmResultDto.adId = @"81514";
//    _dmResultDto.activityRule = @"12121212";
//    _dmResultDto.activityTitle = @"34343434";
//    _dmResultDto.adTypeCode = @"25";
//    [[AppDelegate currentAppDelegate] goToActivityView:_dmResultDto from:DMORDER];
    
    if (_isPush) {
        
        return;
    }
    else{
        
        _isPush = YES;
    }
    
    //DM
    /*[SNRouter handleAdTypeCode:_dmResultDto.adTypeCode
                          adId:_dmResultDto.adId
                        chanId:_dmResultDto.activityRule
                       qiangId:_dmResultDto.activityTitle
                    onChecking:NULL
                   shouldRoute:^BOOL(SNRouterObject *obj) {
                        
                        if (![obj isErrorOrDoNothing]) {
                            [self dismissAd];
                            return YES;
                        }else{
                            return NO;
                        }
                        
                    } didRoute:NULL
                        source:SNRouteSourceDM];*/
    NSString *adId = [_dmInfoDict objectForKey:@"advertIds"];
    
    NSString *chanId = nil;
    
    NSString *qiangId = nil;
    
    if ([[_dmInfoDict objectForKey:@"advertType"] isEqualToString:@"1015"])
    {
        NSArray *partArray = [adId componentsSeparatedByString:@"_"];
        
        if ([partArray count] == 3)
        {
            adId = [partArray safeObjectAtIndex:0];
            
            qiangId = [partArray safeObjectAtIndex:1];
            
            chanId = [partArray safeObjectAtIndex:2];
        }else{
            adId = [NSString stringWithFormat:@"%@_%@",[partArray safeObjectAtIndex:0],[partArray safeObjectAtIndex:1]];
            
            qiangId = [partArray safeObjectAtIndex:2];
            
            chanId = [partArray safeObjectAtIndex:3];
            
        }
    }
    
    [SNRouter handleAdTypeCode:[_dmInfoDict objectForKey:@"advertType"]
                          adId:adId
                        chanId:chanId
                       qiangId:qiangId
                    onChecking:NULL
                   shouldRoute:^BOOL(SNRouterObject *obj) {
                       
                       if (![obj isErrorOrDoNothing]) {
                           [self dismissAd];
                           return YES;
                       }else{
                           return NO;
                       }
                       
                   } didRoute:NULL
                        source:SNRouteSourceDM];
}

- (void)requestDMorder{
    
    DMOrderDTO *dto = [[DMOrderDTO alloc] init];
    dto.platform = @"1";
    dto.provinceId = [Config currentConfig].defaultProvince;
    dto.cityId = [Config currentConfig].defaultCity;
    dto.appId = @"1";
    dto.dmType = @"1";
    
    resignTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    
    [self.DMService getDMOrderRequest:dto];
    
}

-(DMOrderService *)DMService{
    
    if (!_DMService) {
        
        _DMService = [[DMOrderService alloc] init];
        
        _DMService.delegate = self;
    
    }
    
    return _DMService;
}

-(void)service:(DMOrderService *)service result:(DMOrderResultDTO *)dto{
    
    if (dto&&!IsStrEmpty(dto.dmPictureUrlStr)) {
//            //更新图片
        CFAbsoluteTime currentTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
        
        NSTimeInterval duration = currentTime - resignTime;
        
        if (duration < 3)
        {
            NSString *url = dto.dmPictureUrlStr;
            //        url = [url stringByAppendingString:@"?size=large"]; //debug
            
            //判断是否是大图模式，默认是小图模式
            NSRange range = [url rangeOfString:@"?"];
            if (range.location != NSNotFound)
            {
                NSString *result = [url substringFromIndex:range.location+1];
                NSDictionary *params = [result queryDictionaryUsingEncoding:NSUTF8StringEncoding];
                NSString *size = [params objectForKey:@"size"];
                if ([size isEqualToString:@"large"])
                {
                    
                    self.dmImageView.frame = [UIScreen mainScreen].bounds;
                }
                else if ([size isEqualToString:@"small"])
                {
                    //小图默认不用调节
                }
                else
                {
                    //无size字段就退出，不展示
                    return;
                }
            }
            else
            {
                //无size字段就退出，不展示
                return;
            }
            
            self.dmImageView.imageURL = [NSURL URLWithString:dto.dmPictureUrlStr];
            
            self.dmResultDto = dto;

        }else
        {
            [self dismissAd];
        }
    }else{
        [self dismissAd];
    }
    
}
@end
