//
//  SNDropDownMenuViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SNDropDownMenuViewController.h"

@interface SNDropDownMenuViewController() {
    
}

@property (nonatomic, strong) NSArray  *sectionRowCountArr;

@end


@implementation SNDropDownMenuViewController
@synthesize menuDataArr=_menuDataArr ;
@synthesize sectionRowCountArr = _sectionRowCountArr;

@synthesize menuBackgroudImage= _menuBackgroudImage;
@synthesize menuTableViewBackImage=_menuTableViewBackImage;
@synthesize menuCellBackImage=_menuCellBackImage;
@synthesize menuTableViewOffset= _menuTableViewOffset;
@synthesize menuAnimation=_menuAnimation;
@synthesize delegate=_delegate;
@synthesize dropDownMenuView = _dropDownMenuView;
@synthesize dropDownMenuViewStyle = _dropDownMenuViewStyle;
@synthesize superView;

- (void)dealloc {
    TT_RELEASE_SAFELY(_menuDataArr);
    TT_RELEASE_SAFELY(_sectionRowCountArr);
    TT_RELEASE_SAFELY(_menuBackgroudImage);
    TT_RELEASE_SAFELY(_menuCellBackImage);
    TT_RELEASE_SAFELY(_menuTableViewBackImage);
    TT_RELEASE_SAFELY(_dropDownMenuView);
    _delegate = nil;
}
- (id)initWithSuperView:(UIView *)view withFrame:(CGRect)Frame{

    self = [super init];
    if (self) {
        self.superView = view;
        self.view.frame = Frame;
       // self.view.clipsToBounds = YES;
        self.view.backgroundColor = [UIColor clearColor];
        _menuTableViewOffset = UIEdgeInsetsZero;
        _dropDownMenuViewStyle = UITableViewStyleGrouped;
        _sectionRowCountArr = [[NSArray alloc] init];
    }

    return self;
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    CGRect frame = self.view.bounds;

    if (!IsNilOrNull(self.menuBackgroudImage)) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.menuBackgroudImage];
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.view addSubview:imageView];
        TT_RELEASE_SAFELY(imageView);
    }
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.menuTableViewOffset, UIEdgeInsetsZero)) {
        frame.origin.x =  self.menuTableViewOffset.left;
        frame.origin.y = self.menuTableViewOffset.top;
        frame.size.width = frame.size.width - self.menuTableViewOffset.left - self.menuTableViewOffset.right;
        frame.size.height = frame.size.height - self.menuTableViewOffset.top - self.menuTableViewOffset.bottom;
    }
    self.dropDownMenuView.frame = frame;
    
    [self.view addSubview:self.dropDownMenuView];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
}


- (void)loadView{

    [super loadView];
            
}

- (CGFloat)contentHeight
{
    return self.dropDownMenuView.contentSize.height;
}

- (void)setContentHeight:(CGFloat)contentHeight
{
    CGSize size = self.dropDownMenuView.contentSize;
    size.height = contentHeight;
    self.dropDownMenuView.contentSize = size;
}

#pragma mark -  View Display Methods
#pragma mark    视图展示的方法实现

- (void)displayMenuAtFrame:(CGRect)frame Animation:(eMenuAnimation)animationType{
   
    [self.superView addSubview:self.view];
    
}

- (void)dismissMenuWithAnimation:(eMenuAnimation)animationType{
    
    [self.view removeFromSuperview];
} 

- (void)getAnimation{
}

- (void)reloadDataWithNumberOfRowAndSection:(NSArray *)sections{
    
    self.sectionRowCountArr = sections;
    [self.dropDownMenuView reloadData];
}

#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (IsNilOrNull(self.sectionRowCountArr)) {
        return 0;
    }else{
        return [self.sectionRowCountArr count];
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (IsNilOrNull(self.sectionRowCountArr)) {
        return 0;
    }else{
        
        NSString *rowNum =  [self.sectionRowCountArr objectAtIndex:section];
        return [rowNum intValue];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat height = 0;
    if ([self.delegate respondsToSelector:@selector(dropDownMenu:heghtForRowAtIndextPath:)]) {
        height = [self.delegate dropDownMenu:tableView heghtForRowAtIndextPath:indexPath];
    }
    return height;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell  = nil;
    
    if ([self.delegate respondsToSelector: @selector(dropDownMenu:cellForRowAtIndextPath:)] ) {
        cell = [self.delegate dropDownMenu:tableView cellForRowAtIndextPath:indexPath];
    }else{
        cell = [[UITableViewCell alloc] init];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.delegate respondsToSelector:@selector(dropDownMenu:didSelectRowAtIndextPath:)]) {
        [self.delegate dropDownMenu:tableView didSelectRowAtIndextPath:indexPath];
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(dropDownMenu:willDisplayCell:forRowAtIndextPath:)]) {
        [self.delegate dropDownMenu:tableView willDisplayCell:cell forRowAtIndextPath:indexPath];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableView *)dropDownMenuView{

    if (!_dropDownMenuView) {
        _dropDownMenuView  = [[UITableView alloc] initWithFrame:CGRectZero style:self.dropDownMenuViewStyle];
        _dropDownMenuView.delegate = self;
        _dropDownMenuView.dataSource = self;
        _dropDownMenuView.backgroundView = nil;
        _dropDownMenuView.indicatorStyle =  UIScrollViewIndicatorStyleWhite;
        _dropDownMenuView.backgroundColor = [UIColor clearColor];
        if (IOS7_OR_LATER) {
            _dropDownMenuView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        }

        _dropDownMenuView.bounces = NO;
    }
    return _dropDownMenuView;
}


@end
