//
//  GBFirstCategoryViewController.m
//  SuningEBuy
//
//  Created by shasha on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBFirstCategoryViewController.h"
#import "GBCategoryDTO.h"
#import "GBHeadNodeDTO.h"
#import "GBSearchFilterDTO.h"

#define kViewLeft 50
#define kFirstCateWidth  120
#define kSecondCateWidth 170

@interface GBFirstCategoryViewController()

@property (nonatomic, strong) NSMutableArray *categoryArr;
@property (nonatomic, strong) NSMutableArray *firstCateArr;
@property (nonatomic, strong) NSMutableArray  *secondCateArr;
@property (nonatomic, strong) GBSearchFilterDTO *businessFilter; //酒店
@property (nonatomic, strong) GBSearchFilterDTO *cityFilter; //旅游
@property (nonatomic, strong) UITableView *secondCateTableView;
@property (nonatomic, assign) NSInteger  selectIndex;

@property (nonatomic)NSInteger secondIndex;

@end


@implementation GBFirstCategoryViewController

@synthesize paramDTO;
@synthesize delegate = _delegate;
@synthesize categoryArr = _categoryArr;
@synthesize firstCateArr = _firstCateArr;
@synthesize secondCateArr = _secondCateArr;
@synthesize businessFilter = _businessFilter;
@synthesize cityFilter = _cityFilter;
@synthesize secondCateTableView = _secondCateTableView;
@synthesize selectIndex = _selectIndex;

- (void)dealloc
{
    if (IOS5_OR_LATER) {
        [self removeObserver:self forKeyPath:@"selectIndex" context:nil];
    }
    else
    {
        [self removeObserver:self forKeyPath:@"selectIndex"];
    }
    
    TT_RELEASE_SAFELY(_categoryArr);
    TT_RELEASE_SAFELY(_firstCateArr);
    TT_RELEASE_SAFELY(_secondCateArr);
    TT_RELEASE_SAFELY(_businessFilter);
    TT_RELEASE_SAFELY(_cityFilter);
    TT_RELEASE_SAFELY(_secondCateTableView);
    TT_RELEASE_SAFELY(paramDTO);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        [self addObserver:self forKeyPath:@"selectIndex" options:NSKeyValueObservingOptionNew context:nil];
        self.hasNav = NO;
        
        self.secondIndex = -1;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self selectFirstCateChanged];
    
}

- (void)selectFirstCateChanged{
    if (self.firstCateArr.count == 0) {
        return;
    }
    
    GBHeadNodeDTO *selectCateDTO = [self.firstCateArr objectAtIndex:self.selectIndex];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (GBHeadNodeDTO *node in selectCateDTO.children) {
        [tempArr addObject:node];
    }
    
    self.secondCateArr = tempArr;
    TT_RELEASE_SAFELY(tempArr);
    
    [self.tableView reloadData];
    [self.secondCateTableView reloadData];
}

