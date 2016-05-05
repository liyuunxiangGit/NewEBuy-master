//
//  MyIntegerUnActiveViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-11-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyIntegerUnActiveViewController.h"
#import "BoundPhoneViewController.h"
#import "ActiveMyIntegerViewController.h"
#import "InternalRuleHelpViewController.h"

@implementation MyIntegerUnActiveViewController

@synthesize myTableView    = _myTableView;
@synthesize alertString    = _alertString;
@synthesize activeView     = _activeView; 
@synthesize descLabel      = _descLabel;
@synthesize activateButton = _activateButton;
@synthesize isBoundPhone = _isBoundPhone;
@synthesize isEmailActivate = _isEmailActivate;
@synthesize errorMsg = _errorMsg;


#pragma mark - ViewLife Circle Methods
#pragma mark   View的生命周期方法

- (id)init{
	
    self = [super init];
	
    if (self) {
        
        self.title = L(@"MyIntegral");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        _isBoundPhone = NO;
        _isEmailActivate = NO;
        
        _errorMsg = @"";
        [self initAlertInfo];
        
//        UIBarButtonItem*internalHelpButton = [[UIBarButtonItem alloc] init];
//        [internalHelpButton setStyle:UIBarButtonItemStylePlain];
//        [internalHelpButton setTarget:self];
//        [internalHelpButton setAction:@selector(goToInternalRules)];
//        [internalHelpButton setTitle:@"云钻规则"];
//        self.navigationItem.rightBarButtonItem= internalHelpButton;
//        TT_RELEASE_SAFELY(internalHelpButton);
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"MyEBuy_IntegralRule")];

	}
	
	return self;
}

- (void)righBarClick
{
    [self goToInternalRules];
}

