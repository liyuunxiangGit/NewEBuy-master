//
//  LotteryRuleViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-7-4.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import "LotteryRuleViewController.h"

@interface LotteryRuleViewController()

- (CGFloat)getHeiht:(NSInteger)section;

@property(nonatomic,strong)UITableView  *lotteryTableView;
@property(nonatomic,strong)UIImageView  *tabBackground;

@end

@implementation LotteryRuleViewController

@synthesize segCate = _segCate;

@synthesize lotteryType;

@synthesize gameRuleArr = _gameRuleArr;

@synthesize lotteryTableView = _lotteryTableView;

@synthesize tabBackground = _tabBackground;



- (void)dealloc {
    
    TT_RELEASE_SAFELY(_tabBackground);
    
    TT_RELEASE_SAFELY(_segCate);
    
    TT_RELEASE_SAFELY(_lotteryTableView);
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        self.isLotteryController = YES;
        selectedSegmentIndex = 0;
    }
    return self;
}

-(void)loadView{
    
    [super loadView];
    
    normalInfo_ = @"";
    
    switch (self.lotteryType) {
            
        case eColorBall:
        {
            self.title = L(@"DoubleColor ball play introduces");
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"GameRule"ofType:@"plist"];
            
            _gameRuleArr = [[NSArray alloc]initWithContentsOfFile:path];
            
            DLog(@"%d", [self.gameRuleArr count]);
            
        }
            break;
            
        case eBigLottery:{
            
            self.title = L(@"BigLotto play introduces");
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"GameRuleBigLottery"ofType:@"plist"];
            
            _gameRuleArr = [[NSArray alloc]initWithContentsOfFile:path];
            
            DLog(@"%d", [self.gameRuleArr count]);
            
        }
            break;
        case welfare3D:{
            
            self.title = L(@"Welfare3D play introduces");
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"GameRuleWelfare3D"ofType:@"plist"];
            
            _gameRuleArr = [[NSArray alloc]initWithContentsOfFile:path];
            
            DLog(@"%d", [self.gameRuleArr count]);
            
        }
            break;
        case sevenLe:
        {
            self.title = L(@"SevenLe play introduces");
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"GameRuleSevenLe"ofType:@"plist"];
            
            _gameRuleArr = [[NSArray alloc]initWithContentsOfFile:path];
            
        }
            break;
        case sevenStars:
        {
            self.title = L(@"SevenStars play introduces");
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"GameRuleSevenStars"ofType:@"plist"];
            
            _gameRuleArr = [[NSArray alloc]initWithContentsOfFile:path];
        }
            break;
        case ArrangeThree:          //排列三
        {
            self.title = L(@"Arrange in Three play introduces");
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"GameRuleArrangeThree" ofType:@"plist"];
            
            _gameRuleArr = [[NSArray alloc] initWithContentsOfFile:path];
        }
            break;
        case ArrangeFive:           //排列五
        {
            self.title = L(@"Arrange in Five play introduces");
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"GameRuleArrangeFive" ofType:@"plist"];
            
            _gameRuleArr = [[NSArray alloc] initWithContentsOfFile:path];
        }
            break;
        default:
            break;
    }
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),self.title];
    
    [self.view addSubview:self.segCate];
	
    self.tabBackground.frame = CGRectMake(10, self.segCate.bottom + 15 , 300, self.view.frame.size.height-self.segCate.bottom - 90);
    self.lotteryTableView.frame = CGRectMake(10, self.segCate.bottom + 15 , 300, self.view.frame.size.height-self.segCate.bottom - 107);
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (UIImageView *)tabBackground{
    
    if (!_tabBackground) {
        
        _tabBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rule_background.png"]];
        
        _tabBackground.backgroundColor = [UIColor clearColor];
        
       // [self.view addSubview:_tabBackground];
    }
    
    return _tabBackground;
}


-(LotteryRuleTopSelectView *)segCate{
    
    if (!_segCate) {
        
        _segCate = [[LotteryRuleTopSelectView alloc] initWithFrame:CGRectMake(10, 10, 300, 35)];
        
        _segCate.delegate = self;
        
        NSArray *array = [[NSArray alloc] initWithObjects:L(@"Disclaimer"),L(@"Rules of play"), nil];
        
        _segCate.titleArr = array;
        
        
        [_segCate setButtonTitle];
        
        _segCate.backgroundColor = [UIColor clearColor];
        
    }
    
    return _segCate;
    
}

