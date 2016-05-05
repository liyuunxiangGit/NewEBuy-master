//
//  MYEfubaoViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-8-31.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MYEfubaoViewController.h"
#import "UserCenter.h"

@interface MYEfubaoViewController()
@end

@implementation MYEfubaoViewController
@synthesize myTableView    = _myTableView;
@synthesize alertString    = _alertString;
@synthesize activeView     = _activeView; 
@synthesize descLabel      = _descLabel;
@synthesize activateButton = _activateButton;
@synthesize userDiscountService = _userDiscountService;


#pragma mark - ViewLife Circle Methods
#pragma mark   View的生命周期方法

- (id)init{
	
    self = [super init];
	
    if (self) {
        
        self.title = L(@"efubao");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        
        [self initAlertInfo];
        
        
	}
	
	return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_myTableView);
    TT_RELEASE_SAFELY(_alertString);
    TT_RELEASE_SAFELY(_activeView);
    TT_RELEASE_SAFELY(_descLabel);
    TT_RELEASE_SAFELY(_activateButton);
    SERVICE_RELEASE_SAFELY(_userDiscountService);
    
}



- (void)loadView {
	
	[super loadView];
	
   // UIView *contentView = self.view;
	
	CGRect frame = [self visibleBoundsShowNav:YES showTabBar:self.hidesBottomBarWhenPushed];//contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
	frame.size.height = 130;
	
    self.myTableView = self.groupTableView;
    
	self.myTableView.frame = frame;
    
    self.myTableView.scrollEnabled = NO;
	
	[self.view addSubview:self.myTableView];
    
    [self initActiveView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self.userDiscountService beginGetEfubaoAccountInfo];
    
}
#pragma mark -  Methods
#pragma mark    声明的方法实现

-(void)initAlertInfo{    
    //子类重写实现
    self.alertString = L(@"activated");
}

- (void)initActiveView{
    //子类重写实现
    
}

-(void)updateViews{
    
    [self.myTableView reloadData];
    //子类继承实现
}

- (void)activeAction:(id)sender{
    
    //子类重写实现
    
}

- (CGFloat)getDescHeight{
    
    CGSize size = CGSizeMake(300, 30000);
    
    CGSize fontSize = [self.descLabel.text sizeWithFont:self.descLabel.font constrainedToSize:size lineBreakMode:self.descLabel.lineBreakMode];
    
    CGFloat height = fontSize.height;
    
    return height;
    
}

//更新用户优惠信息


-(void)didGetEfubaoAccountCompleted:(BOOL)isSuccess errorMsg:(NSString *)errorMsg{
    
    if (isSuccess) {
        UserCenter *center = [UserCenter defaultCenter];
        center.userDiscountInfoDTO.advance = self.userDiscountService.efubaoBalance;
        [self updateViews];
    }else{
        [self presentSheet:L(errorMsg)];
    }
}

#pragma mark - Properties Initialization Metnods
#pragma mark   属性的初始化方法

-(EfubaoAccountService *)userDiscountService{
    
    if (!_userDiscountService) {
        
        _userDiscountService = [[EfubaoAccountService alloc] init];
        
        _userDiscountService.delegate = self;
        
    }
    return _userDiscountService;
}

-(UITableView*)myTableView{
	
	if(!_myTableView){
		
		_myTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                    style:UITableViewStyleGrouped];    
		
		[_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_myTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_myTableView.scrollEnabled = NO;
		
		_myTableView.userInteractionEnabled = YES;
		
		_myTableView.delegate =self;
		
		_myTableView.dataSource =self;
		
		_myTableView.backgroundColor =[UIColor clearColor];
        
        _myTableView.backgroundView = nil;
		
	}
	
	return _myTableView;
}

-(UIButton *)activateButton{
    
    if (!_activateButton) {
        
        //[UIImage streImageNamed:@"orange_button.png"]
        _activateButton = [[UIButton alloc] init];
        _activateButton.frame = CGRectZero;
        [_activateButton setBackgroundImage:[UIImage streImageNamed:@"orange_button.png"] forState:UIControlStateNormal];
        [_activateButton setBackgroundImage:[UIImage streImageNamed:@"orange_button_clicked.png"] forState:UIControlStateHighlighted];
 
        [_activateButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        _activateButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _activateButton.titleLabel.textAlignment = UITextAlignmentCenter;
        [_activateButton setTitle:L(@"active_Efubao") forState:UIControlStateNormal];
        [_activateButton addTarget:self action:@selector(activeAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _activateButton;
    
}

- (UILabel*)descLabel{
    
    if (!_descLabel) {
        
        _descLabel = [[UILabel alloc] init];
        
        _descLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        
        _descLabel.textColor = [UIColor orange_Red_Color];
        
        _descLabel.textAlignment = UITextAlignmentCenter;
        
        _descLabel.numberOfLines = 0;
        
        _descLabel.lineBreakMode = UILineBreakModeWordWrap;
        
        _descLabel.backgroundColor = [UIColor clearColor];
        
    }
    
    return _descLabel;
    
}


#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。 
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 48;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 2;	
}
-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    return v;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    
    return v;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *myEFubaoCellIdentifier = @"myEFubaoCellIdentifier";
	
//	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:myEFubaoCellIdentifier];
//	
//	if(cell == nil){
//		
//		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myEFubaoCellIdentifier ];
//        cell.textLabel.textColor = [UIColor darkTextColor];
//        cell.backgroundColor = [UIColor cellBackViewColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//	}
    
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myEFubaoCellIdentifier];
    
    if (nil == cell)
    {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myEFubaoCellIdentifier];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
        cell.backgroundColor = [UIColor cellBackViewColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
	if (indexPath.row == 0) {
        
        cell.textLabel.text = L(@"efubaoBalance");
        
        cell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
        
        UserCenter *center = [UserCenter defaultCenter];
        
        cell.detailTextLabel.text = center.userDiscountInfoDTO.advance;
        
        cell.detailTextLabel.textColor = [UIColor colorWithRGBHex:0x999081];
        
    }else{
        
        cell.textLabel.text = L(@"efubaoStatus");
        cell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];

        cell.detailTextLabel.text =self.alertString;
        cell.detailTextLabel.textColor = [UIColor colorWithRGBHex:0x999081];

        
    }
    
	return cell;
}

@end
