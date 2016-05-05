//
//  HotKeywordsViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "HotKeywordsViewController.h"

@interface HotKeywordsViewController ()

@end

@implementation HotKeywordsViewController

@synthesize tagList = _tagList;
@synthesize service = _service;
@synthesize hotKeywordsDelegate = _hotKeywordsDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)dealloc{
    TT_RELEASE_SAFELY(_tagList);
    SERVICE_RELEASE_SAFELY(_service);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect frame1 = [[UIScreen mainScreen] bounds];
    
//    int statusbarHeight = 0;
//    if (!IOS7_OR_LATER)
//        statusbarHeight = 20;
    CGFloat height = frame1.size.height - 172 - 44 - 40 - kUITabBarFrameHeight - kStatusBarHeight;
    
    CGRect frame = CGRectMake(0, 172 + 44 + 40, 320, height);
    
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tagList.hidden=NO;
    self.tagList.frame = CGRectMake(20, 15, 280, height);
    [self.tagList setAutomaticResize:YES];
    //        [self.tagList setTagDelegate:self.owner];
    [self.view addSubview:self.tagList];
}

- (void)loadView
{

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.service beginGetHotKeywords];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SearchService *)service
{
    if (!_service) {
        _service = [[SearchService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(DWTagList *)tagList
{
    if (!_tagList) {
        _tagList=[[DWTagList alloc] init];
        _tagList.tagDelegate=self;
    }
    return _tagList;
}

#pragma mark -
#pragma mark DWTagList delegate

-(void)switchHotKeywords
{
    [self.service beginGetHotKeywords];
}

- (void)selectedTag:(NSString *)tagName
{
    if (_hotKeywordsDelegate&&[_hotKeywordsDelegate respondsToSelector:@selector(didSelectKeyword:)] && [_hotKeywordsDelegate respondsToSelector:@selector(didSelectHotUrl:bFromSearchView:wordOfUrl:)]) {
        
        NSString *url = [self getTagUrl:tagName];
        if (IsStrEmpty(url))
        {
            [_hotKeywordsDelegate didSelectKeyword:tagName];
        }
        else
        {
            [_hotKeywordsDelegate didSelectHotUrl:url bFromSearchView:YES wordOfUrl:tagName];
        }
    }
}



//通过点击的名称来查找对应的url
- (NSString *)getTagUrl:(NSString *)hotWord
{
    if (self.service.hotWordDtoList && self.service.hotWordDtoList.count > 0)
    {
        for (HotWordDTO *dto in self.service.hotWordDtoList) {
            if ([dto.hotwordsStr isEqualToString:hotWord])
                return dto.urlStr;
        }
    }
    
    return nil;
}

#pragma mark -
#pragma mark service delegate

- (void)getHotKeywordsCompleteWithService:(SearchService *)service
                                   Result:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
{
    if (isSuccess) {
        /* modi by wangjiaxing
         _searchView.hotKeywordsView.keywordArray = service.hotKeywordList;
         [_searchView.hotKeywordsView beginDisplay];
         */
        //add by wangjiaxing 20130520 for new type of hot keywords
        self.tagList.textArray = service.hotKeywordList;
        self.tagList.hotwordDtoList = [service.hotWordDtoList copy];
        [self.tagList display];
        
    }else{
        //[self presentSheet:errorMsg];
    }
}


@end