- (void)didSelectedOKWithIndex:(int)index{
    
    selectedSegmentIndex = index;
    
    [self.lotteryTableView reloadData];
    
}


- (CGFloat)getHeiht:(NSInteger)section{
    
    NSString *ruleStr = nil  ;
    
    if (selectedSegmentIndex == 0) {
        
        ruleStr = [[[self.gameRuleArr objectAtIndex:0] allValues] objectAtIndex:0];
        
    }else{
        
        ruleStr = [[[self.gameRuleArr objectAtIndex:section] allValues] objectAtIndex:0];
        
    }
    UIFont *cellFont =[UIFont systemFontOfSize:14];
    
    CGSize mainContendSize = [ruleStr heightWithFont:cellFont width:280 linebreak:UILineBreakModeCharacterWrap];
    
    CGFloat height = mainContendSize.height;
    
    return height;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (selectedSegmentIndex == 0) {
        
        return [self getHeiht:0];
        
    }else{
        
        return [self getHeiht:indexPath.section +1];
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (selectedSegmentIndex == 0) {
        
        return 1;
        
    }else{
        
        DLog(@"%d",  [self.gameRuleArr count]-1);
        
        return [self.gameRuleArr count]-1;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//
//    NSString *title = nil;
//
//    if (selectedSegmentIndex == 0) {
//
//        title = [[[self.gameRuleArr objectAtIndex:0] allKeys]objectAtIndex:0];
//
//    }else{
//
//        title = [[[self.gameRuleArr objectAtIndex:section+1] allKeys] objectAtIndex:0];
//
//    }
//    return title;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 25)];
    
    //    view.backgroundColor = RGBCOLOR(233, 231, 219);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 290, 25)];
    
    label.backgroundColor = RGBCOLOR(233, 231, 219);
    
    label.textColor = [UIColor darkGrownColor];
    
    if (selectedSegmentIndex == 0) {
        
        label.text = [[[self.gameRuleArr objectAtIndex:0] allKeys]objectAtIndex:0];
        
    }else{
        
        label.text = [[[self.gameRuleArr objectAtIndex:section+1] allKeys] objectAtIndex:0];
        
    }
    
    [view addSubview:label];
    
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"ruleCell"]  ;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ruleCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *textLabel = [[UILabel alloc] init];
        
        textLabel.tag = 1001;
        
        textLabel.font = [UIFont systemFontOfSize:14];
        
        textLabel.textColor = [UIColor darkGrayColor];
        
        textLabel.textAlignment = UITextAlignmentLeft;
        
        textLabel.numberOfLines = 0;
        
        textLabel.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:textLabel];
        
        TT_RELEASE_SAFELY(textLabel);
        
    }
    
    UILabel *textLabel = (UILabel *)[cell viewWithTag:1001];
    
    if (selectedSegmentIndex == 0) {
        
        textLabel.frame = CGRectMake(10, 0, 280, [self getHeiht:0]);
        
    }else{
        
        textLabel.frame = CGRectMake(10, 0, 280, [self getHeiht:indexPath.section +1 ]);
        
    }
    
    
    if (selectedSegmentIndex == 0) {
        
        NSDictionary *dic = [self.gameRuleArr objectAtIndex:0];
        
        textLabel.text = [[dic allValues] objectAtIndex:0];
        
        
    }else{
        
        NSDictionary *dic = [self.gameRuleArr objectAtIndex:indexPath.section+1];
        
        textLabel.text = [[dic allValues] objectAtIndex:0];
        
    }
    
	return cell;
}


- (UITableView *)lotteryTableView{
    
    if(!_lotteryTableView){
		
        _lotteryTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStylePlain];
		
		[_lotteryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_lotteryTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_lotteryTableView.scrollEnabled = YES;
		
		_lotteryTableView.userInteractionEnabled = YES;
		
		_lotteryTableView.delegate =self;
		
		_lotteryTableView.dataSource =self;
        
        _lotteryTableView.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_lotteryTableView];
        
	}
	
	return _lotteryTableView;
    
}


@end