- (void)goToInternalRules
{    
    InternalRuleHelpViewController *vc = [[InternalRuleHelpViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    TT_RELEASE_SAFELY(vc);
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_myTableView);
    TT_RELEASE_SAFELY(_alertString);
    TT_RELEASE_SAFELY(_activeView);
    TT_RELEASE_SAFELY(_descLabel);
    TT_RELEASE_SAFELY(_activateButton);
    TT_RELEASE_SAFELY(_errorMsg);
}



- (void)loadView {
	
	[super loadView];
	
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
	frame.size.height = 120;
	
	self.myTableView.frame = frame;
	
	[self.view addSubview:self.myTableView];
    
    [self initActiveView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![self.errorMsg isEqualToString:@""])
    {
        [self presentSheet:self.errorMsg];
    }
}

#pragma mark -  Methods
#pragma mark    声明的方法实现

-(void)updateViews{
    
    [self.myTableView reloadData];
    //子类继承实现
}

- (CGFloat)getDescHeight{
    
    CGSize size = CGSizeMake(300, 30000);
    
    CGSize fontSize = [self.descLabel.text sizeWithFont:self.descLabel.font constrainedToSize:size lineBreakMode:self.descLabel.lineBreakMode];
    
    CGFloat height = fontSize.height;
    
    return height;
    
}

-(void)initActiveView{
    
    CGRect frame = self.myTableView.frame;
    
    frame.origin.x = 10;
    
    frame.size.width= 300;
    
    frame.origin.y = frame.origin.y + self.myTableView.height;
    
    if (self.isEmailActivate) {
        if (self.isBoundPhone) {
            //"MyIntegeral_UnboundPhone"＝"您的云钻帐号尚未激活，请绑定手机号后激活使用。";
            self.descLabel.text = L(@"MyIntegeral_UnboundPhone");
        }else{
            //"MyIntegeral_UnActive"＝"您的云钻帐号尚未激活，请先激活再使用我的云钻功能。";
            self.descLabel.text = L(@"MyIntegeral_UnActive");
        }
    }else{
        self.descLabel.text = L(@"Active_Email_integral");
    } 
    
    frame.size.height = [self getDescHeight];
    
    self.descLabel.frame = frame;
    self.descLabel.textColor = [UIColor darkRedColor];
    
    [self.view addSubview:self.descLabel];
    
    frame.origin.y = frame.origin.y + self.descLabel.height + 20;
    
    frame.size.height = 40;
    
    self.activateButton.frame = frame;
    
    [self.view addSubview:self.activateButton];
    
    if (self.isEmailActivate) {
        
        if (self.isBoundPhone) {
            [self.activateButton setTitle:L(@"activated_phone") forState:UIControlStateNormal];
        }else{
            //"activated_integral"="激活云钻";
            [self.activateButton setTitle:L(@"activated_integral") forState:UIControlStateNormal];
        }
        
    }else{
        
        [self.activateButton removeFromSuperview];
        
    }
    
    
}

- (void)initAlertInfo{
    self.alertString =  L(@"unActivated");
}

- (void)activeAction:(id)sender{
    //add by xingxianping
    NSString *logonName = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if ([emailTest evaluateWithObject:logonName]) {
        [self presentSheet:L(@"MyEBuy_PleaseGoToWebsiteToActivateEmailAccount")];
        
        return;
    }

    if (self.isEmailActivate) {
        if (self.isBoundPhone) {
            
            BoundPhoneViewController *controller = [[BoundPhoneViewController alloc] init];
            
            controller.isEfubaoBound = NO;
            
            [self.navigationController pushViewController:controller animated:YES];
            
            TT_RELEASE_SAFELY(controller);
        }else{
            
            ActiveMyIntegerViewController *nextViewController = [[ActiveMyIntegerViewController alloc] initWithIntegral:[UserCenter defaultCenter].userDiscountInfoDTO.achievement];
            
            [self.navigationController pushViewController:nextViewController animated:YES];
            
            TT_RELEASE_SAFELY(nextViewController);
        }
    }
}

#pragma mark - Properties Initialization Metnods
#pragma mark   属性的初始化方法

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
        
        
        
        _activateButton = [[UIButton alloc] init];
        _activateButton.frame = CGRectZero;
        [_activateButton setBackgroundImage:[UIImage streImageNamed:@"orange_button.png"] forState:UIControlStateNormal];
         [_activateButton setBackgroundImage:[UIImage streImageNamed:@"orange_button_clicked.png"] forState:UIControlStateHighlighted];
        [_activateButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        _activateButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _activateButton.titleLabel.textAlignment = UITextAlignmentCenter;
        _activateButton.backgroundColor = [UIColor clearColor];
        [_activateButton addTarget:self action:@selector(activeAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _activateButton;
    
}

- (UILabel*)descLabel{
    
    if (!_descLabel) {
        
        _descLabel = [[UILabel alloc] init];
        
        _descLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
        
        _descLabel.textColor = [UIColor darkRedColor];

        _descLabel.textAlignment = UITextAlignmentLeft;
        
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *myEFubaoCellIdentifier = @"myIntegeralCellIdentifier";
	
	SNUITableViewCell *cell = (SNUITableViewCell*)[tableView dequeueReusableCellWithIdentifier:myEFubaoCellIdentifier];
	
	if(cell == nil){
		
		cell = [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myEFubaoCellIdentifier ];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor cellBackViewColor];
        cell.textLabel.textColor = [UIColor darkTextColor];
	}
    
	if (indexPath.row == 0) {
        //"Integeral"="云钻";
        cell.textLabel.text = L(@"Integeral");
        cell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",[UserCenter defaultCenter].userDiscountInfoDTO.achievement?[UserCenter defaultCenter].userDiscountInfoDTO.achievement:@"0",L(@"MyEBuy_Score")];
        cell.detailTextLabel.textColor = [UIColor colorWithRGBHex:0x999081];
        
    }else{
        //"Integeral_Status"="状态";
        cell.textLabel.text = L(@"Integeral_Status");
        cell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];

        cell.detailTextLabel.text =self.alertString;
        cell.detailTextLabel.textColor = [UIColor colorWithRGBHex:0x999081];

    }
    
	return cell;
}

@end