- (void)setFirstCategoryList:(NSMutableArray *)firstCateList{
    if (_categoryArr != firstCateList) {
        TT_RELEASE_SAFELY(_categoryArr);
        _categoryArr = firstCateList;
        
        NSMutableArray *tempFirstArr = [[NSMutableArray alloc] init];
        NSMutableArray *tempBusinessArr = [[NSMutableArray alloc] init];
        NSMutableArray *tempCityArr = [[NSMutableArray alloc] init];
        
        for (int num=0; num<_categoryArr.count; num++) {
            
            GBSearchFilterDTO *searchFilter = (GBSearchFilterDTO *)[_categoryArr objectAtIndex:num];
            
            if ([searchFilter.fieldName isEqualToString:@"groupIdCombination"]) {  //一级目录
                for (NSDictionary *dic in searchFilter.values) {
                    GBHeadNodeDTO *dto = [[GBHeadNodeDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    [tempFirstArr addObject:dto];
                    TT_RELEASE_SAFELY(dto);
                }
            }
            
            else if ([searchFilter.fieldName isEqualToString:@"businessIdCombination"]) { //酒店对应的二级目录
                for (NSDictionary *dic in searchFilter.values) {
                    GBHeadNodeDTO *dto = [[GBHeadNodeDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    [tempBusinessArr addObject:dto];
                    TT_RELEASE_SAFELY(dto);
                }
            }
            
            else if ([searchFilter.fieldName isEqualToString:@"cityIdCombination"]) { //旅游对应的二级目录
                for (NSDictionary *dic in searchFilter.values) {
                    GBHeadNodeDTO *dto = [[GBHeadNodeDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    [tempCityArr addObject:dto];
                    TT_RELEASE_SAFELY(dto);
                }
            }
        }
        
        for (int num=0; num<tempFirstArr.count; num++) { 
            GBHeadNodeDTO *node = [tempFirstArr objectAtIndex:num];
            if ([node.idNode isEqualToString:@"1006"]) { //旅游
                node.children = tempCityArr;
            }
            else if ([node.idNode isEqualToString:@"1007"]) { //酒店
                node.children = tempBusinessArr;
            }
            else
            {
                NSMutableArray *tempArr = [[NSMutableArray alloc] init];
                    for (NSDictionary *dic in node.children) {
                        GBHeadNodeDTO *dto = [[GBHeadNodeDTO alloc] init];
                        [dto encodeFromDictionary:dic];
                        [tempArr addObject:dto];
                        TT_RELEASE_SAFELY(dto);
                    }
                node.children = tempArr;
                TT_RELEASE_SAFELY(tempArr);
            }
            
            //二级目录手动添加“全部”
            GBHeadNodeDTO *defaultDto = [[GBHeadNodeDTO alloc] init];
            if ([node.idNode isEqualToString:@"1006"] || [node.idNode isEqualToString:@"1007"]) {
                defaultDto.idNode = @"";
            }
            else
            {
                defaultDto.idNode = node.idNode;
            }
            defaultDto.name = L(@"All");
            
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            [tempArr addObject:defaultDto];
            [tempArr addObjectsFromArray:node.children];
            node.children = tempArr;
            TT_RELEASE_SAFELY(tempArr);
            TT_RELEASE_SAFELY(defaultDto);
        }
        
        //一级目录手动添加“全部”
        GBHeadNodeDTO *dto = [[GBHeadNodeDTO alloc] init];
        dto.name = L(@"GBAllCategories");
        dto.idNode = @"";
        
        [tempFirstArr insertObject:dto atIndex:0];
        self.firstCateArr = tempFirstArr;
        TT_RELEASE_SAFELY(dto);
        TT_RELEASE_SAFELY(tempFirstArr);
        TT_RELEASE_SAFELY(tempBusinessArr);
        TT_RELEASE_SAFELY(tempCityArr);
        
        self.selectIndex = 0;
        [self selectFirstCateChanged];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self refreshTable];
}

-(void)refreshTable{
    
    
    float orginIndex = 0;
    if (IOS7_OR_LATER)
    {
        orginIndex = 20;
    }
    
    if (self.selectIndex == 0) {
        
        CGRect frame = self.view.frame;
        frame.origin.y = orginIndex;
        frame.origin.x = kViewLeft;
        frame.size.width = 320 - kViewLeft;
        
        frame.size.height = frame.size.height;//- 20;
        // frame.size.width = kFirstCateWidth;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.tableView.frame = frame;
            CGRect secFrame = self.secondCateTableView.frame;
            
            secFrame.origin.x = 320;
            
            self.secondCateTableView.frame = secFrame;
        }];
        
        
        
        
        //self.secondCateTableView.hidden = YES;
    }
    else{
        
        CGRect frame = self.view.frame;
        frame.origin.y = orginIndex;
        frame.origin.x = kViewLeft;
        
        frame.size.height = frame.size.height;//- 20;
        frame.size.width = kFirstCateWidth;
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.tableView.frame = frame;
            
            CGRect secFrame = self.secondCateTableView.frame;
            
            secFrame.origin.x = kFirstCateWidth + kViewLeft ;
            
            self.secondCateTableView.frame = secFrame;
        }];
        
       // self.tableView.frame = frame;
        
        frame.size.width = kSecondCateWidth;
        frame.origin.x = self.tableView.right;
        //self.secondCateTableView.frame = frame;
        
        
      //  self.secondCateTableView.hidden = NO;
    }
}
- (void)loadView{
    [super loadView];
    
    //[self loadNavigationBarView];]
    
    self.view.frame = [self visibleBoundsShowNav:NO showTabBar:NO];
    
    float orginIndex = 0;
    if (IOS7_OR_LATER)
    {
        orginIndex = 20;
    }
    
    //self.view.backgroundColor = [UIColor darkGrayColor];
    
    CGRect frame = self.view.frame;
    frame.origin.y = orginIndex;
    frame.origin.x = kViewLeft;
    frame.size.width = 320 - kViewLeft;
    
    frame.size.height = frame.size.height;//- 20;
    frame.size.width = kFirstCateWidth;
    self.tableView.frame = frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    frame.size.width = kSecondCateWidth;
    frame.origin.x = self.tableView.right;
    self.secondCateTableView.frame = frame;
    self.secondCateTableView.backgroundColor = [UIColor clearColor];//RGBCOLOR(236, 236, 236);
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.secondCateTableView];
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),L(@"GBGroupFilter")];
}

