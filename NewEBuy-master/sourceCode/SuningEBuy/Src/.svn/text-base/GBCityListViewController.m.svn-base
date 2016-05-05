//
//  GBCityListViewController.m
//  SuningEBuy
//
//  Created by shasha on 13-3-4.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBCityListViewController.h"

@interface GBCityListViewController (){
    BOOL  __isLoaded;
}

@property (nonatomic, strong) NSArray  *allCityList;
@property (nonatomic, strong) NSArray  *hotCityList;
@property (nonatomic, strong) NSArray  *letterList;
@property (nonatomic, strong) UIView   *backgroundView;
@property (nonatomic, strong) UINavigationBar  *navigationBar;
@property (nonatomic, strong) GBCityService  *service;


@end

@implementation GBCityListViewController
@synthesize allCityList = _allCityList;
@synthesize hotCityList = _hotCityList;
@synthesize letterList = _letterList;
@synthesize backgroundView = _backgroundView;
@synthesize navigationBar = _navigationBar;
@synthesize delegate = _delegate;
@synthesize service = _service;



- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_allCityList);
    TT_RELEASE_SAFELY(_hotCityList);
    TT_RELEASE_SAFELY(_letterList);
    TT_RELEASE_SAFELY(_backgroundView);
    TT_RELEASE_SAFELY(_navigationBar);
}
- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"GBGroupCity");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        
        self.bSupportPanUI = NO;
    }
    return self;
}

- (void)loadView{
    [super loadView];
    [self.view addSubview:self.backgroundView];
//    [self.view addSubview:self.navigationBar];
    CGRect frame  = self.view.frame;
    frame.origin.y = 0;
    frame.size.height = frame.size.height - kUINavigationBarFrameHeight;
    self.groupTableView.frame = frame;
    self.groupTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.groupTableView];
}

- (void)backForePage
{
    [self pressReturn:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (__isLoaded) {
        return;
    }else{
        NSMutableDictionary *cityDic = (NSMutableDictionary *)[Config currentConfig].gbCityList;
        if ([cityDic count] == 0) {
            [self displayOverFlowActivityView];
            [self.service beginSendAllAndHotCityListHttpRequest];
        }
        else{
            self.allCityList = (NSArray *)[cityDic valueForKey:@"allCityList"];
            self.letterList = (NSArray *)[cityDic valueForKey:@"letterList"];
            
            [self.groupTableView reloadData];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didSendAllAndHotCityListFinished:(GBCityService *)service isSuccess:(BOOL)isSuccess{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        __isLoaded = YES;
        self.allCityList = service.allCityList;
        self.letterList = service.letterList;
        
        NSMutableDictionary *cityDic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [cityDic setValue:service.allCityList forKey:@"allCityList"];
        [cityDic setValue:service.letterList forKey:@"letterList"];
        [Config currentConfig].gbCityList = cityDic;
        TT_RELEASE_SAFELY(cityDic);
    }else{
        __isLoaded = NO;
        self.allCityList = nil;
        self.letterList = nil;
        [self presentSheet:service.errorMsg];
    }
    
    self.service = nil;
    [self.groupTableView reloadData];
}

- (void)pressReturn:(id)sender {
    GBCityDTO *dto = nil;
    
    
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 if ([self.delegate respondsToSelector:@selector(selectCity:)])
                                 {
                                     [self.delegate selectCity:dto];
                                 }
                             }];
}

#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!IsArrEmpty(self.letterList)) {
        return [self.letterList count];
    }else{
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *allCityDic = [self.allCityList objectAtIndex:section];
    NSArray *allValueArr = [allCityDic allValues] ;
    NSArray *allCityList = nil;
    if (!IsArrEmpty(allValueArr) ) {
        allCityList  = [allValueArr objectAtIndex:0];
    }
  
    if (!IsArrEmpty(allCityList)) {
        return [allCityList count];
    }else{
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    GBCityDTO *dto = nil;
    NSDictionary *allCityDic = [self.allCityList objectAtIndex:indexPath.section];
    NSArray *allValueArr = [allCityDic allValues] ;
    NSArray *allCityList = nil;
    if (!IsArrEmpty(allValueArr) ) {
        allCityList  = [allValueArr objectAtIndex:0];
    }
    if (!IsArrEmpty(allCityList)) {
        dto = (GBCityDTO *)[allCityList objectAtIndex:indexPath.row];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    if (IsNilOrNull(dto)) {
        cell.textLabel.text = @"";
    }else{
        cell.textLabel.text = dto.cityName;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.letterList objectAtIndex:section];
    return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.letterList;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GBCityDTO *dto = nil;
    NSDictionary *allCityDic = [self.allCityList objectAtIndex:indexPath.section];
    NSArray *allValueArr = [allCityDic allValues] ;
    NSArray *allCityList = nil;
    if (!IsArrEmpty(allValueArr) ) {
        allCityList  = [allValueArr objectAtIndex:0];
    }
    if (!IsArrEmpty(allCityList)) {
        dto = (GBCityDTO *)[allCityList objectAtIndex:indexPath.row];
    }
    
    if ([self.delegate respondsToSelector:@selector(selectCity:)]) {
        [self.delegate selectCity:dto];
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];

}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        CGRect frame = [[UIScreen mainScreen] bounds];
        _backgroundView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kNavControllerBackgroundImage]];
    }
    return _backgroundView;
}

-(UINavigationBar *)navigationBar{
    
    if (_navigationBar == nil) {
        
        _navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        _navigationBar.tintColor = [UIColor navTintColor];
        
        UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:L(@"GBGroupCity")];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithTitle:L(@"returnTo_myEuy") style:UIBarButtonItemStylePlain target:self action:@selector(pressReturn:)];
        
        [navigationItem setLeftBarButtonItem:cancelBtn];
        
        if ([_navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            UIImage *image = [UIImage imageNamed:@"system_nav_bg.png"];
            [_navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            
        }
        TT_RELEASE_SAFELY(cancelBtn);
        [_navigationBar pushNavigationItem:navigationItem animated:NO];
        TT_RELEASE_SAFELY(navigationItem);
        
    }
    
    return _navigationBar;
}

- (GBCityService *)service{
    if (!_service) {
        _service = [[GBCityService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

@end
