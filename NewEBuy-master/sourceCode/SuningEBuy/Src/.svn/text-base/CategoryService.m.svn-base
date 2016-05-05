//
//  CategoryService.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CategoryService.h"
#import "categoryHttpDataSource.h"
#import "SNCache.h"
#import "SNSwitch.h"
@interface CategoryService ()

@property (nonatomic, copy) NSString *cacheKey;

- (void)getCategoryDidFinished:(BOOL)isSuccess;
- (void)parseCategoryList:(NSDictionary *)item;


@end


@implementation CategoryService

@synthesize delegate = _delegate;
@synthesize isFromCache = _isFromCache;
@synthesize isCategoryLoaded = _isCategoryLoaded;
@synthesize categoryStr = _categoryStr;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_categoryList);
    TT_RELEASE_SAFELY(_cacheKey);
    TT_RELEASE_SAFELY(_categoryStr);

    _delegate = nil;
    
    
}

- (void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(cateHttpMsg);
}

- (void)sendCategoryRequest:(NSString *)category
{
    if (category.length == 0) {
        return;
    }
    
    
    NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *newPhoneCategory = [dic objectForKey:@"catagoryPhone"];

    NSString *phoneCategory = [Config currentConfig].phoneCategory;
    
    self.cacheKey = [NSString stringWithFormat:@"sn.category.%@",category];

    if ([phoneCategory isEqualToString:newPhoneCategory])
    {
        self.categoryStr = category;
        NSData *jsonData = [[SNFileCache defaultCache] dataForKey:self.cacheKey];
        if (jsonData)
        {
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSDictionary *items = [jsonStr JSONValue2];
            _isFromCache = YES;
            [self parseCategoryList:items];
            
            return;
        }
    }
    
    //分类重新获取移除缓存文件
    [[SNFileCache defaultCache] removeDataForKey:self.cacheKey];

    [Config currentConfig].phoneCategory = newPhoneCategory;
    
    [[Config currentConfig].defaults synchronize];
    
    _isFromCache = NO;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
#if kCategoryDebug
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:category?category:@"" forKey:kHttpRequestHomePartNameKey];
    
    HTTPMSG_RELEASE_SAFELY(cateHttpMsg);
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,kHttpRequestHomeFirstViewNew];
    
#else
    
    [postDataDic setObject:@"" forKey:@"channelId"];
    
    [postDataDic setObject:@"1" forKey:@"appId"];
    
    HTTPMSG_RELEASE_SAFELY(cateHttpMsg);
    
//    NSString *url = @"http://10.19.113.77:8080/suning-web-mobile/appbuy/public/getShopKindsInfo.do";
    
    NSString *url = [NSString stringWithFormat:@"%@%@",KNewHomeAPIURL,@"mts-web/appbuy/public/getShopKindsInfo.do"];

#endif
    cateHttpMsg =  [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_FirstCategory];

    cateHttpMsg.requestMethod =RequestMethodGet;
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:cateHttpMsg];
}


- (void)getCategoryDidFinished:(BOOL)isSuccess
{
    if (isSuccess) {
        _isCategoryLoaded = YES;
    }
    else{
        
        //一级分类是空 也认为是获取失败，再加载时要进行网络请求，所以要将缓存文件删除
        //(加载时是否请求网络是根据有没有缓存判断的)
        [[SNFileCache defaultCache] removeDataForKey:self.cacheKey];
    }
    
    if ([_delegate respondsToSelector:@selector(service:loadCateComplete:)])
    {
        [_delegate service:self loadCateComplete:isSuccess];
    }
}

#pragma mark -
#pragma mark HTTPRequest Delegate Methods

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    [self getCategoryDidFinished:NO];
    
}

-(NSTimeInterval)lengthOfSaveFileTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *nowDateStr = [formatter stringFromDate:[NSDate date]];
    NSString *midNightDateStr = [NSString stringWithFormat:@"%@ 23:59:59",nowDateStr];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *midNightDate = [formatter dateFromString:midNightDateStr];
    
    NSTimeInterval timeLong = [midNightDate timeIntervalSinceDate:[NSDate date]];
    
    TT_RELEASE_SAFELY(formatter);
    
    //为了安全 小于0 保存60秒 大于一天时间 保存一天时间
    if (timeLong < 0) {
        
        timeLong = 60;
    }
    else if (timeLong > 60*60*24){
        
        timeLong = 60*60*24;
    }
    return timeLong;
}
- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    if (receiveMsg.jasonItems == nil) {
        
        self.errorMsg = kHttpResponseJSONValueFailError;
        
        [self getCategoryDidFinished:NO];
        
    }else{
        
        if (!_isFromCache) {
            //缓存json
            NSData *jsonData = [receiveMsg.responseString dataUsingEncoding:NSUTF8StringEncoding];
            [[SNFileCache defaultCache] saveData:jsonData forKey:self.cacheKey cacheAge:[self lengthOfSaveFileTime]];
            
        }

#if kCategoryDebug

        NSString *isSuccess = [receiveMsg.jasonItems objectForKey:@"isSuccess"];
#else
        NSString *isSuccess = [receiveMsg.jasonItems objectForKey:@"successFlg"];
#endif
        if (NotNilAndNull(isSuccess) && [isSuccess isEqualToString:@"1"]) {
            
            
            [self parseCategoryList:receiveMsg.jasonItems];
            
        }
        else
        {
            self.errorMsg = L(@"get category unsuccess");
            
            [self getCategoryDidFinished:NO];
        }
    }
    
}


- (void)parseCategoryList:(NSDictionary *)item
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
            
            NSMutableArray *tempArr = [categoryHttpDataSource parseFirstCategoryList:item];

            dispatch_async(dispatch_get_main_queue(), ^{

                //如果不是电器目录，那么二级目录为空的目录就不展示
                if (![self.categoryStr isEqualToString:kCategoryEnmuElec]) {
                    
                    for (V2FristCategoryDTO *dto in tempArr) {
                        
//                        if (0 < [dto.secList count]) {
                        
                            [self.categoryList addObject:dto];
//                        }
                    }
                    
                }
                else{
                    
                   self.categoryList = tempArr; 
                }
                if (0 < [self.categoryList count]) {
                    
                    [self getCategoryDidFinished:YES];
                }
                else{
                    
                    //一级分类是空 也认为是获取失败
                    self.errorMsg = L(@"search records is null");
                    [self getCategoryDidFinished:NO];
                }
                
            });
            
        }
    });
}

-(NSMutableArray *)categoryList{
    
    if (!_categoryList) {
        
        _categoryList = [[NSMutableArray alloc] init];
    }
    return _categoryList;
}
@end