- (void)loadNavigationBarView{
    UILabel *titileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320-kViewLeft, 44)];
    
    titileLable.text= L(@"GBGroupFilter");
    titileLable.font = [UIFont boldSystemFontOfSize:20];
    titileLable.textAlignment = UITextAlignmentCenter;
    titileLable.backgroundColor = [UIColor clearColor];
    titileLable.textColor = [UIColor flatTextColor];
    titileLable.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    UIImageView  *titleImageViewNew = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:kNavigationBarBackgroundImage];
    UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
    titleImageViewNew.image=streImage;
    titleImageViewNew.frame=CGRectMake(kViewLeft, 0, 320 - kViewLeft, 44);
    [titleImageViewNew addSubview:titileLable];
    [self.view addSubview:titleImageViewNew];
    TT_RELEASE_SAFELY(titileLable);
    TT_RELEASE_SAFELY(titleImageViewNew);
}

#pragma mark - TableView Delegate Datasource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.tableView) {
        if (!IsArrEmpty(self.firstCateArr)) {
            return [self.firstCateArr count];
        }else{
            return 0;
        }
    }else{
        if (!IsArrEmpty(self.secondCateArr)) {
            return [self.secondCateArr count];
        }else{
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView == self.secondCateTableView) {
        
        return 30;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell = nil;
    
    if (self.tableView == tableView) {
        cell = [self categoryCellForRowAtRow:row ofCateList:self.firstCateArr tableView:tableView];
        cell.textLabel.textColor = [UIColor light_Black_Color];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
       // cell.textLabel.shadowColor = [UIColor lightGrayColor];
        
        UILabel *selectedImageView = (UILabel *)[cell.contentView viewWithTag:102];
        
        if (self.selectIndex == row) {
            
            //cell.contentView.backgroundColor = RGBCOLOR(236, 236, 236);
            if (!selectedImageView) {
                selectedImageView = [[UILabel alloc] init];
                selectedImageView.frame = CGRectMake(-1, 0, 3, 40);
                selectedImageView.backgroundColor = [UIColor orange_Light_Color];
                selectedImageView.tag = 102;
                [cell.contentView addSubview:selectedImageView];
                TT_RELEASE_SAFELY(selectedImageView);
            }
        }else{
            //cell.contentView.backgroundColor = [UIColor whiteColor];
            [selectedImageView removeFromSuperview];
        }
        
        UILabel *seperateLine = (UILabel *)[cell.contentView viewWithTag:101];
        
        if (!seperateLine) {
            seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, self.tableView.frame.size.width, 1)];
            seperateLine.backgroundColor = RGBCOLOR(214, 214, 214);
            seperateLine.tag = 101;
            [cell.contentView addSubview:seperateLine];
            TT_RELEASE_SAFELY(seperateLine);
        }
        
    }else{
        
        cell = [self categoryCellForRowAtRow:row ofCateList:self.secondCateArr tableView:tableView];
        
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.backgroundColor = [UIColor clearColor];
        
         UIView *v =[[UIView alloc] init];
         cell.backgroundView = v;
        if (self.secondIndex == indexPath.row) {
            
           cell.textLabel.textColor = [UIColor whiteColor];
            v.backgroundColor = [UIColor orange_Light_Color];
            
        }
        else{
            cell.textLabel.textColor = [UIColor dark_Gray_Color];
            v.backgroundColor = [UIColor clearColor];
        }
        

        
        UILabel *seperateLine = (UILabel *)[cell.contentView viewWithTag:103];
        
        if (!seperateLine) {
            seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, self.secondCateTableView.frame.size.width, 1)];
            seperateLine.backgroundColor = RGBCOLOR(214, 214, 214);
            seperateLine.tag = 103;
            [cell.contentView addSubview:seperateLine];
            TT_RELEASE_SAFELY(seperateLine);
        }
    }
    
    return cell;
}

