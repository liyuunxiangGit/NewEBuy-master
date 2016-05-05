//
//  LotteryProtocolViewController.m
//  SuningEBuy
//
//  Created by david david on 12-7-10.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LotteryProtocolViewController.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

@interface LotteryProtocolViewController()

- (CGFloat)getHeiht:(NSInteger)section;

@property(nonatomic,strong)UITableView  *lotteryTableView;
@property(nonatomic,strong)UIImageView  *tabBackground;

@end

@implementation LotteryProtocolViewController

@synthesize segCate = _segCate;

@synthesize gameRuleArr = _gameRuleArr;

@synthesize lotteryTableView = _lotteryTableView;

@synthesize tabBackground = _tabBackground;
@synthesize gameName = _gameName;

- (void)dealloc {
    TT_RELEASE_SAFELY(_gameName);
    TT_RELEASE_SAFELY(_segCate);
    TT_RELEASE_SAFELY(_tabBackground);
    TT_RELEASE_SAFELY(_lotteryTableView);
    
}
- (id)initWithNameData:(NSString*)aName
{
    self = [super init];
    if (self)
    {
        self.title = L(@"Users purchasing agreement");
        _gameName = aName;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"virtual_lottery"),aName,self.title];
    }
    return self;
}
- (id)init {
    
    self = [super init];
    
    if (self)
    {
        self.isLotteryController = YES;
    }
    return self;
}

-(void)loadView{
    
    [super loadView];
    
    normalInfo_ = @"";
    
    
    selectedSegmentIndex = 0;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LotteryProtocol"ofType:@"plist"];
    
    _gameRuleArr = [[NSArray alloc]initWithContentsOfFile:path];
    
    DLog(@"%d", [self.gameRuleArr count]);
    
    
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
        
        if (!IOS7_OR_LATER)
        {
            _tabBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rule_background.png"]];
             _tabBackground.backgroundColor = [UIColor clearColor];
        }
        else
        {
             _tabBackground.backgroundColor = [UIColor colorWithRGBHex:0xf2f2f2];
        }
        
        [self.view addSubview:_tabBackground];
    }
    
    return _tabBackground;
}


-(LotteryRuleTopSelectView *)segCate{
    
    if (!_segCate) {
        
        _segCate = [[LotteryRuleTopSelectView alloc] initWithFrame:CGRectMake(10, 10, 300, 35)];
        
        _segCate.delegate = self;
        
        NSArray *array = [[NSArray alloc] initWithObjects:L(@"Users purchasing agreement"),L(@"User Information Security Agreement"), nil];
        
        _segCate.titleArr = array;
        
        
        [_segCate setButtonTitle];
        
        _segCate.backgroundColor = [UIColor clearColor];
        
    }
    
    return _segCate;
    
}

- (void)didSelectedOKWithIndex:(int)index{
    
    
    selectedSegmentIndex = index;
        
    if (index == 0) {
        
        self.title = L(@"Users purchasing agreement");
    }else{
        
        self.title = L(@"User Information Security Agreement");
    }
    self.pageTitle = [NSString stringWithFormat:@"%@-%@-%@",L(@"virtual_lottery"),_gameName,self.title];
    [self.lotteryTableView reloadData];

    [self.lotteryTableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

}


- (CGFloat)getHeiht:(NSInteger)section{
    
    NSMutableAttributedString *ruleStr = nil  ;
    
    if (selectedSegmentIndex == 0) {
        
        ruleStr = [[NSMutableAttributedString alloc] initWithString:[[[self.gameRuleArr objectAtIndex:0] allValues] objectAtIndex:0]];
        
    }else{
        
        ruleStr = [[NSMutableAttributedString alloc] initWithString:[[[self.gameRuleArr objectAtIndex:section] allValues] objectAtIndex:0]];
        
    }
    
    [ruleStr setFont:[UIFont systemFontOfSize:14]];
    
    CGSize mainContendSize = [ruleStr sizeConstrainedToSize:CGSizeMake(280, 3000)];
    
    CGFloat height = mainContendSize.height;
    
    return height+10;
    
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
//
//    return title;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 25)];
    
    //    view.backgroundColor = RGBCOLOR(233, 231, 219);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 300, 25)];
    if (IOS7_OR_LATER)
    {
        label.backgroundColor = [UIColor colorWithRGBHex:0xf2f2f2];
    }
    else
    {
        label.backgroundColor = RGBCOLOR(233, 231, 219);
    }
    
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
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        OHAttributedLabel *textLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
        textLabel.tag = 1001;
        
        textLabel.backgroundColor = [UIColor clearColor];
        if (IOS7_OR_LATER)
        {
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.backgroundColor = [UIColor colorWithRGBHex:0xf2f2f2];
        }
        [cell.contentView addSubview:textLabel];
        
        TT_RELEASE_SAFELY(textLabel);
        
    }
    
    OHAttributedLabel *textLabel = (OHAttributedLabel *)[cell viewWithTag:1001];
    
    if (selectedSegmentIndex == 0) {
        
        textLabel.frame = CGRectMake(10, 0, 280, [self getHeiht:0]);
        
    }else{
        
        textLabel.frame = CGRectMake(10, 0, 280, [self getHeiht:indexPath.section +1 ]);
        
    }
    
    
    NSMutableAttributedString *attributeStr = nil;
    
    if (selectedSegmentIndex == 0) {
        
        NSDictionary *dic = [self.gameRuleArr objectAtIndex:0];
        
        attributeStr = [[NSMutableAttributedString alloc] initWithString:[[dic allValues] objectAtIndex:0]];
        
        
    }else{
        
        NSDictionary *dic = [self.gameRuleArr objectAtIndex:indexPath.section+1];
        
        attributeStr = [[NSMutableAttributedString alloc] initWithString:[[dic allValues] objectAtIndex:0]];
        
    }
    
    [attributeStr setFont:[UIFont systemFontOfSize:14]];
    [attributeStr setTextColor:[UIColor darkGrayColor]];
    [attributeStr setTextAlignment:UITextAlignmentLeft lineBreakMode:CTLineBreakModeFromUILineBreakMode(UILineBreakModeCharacterWrap)];
    textLabel.attributedText = attributeStr;
    
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
		_lotteryTableView.backgroundColor =[UIColor clearColor];
        
        [self.view addSubview:_lotteryTableView];
        
	}
	
	return _lotteryTableView;
    
}

@end