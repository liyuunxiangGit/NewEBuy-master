//
//  HomeScrollViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "HomeScrollViewController.h"
#import "SNSpecialSubjectViewController.h"
#import "SweepstakesViewController.h"
#import "SweepstakesRuleInfoViewController.h"
#import "CategoryViewController.h"

@implementation HomeScrollViewController

@synthesize service = _service;
@synthesize specialSebjectList = _specialSebjectList;
@synthesize isOnSaleLoaded;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    TT_RELEASE_SAFELY(_specialSebjectList);
    SERVICE_RELEASE_SAFELY(_service);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = L(@"home");
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshSpecialViews)
                                                     name:Refresh_SpecialSubject_Views
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshSpecialViews)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    self.viewControllers = [NSMutableArray arrayWithObject:rootViewController];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isOnSaleLoaded) {
        [self.service beginGetSpecialSubjectsRequest:@"" withPomAreaId:@""];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

#pragma mark -
#pragma mark service

- (SpecialSubjectService *)service
{
    if (!_service) {
        _service = [[SpecialSubjectService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

#pragma mark- SpecialSubjectList HttpRequest
#pragma mark  获取促销专题信息

- (void)sendSpecialSubjectListHttpRequest
{
    [self.service beginGetSpecialSubjectsRequest:@"" withPomAreaId:@""];
}

- (void)getSpecialSubjectsCompletionWithResult:(BOOL)isSuccess
                                      errorMsg:(NSString *)errorMsg
                                   subjectList:(NSArray *)list
{
    for (SNSpecialSubjectViewController *vc in self.viewControllers)
    {
        if (vc.reloading) {
            [vc refreshDataComplete];
        }
    }
    
    if (isSuccess && !IsArrEmpty(list)) {
        isOnSaleLoaded = YES;
        
        NSMutableArray *specialSortArr = [[NSMutableArray alloc] initWithCapacity:[list count]];
        [self sortArr:specialSortArr OriginArr:list];
        if (!IsArrEmpty(specialSortArr)) {
            
            self.specialSebjectList = specialSortArr;
            
            [Config currentConfig].specialSubjectList = self.specialSebjectList;

            int count = [specialSortArr count];
            if ([self.viewControllers count] > count+1)
            {
                for (int i = 0; i < count; i++)
                {
                    SNSpecialSubjectViewController *controller = [self.viewControllers objectAtIndex:i+1];
                    SNSpecialSubjectDTO *dto = [specialSortArr objectAtIndex:i];
                    controller.specialSubjectDto = dto;
                }
            
                NSRange range = NSMakeRange(count+1, [self.viewControllers count]-count-1);
                [[self mutableArrayValueForKey:@"viewControllers"] removeObjectsInRange:range];

            }
            else
            {
                NSMutableArray *addedControllers = [NSMutableArray array];

                for (int i = 0; i < count; i++)
                {
                    SNSpecialSubjectDTO *dto = [specialSortArr objectAtIndex:i];
                    if ([self.viewControllers count] > i+1) {
                        SNSpecialSubjectViewController *subjectVC = [self.viewControllers objectAtIndex:i+1];
                        subjectVC.specialSubjectDto = dto;
                        
                    }else{
                        SNSpecialSubjectViewController *controller =[[SNSpecialSubjectViewController alloc] init];
//                        controller.superViewController = self;
                        controller.specialSubjectDto = dto;
                        [addedControllers addObject:controller];
                    }
                }
                
                if ([addedControllers count] > 0) {
                    [[self mutableArrayValueForKey:@"viewControllers"] addObjectsFromArray:addedControllers];
                }

            }
            
        }
        TT_RELEASE_SAFELY(specialSortArr);
        
    }
    
}

- (void)sortArr:(NSMutableArray *)specialSortArr OriginArr:(NSArray *)originArr{
    for (int i=0; i<[originArr count]; i++) {
        SNSpecialSubjectDTO *specialSubjectDTO = (SNSpecialSubjectDTO *)[originArr objectAtIndex:i];
        //按照屏幕的排布顺序排序
        if (!IsArrEmpty(specialSortArr)) {
            int index = 0;
            for (SNSpecialSubjectDTO *specialDto in specialSortArr) {
                index ++;
                if ([specialSubjectDTO.areaDisPosition intValue]<[specialDto.areaDisPosition intValue]) {
                    [specialSortArr insertObject:specialSubjectDTO atIndex:index-1] ;
                    break;
                }else if(index == [specialSortArr count]){
                    [specialSortArr addObject:specialSubjectDTO];
                    break;
                }else{
                    continue;
                }
            }
        }else{
            [specialSortArr addObject:specialSubjectDTO];
        }
    }
}

- (void)refreshSpecialViews{
    [self sendSpecialSubjectListHttpRequest];
}


@end