- (UITableViewCell *)categoryCellForRowAtRow:(NSInteger)row ofCateList:(NSArray *)categoryList tableView:(UITableView *)tableView{
    if (!IsArrEmpty(categoryList)&&[categoryList count]>row) {
        GBHeadNodeDTO *dto = [categoryList objectAtIndex:row];
        NSString *categoryName = dto.name;
        
        static NSString *categoryIdentifier = @"categoryIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.text = categoryName;
       // cell.textLabel.shadowColor = [UIColor whiteColor];
       // cell.textLabel.shadowOffset = CGSizeMake(1, 1);
        cell.textLabel.textAlignment =UITextAlignmentCenter;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        return cell;
        
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        NSInteger row = indexPath.row;
        self.selectIndex = row;
        self.secondIndex = -1;
        [self refreshTable];
        
        if (row == 0) {
            self.paramDTO.categoryId = @"";
            self.paramDTO.pageNumber = @"1";
            self.paramDTO.cityId = [Config currentConfig].gbDefaultCityId;
            if ([self.delegate respondsToSelector:@selector(categoryChangedWithCityName:)]) {
                [self.delegate categoryChangedWithCityName:[Config currentConfig].gbDefaultCityName];
            
                //[self.navigationController popViewControllerAnimated:YES];
            }
            return;
        }
    }else {
        
        self.secondIndex = indexPath.row;
        [self.secondCateTableView reloadData];
        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//        cell.textLabel.textColor = [UIColor whiteColor];
        
        NSInteger row = indexPath.row;
        if (!IsArrEmpty(self.firstCateArr)&&[self.firstCateArr count]>self.selectIndex) {
            GBHeadNodeDTO *firstCateDTO = [self.firstCateArr objectAtIndex:self.selectIndex];
            if ([firstCateDTO.idNode isEqualToString:@"1007"] || [firstCateDTO.idNode isEqualToString:@"1006"]) {
                GBHeadNodeDTO *firstCateDTO = [self.firstCateArr objectAtIndex:self.selectIndex];
                self.paramDTO.categoryId = firstCateDTO.idNode;
                if (!IsArrEmpty(self.secondCateArr)&&[self.secondCateArr count]>row) {
                    GBHeadNodeDTO *secondCateDTO = [self.secondCateArr objectAtIndex:row];
                    self.paramDTO.cityId = secondCateDTO.idNode;
                    self.paramDTO.pageNumber = @"1";
                    if ([self.delegate respondsToSelector:@selector(categoryChangedWithCityName:)]) {
                        if (IsStrEmpty(self.paramDTO.cityId)) {
                            [self.delegate categoryChangedWithCityName:@""]; //全部
                        }
                        else {
//                            [self.delegate categoryChangedWithCityName:secondCateDTO.name];
                            [self.delegate categoryChangedWithCityName:@""];
                        }
                    }
                }else{
                    //do Nothing
                    return;
                }
            }
            else
            {
                if (!IsArrEmpty(self.secondCateArr)&&[self.secondCateArr count]>row) {
                    GBHeadNodeDTO *secondCateDTO = [self.secondCateArr objectAtIndex:row];
                    self.paramDTO.categoryId = secondCateDTO.idNode;
                    self.paramDTO.pageNumber = @"1";
                    self.paramDTO.cityId = [Config currentConfig].gbDefaultCityId;
                    if ([self.delegate respondsToSelector:@selector(categoryChangedWithCityName:)]) {
                        [self.delegate categoryChangedWithCityName:[Config currentConfig].gbDefaultCityName];
                        
                       // [self.navigationController popViewControllerAnimated:YES];
                    }
                }else{
                    //do Nothing
                    return;
                }
            }
        }
        else{
            //do Nothing
            return;
        }
    }
}

- (UITableView *)secondCateTableView{
	
	if(!_secondCateTableView){
		
		_secondCateTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                            style:UITableViewStylePlain];
		
		[_secondCateTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_secondCateTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_secondCateTableView.scrollEnabled = YES;
		
		_secondCateTableView.userInteractionEnabled = YES;
		
		_secondCateTableView.delegate =self;
		
		_secondCateTableView.dataSource =self;
		
		_secondCateTableView.backgroundColor =[UIColor clearColor];
        
        _secondCateTableView.backgroundView = nil;
	}
	
	return _secondCateTableView;
}

- (NSMutableArray *)firstCateArr
{
    if (!_firstCateArr) {
        _firstCateArr = [[NSMutableArray alloc] init];
    }
    return _firstCateArr;
}

@end