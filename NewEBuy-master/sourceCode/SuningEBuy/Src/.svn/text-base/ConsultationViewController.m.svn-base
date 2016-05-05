//
//  ConsultationViewController.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ConsultationViewController.h"
#import "ConsultTableViewCell.h"
#import "ConsultationService.h"
#import "IWantconsultViewController.h"
#import "LoginViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define celltag 1000
@interface ConsultationViewController ()<ConsultationDelegate>
{
    UIImageView *arrowbtn;
    BOOL        istableshow;
    UIImageView *imgview;
    NSArray     *zixuntypearr;
    NSString    *stringname;
    NSString    *ismanyi;
    NSInteger   buttontag;
}
@property (nonatomic,strong)    ConsultListDTO *currentdto;
@property (nonatomic,strong)    ConsultationService *gezixuntype;
@property (nonatomic,strong)    ConsultationService *httpsend;
@property (nonatomic ,strong)   NSString  *modetype;
@property (nonatomic,strong)    UITableView    *table;
@property (nonatomic,strong)    UIButton       *backBtn;
@end

@implementation ConsultationViewController

- (void)dealloc
{
    _httpsend.delegate = nil;
    SERVICE_RELEASE_SAFELY(_httpsend);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.currentPage = 1;
        self.isLastPage = YES;
        istableshow = NO;
        _ismyconsult = NO;
        self.title = L(@"PageTitleMyConsultation");
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(commitconsultation) name:CONSULTATION
                                                   object:nil];
    }
    return self;
}

- (UILabel *)emptyLabel
{
    if (!_emptyLabel)
    {
        _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 320, 60)];
        _emptyLabel.backgroundColor = [UIColor clearColor];
        _emptyLabel.text = L(@"No_Data_Error");
        _emptyLabel.textColor = [UIColor grayColor];
        _emptyLabel.textAlignment = UITextAlignmentCenter;
        _emptyLabel.numberOfLines = 0;
        [self.tableView addSubview:_emptyLabel];
        [self.view bringSubviewToFront:self.table];
    }
    return _emptyLabel;
}

-(void)commitconsultation{
    NSString *isbook =_sendcondto.isbook?@"true":@"false";
    [self.httpsend SendConsultSatisfactionHttpRequest:_currentdto.articleId isbook:isbook
 isflag:ismanyi];
    
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
        _backBtn.backgroundColor = [UIColor clearColor];
        _backBtn.hidden = YES;
        [_backBtn addTarget:self action:@selector(typetableclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(UITableView *)table{
    if (!_table) {
        _table=[[UITableView alloc] initWithFrame:CGRectMake(10, 50, 160, 278)];
        
        [_table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
      
		[_table setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_table.scrollEnabled = NO;
		
		_table.userInteractionEnabled = YES;
		
		_table.delegate = self;
		
		_table.dataSource = self;
        
        _table.backgroundView = nil;
		
		_table.backgroundColor =[UIColor whiteColor];
        
        UIView *view = [UIView new];
        
        view.backgroundColor = [UIColor clearColor];
        
        imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop-1.png"]];
        imgview.frame=CGRectMake(10, 41, 160, 9);
        imgview.hidden = YES;
        _table.tableFooterView = view;
        _table.hidden=YES;
    }
    return _table;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat height = [[UIScreen mainScreen] bounds].size.height-20-44-36;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 36, 320, height)];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    UIView *contentView = self.view;
	
	CGRect frame = contentView.bounds;
//	frame.origin.y+=10;
//    frame.size.height-=10;
	self.tableView.frame = frame;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    zixuntypearr = [[NSArray alloc] initWithObjects:@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    _modelarray = [[NSArray alloc] initWithObjects:L(@"AllConsult"),L(@"ProductConsult"),L(@"StoreDelivery"),L(@"InvoiceWarranty"),L(@"PayMessage"),L(@"PromotionPrivilege"),L(@"Others"),nil];
    stringname = [_modelarray objectAtIndex:0];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.table];
    [self.view addSubview:imgview];
    _sendcondto.modeltype =@"4";
//    [self gettype];
    if (!isListLoaded) {
        [self refreshData];
    }
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];

}

-(void)typetableclick{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"121501", nil]];
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.3];
    arrowbtn.transform=CGAffineTransformMakeRotation(!istableshow?-M_PI:0);
    [self.table setHidden:istableshow];
    imgview.hidden = istableshow;
    [UIView commitAnimations];
    [self.backBtn setHidden:istableshow];
    istableshow=!istableshow;

}
-(void)wantconsult{
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"121502", nil]];
    if (istableshow) {
        [self typetableclick];
    }
    if ([_delegate respondsToSelector:@selector(ConsultationDelegate)])
    {
       
        [_delegate ConsultationDelegate];
    }
}
#pragma mark -
#pragma mark tableview delegate/datasource methods



-(float) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.table) {
        return 0;
    }
    if (section == 0 && !_ismyconsult) {
        return 48;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor whiteColor];
    if (section == 0 && !_ismyconsult) {
        arrowbtn = [[UIImageView   alloc] initWithFrame:CGRectMake(90, 22, 11, 6)];
        arrowbtn.image = [UIImage imageNamed:@"arrow_bottom_gray.png"];
            UIButton *arr = [[UIButton alloc] initWithFrame:CGRectMake(-10, 5, 120, 40)];
            [arr addTarget:self action:@selector(typetableclick) forControlEvents:UIControlEventTouchUpInside];
            arr.tag = 9000;
            arr.backgroundColor = [UIColor clearColor];
            [arr setTitle:stringname forState:UIControlStateNormal];
            arr.titleLabel.font = [UIFont systemFontOfSize:15];
            [arr setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [view   addSubview:arr];
       
        UIButton *wantconsult = [[UIButton alloc] initWithFrame:CGRectMake(230, 10, 80, 30)];
        [wantconsult setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [wantconsult setTitle:L(@"New advisory") forState:UIControlStateNormal];
        wantconsult.backgroundColor = [UIColor orange_Light_Color];
        [wantconsult addTarget:self action:@selector(wantconsult) forControlEvents:UIControlEventTouchUpInside];
        [view  addSubview:arrowbtn];
        [view addSubview:wantconsult];
        return view;

    }
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.table) {
        return 1;
    }
    int ismyconsulttag =_ismyconsult?0:1;
    if ([self hasMore])
    {
        return [self.consultlist count] + 1+ismyconsulttag;
//        return [self.consultlist count] + 1+(int)!_ismyconsult;
    }
//    if (self.consultlist.count==0) {
//        return 2;
//    }
//    return [self.consultlist count]+(int)!_ismyconsult;
    return [self.consultlist count]+ismyconsulttag;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.table == tableView) {
        return 7;
    }
    if (section == 0 && !_ismyconsult) {
        return 0;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int indext= _ismyconsult?0:1;
    if (self.table == tableView) {
        return 40;
    }
    if (indexPath.section == 0 &&!_ismyconsult) {
        return 0;
    }

    if ([self hasMore] && indexPath.section == [self.consultlist count]+indext) {
        return  48;
    }
    
    if(self.consultlist.count >= indexPath.section)
    {
        if (_ismyconsult) {
            MyConsultDTO *dto = [self.consultlist objectAtIndex:indexPath.section-indext];
            return [ConsultTableViewCell MyConsultheight:dto];
        }
        else{
            ConsultListDTO *dto = [self.consultlist objectAtIndex:indexPath.section-indext];
            
            return [ConsultTableViewCell height:dto];
        }
    }
//    if (self.consultlist.count==0) {
//        return 48;
//    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.table == tableView) {
        static NSString *MoreResultIdentify = @"currentcell";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MoreResultIdentify];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreResultIdentify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        cell.textLabel.text = [_modelarray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        return cell;

    }
    int indext= _ismyconsult?0:1;

    if ([self hasMore] && indexPath.section == [self.consultlist count]+indext)
    {
        static NSString *MoreResultIdentify = @"MoreResultIdentify";
		
		UITableViewMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:MoreResultIdentify];
		
		if (cell == nil)
        {
			cell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreResultIdentify];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor whiteColor];
            
            //            [cell setCoolBgViewWithCellPosition:CellPositionBottom];
            
			cell.title = L(@"Get More...");
            
            cell.animating = NO;
            
			return cell;
		}
        
        cell.title = L(@"Get More...");
        
		cell.animating = NO;
		
		return cell;
    }
    
    static NSString *appraisalIdentify=@"appraisalIdentify";
    
    ConsultTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:appraisalIdentify];
    
    if (cell == nil) {
        cell = [[ConsultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appraisalIdentify];
        cell.owner = self;
        cell.isbook = _sendcondto.isbook?@"true":@"false";
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = celltag +indexPath.section-1;
    if (!_ismyconsult) {
        ConsultListDTO *dto = [self.consultlist safeObjectAtIndex:indexPath.section-1];
        [cell setcellinit:dto];
    }
    else{
        MyConsultDTO *dto = [self.consultlist safeObjectAtIndex:indexPath.section];
        [cell setmyconsultcellinit:dto];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int indext= _ismyconsult?0:1;

    if (tableView == self.table) {
        _sendcondto.modeltype = [zixuntypearr objectAtIndex:indexPath.row];
        UIButton *arr = (UIButton *)[self.view viewWithTag:9000];
        stringname = [_modelarray objectAtIndex:indexPath.row];
        [arr setTitle:[_modelarray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [self typetableclick];
        [self refreshData];
        
    }
    if ([self hasMore] && [self.consultlist count] + indext== indexPath.section){

        [self loadMoreData];
    }
   
}



- (ConsultationService *)gezixuntype
{
    if (!_gezixuntype) {
        _gezixuntype = [[ConsultationService alloc] init];
        _gezixuntype.delegate = self;
    }
    return _gezixuntype;
}

- (ConsultationService *)httpsend
{
    if (!_httpsend) {
        _httpsend = [[ConsultationService alloc] init];
        _httpsend.delegate = self;
    }
    return _httpsend;
}

-(void)sendHttpRequest{
    if (!_ismyconsult) {
            [self.httpsend SendConsultlistHttpRequest:_sendcondto currentpage:currentPage];
    }
    else{
        [self displayOverFlowActivityView:L(@"Loading...") yOffset: -60];
        [self.httpsend SendMyConsultlistHttpRequest:currentPage];
    }
}

-(void)gettype{
    [self.gezixuntype SendConsultationType];
}
#pragma mark -
#pragma mark 下拉刷新和加载更多

- (void)refreshData
{
    [super refreshData];
    
    self.currentPage = 1;
    
    [self sendHttpRequest];
}

- (void)loadMoreData
{
    [super loadMoreData];
    
    [self startMoreAnimation:YES];
    
    [self sendHttpRequest];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        //        if (self.tableView.contentOffset.y < 0)
        //        {
        //            self.tableView.scrollEnabled = NO;
        //        }
        
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    /*判是否加载更多*/
    CGSize contentOffset = [self.tableView contentSize];
    
    CGRect bounds = [self.tableView bounds];
    
    if (scrollView.contentOffset.y + bounds.size.height >= contentOffset.height && contentOffset.height>=(self.view.frame.size.height-92)) {
        
        if([self hasMore]){
            [self loadMoreData];
        }
    }
}

-(NSMutableArray *)consultlist{
    if (!_consultlist) {
        _consultlist = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return _consultlist;
}

#pragma mark - service delegate

- (void)GetConsultListDelegate:(NSArray *)list error:(NSString *)error{
    //刷新下拉完成
    if (self.isFromHead)
    {
        [self refreshDataComplete];
    }
    else
    {
        [self loadMoreDataComplete];
    }
    if (!error) {
        if (list) {
            isListLoaded = YES;
            if (self.isFromHead)
            {
                [self.consultlist removeAllObjects];
                [self.consultlist addObjectsFromArray:list];
            }
            else
            {
                [self.consultlist addObjectsFromArray:list];
            }
            
            ConsultListDTO *dto = [self.consultlist lastObject];
            if (self.currentPage < [dto.totalcnt intValue])
            {
                self.isLastPage = NO;
                
                self.currentPage++;
            }
            else
            {
                self.isLastPage = YES;
            }
            [self.tableView reloadData];
            if (self.consultlist.count==0) {
                self.emptyLabel.hidden = NO;
            }
            else{
                self.emptyLabel.hidden = YES;

            }
        }
        else{
            [self presentSheet:L(@"NWRequestError") posY:50];
            isListLoaded = NO;

        }
    }
    else{
        [self presentSheet:error posY:50];
        isListLoaded = NO;

    }
}

-(void)GetConsultationTypeDelegate:(BOOL)issuccess error:(NSString *)error list:(NSArray *)list{
    if (issuccess) {
        _modelarray = [[NSArray alloc] initWithArray:list];
        [self.table reloadData];
    }
    else{
        if (!error) {
            [self presentSheet:L(@"NWRequestError") posY:50];
        }
        else{
            [self presentSheet:error posY:50];
        }
    }
}


-(void)sendmanyi:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag<7000) {
        ismanyi=@"true";
    }
    NSInteger tag = btn.tag-3000;
    buttontag =btn.tag;
    _currentdto = [self.consultlist objectAtIndex:tag];
    if ([_logdelegate respondsToSelector:@selector(loginViewload:)])
    {
        [_logdelegate loginViewload:nil];
    }


}

-(void)sendunmanyi:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag>=7000) {
        ismanyi=@"false";
    }
    NSInteger tag = btn.tag-7000;
    buttontag =btn.tag;
    _currentdto = [self.consultlist objectAtIndex:tag];
    if ([_logdelegate respondsToSelector:@selector(loginViewload:)])
    {
        [_logdelegate loginViewload:nil];
    }
    
}


- (void)GetConsultNumDelegate:(BOOL)issuccess error:(NSString *)error ConsultDTO:(ConsultNumDetailsDTO *)dto{
    if (issuccess) {
        UIButton *btn = (UIButton *)[self.tableView viewWithTag:buttontag];
        if (btn.tag>=7000) {
            int unuse =[_currentdto.unusefulcount intValue]+1;
            [btn setTitle:[NSString stringWithFormat:@"%@(%d)",L(@"DisSatisfaction"),unuse] forState:UIControlStateNormal];
            _currentdto.unusefulcount=[NSString stringWithFormat:@"%d",unuse];
        }
        else{
            int use =[_currentdto.usefulcount intValue]+1;
            [btn setTitle:[NSString stringWithFormat:@"%@(%d)",L(@"Satisfaction"),[_currentdto.usefulcount intValue]+1] forState:UIControlStateNormal];
            _currentdto.usefulcount=[NSString stringWithFormat:@"%d",use];

        }
        [self.tableView reloadData];
    }
    else{
        
    }
    
}

-(void)GetMyConsultDelegate:(NSArray *)consultnum error:(NSString *)error{
    //刷新下拉完成
    [self removeOverFlowActivityView];
    if (self.isFromHead)
    {
        [self refreshDataComplete];
    }
    else
    {
        [self loadMoreDataComplete];
    }
    if (!error) {
        if (consultnum) {
            isListLoaded = YES;
            if (self.isFromHead)
            {
                [self.consultlist removeAllObjects];
                [self.consultlist addObjectsFromArray:consultnum];
            }
            else
            {
                [self.consultlist addObjectsFromArray:consultnum];
            }
            
            ConsultListDTO *dto = [self.consultlist lastObject];
            if (self.currentPage < [dto.totalcnt intValue])
            {
                self.isLastPage = NO;
                
                self.currentPage++;
            }
            else
            {
                self.isLastPage = YES;
            }
            [self.tableView reloadData];
            if (self.consultlist.count==0) {
                self.emptyLabel.hidden = NO;
            }
            else{
                self.emptyLabel.hidden = YES;
                
            }
        }
        else{
            [self presentSheet:L(@"NWRequestError") posY:50];
            isListLoaded = NO;
            
        }
    }
    else{
        [self presentSheet:error posY:50];
        isListLoaded = NO;
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
