//
//  SNCityListViewController.m
//  SuningEBuy
//
//  Created by snping on 14-11-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNCityListViewController.h"

@interface SNCityListViewController ()

@property (nonatomic,strong)NSArray *sectionIndexs;
@property (nonatomic,strong)NSArray *sectionTitles;
@property (nonatomic,strong)UILabel *showLetterLb;

@end

@implementation SNCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = L(@"CityList");
    [self sectionIndexs];
    [self sectionTitles];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
    if (IOS7_OR_LATER) {
        self.tableView.sectionIndexBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
    }else{
        [self changeSectionIndexBackgroudColor];//在[self.tableView reloadData]之后调用找得到UITableViewIndex
    }
    
    [self  showLetterLb];
    
    // Do any additional setup after loading the view.
}

-(void)changeSectionIndexBackgroudColor
{
    for (UIView *view in self.tableView.subviews) {
        
        if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewIndex"]) {
            
            [view setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.1]];
            
            break;
        }
    }
}

-(UILabel *)showLetterLb
{
    if (!_showLetterLb) {
            _showLetterLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
            _showLetterLb.layer.cornerRadius = 1.0;
            _showLetterLb.backgroundColor = [UIColor grayColor];
            CGFloat centerY = (kScreenHeight-64)/2.0;
            _showLetterLb.center = CGPointMake(kScreenWidth/2.0, centerY);
            _showLetterLb.font = [UIFont systemFontOfSize:30.0];
            _showLetterLb.textColor = [UIColor whiteColor];
            _showLetterLb.textAlignment = IOS7_OR_LATER?NSTextAlignmentCenter:    UITextAlignmentCenter;
            _showLetterLb.alpha = 0.9;
            _showLetterLb.hidden = YES;
           [self.view addSubview:_showLetterLb];
        }
        return _showLetterLb;
}

-(void)showWithLetter:(NSString *)letter
{
    if (!letter||!letter.length) {
        return;
    }
    
    [self.view bringSubviewToFront:self.showLetterLb];
    self.showLetterLb.hidden = NO;
    self.showLetterLb.text = letter;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.showLetterLb.alpha = 1.0;
     } completion:^(BOOL finished) {
         self.showLetterLb.hidden = YES;
         self.showLetterLb.alpha = 0.9;
        
    }];
    
}

- (NSArray *)sectionIndexs
{
    if (!_sectionIndexs) {
        NSMutableArray *array = [NSMutableArray arrayWithObject:L(@"Hot")];
        for (char i ='A'; i <='Z'; i++) {
          [array addObject:[NSString stringWithFormat:@"%c",i]];
        }
        _sectionIndexs = [NSArray arrayWithArray:array];
    }
    return _sectionIndexs;
}

- (NSArray *)sectionTitles
{
    if (!_sectionTitles) {
         NSMutableArray *muArr =[NSMutableArray arrayWithArray: [[self.cityDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        if ([muArr containsObject:@"HOT"]) {
            [muArr removeObject:@"HOT"];
            [muArr insertObject:L(@"HotCity") atIndex:0];
        }
        
        _sectionTitles =[NSArray arrayWithArray:muArr];
        
    }
    
    return _sectionTitles;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---tableViewDelegate-----
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionIndexs;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    if ([title isEqualToString:L(@"Hot")]) {
        title = L(@"HotCity");
    }else{
        [self showWithLetter:title];
     }
    
    
    if ([self.sectionTitles containsObject:title]) {
        return [self.sectionTitles indexOfObject:title];
    }else{
        NSInteger index0 = index -1;
        [self sectionOfIndex:&index0 andReferenceIndex:index];
        return index0;
    }
}

//递归查找 先往前查找没有再往后
- (void)sectionOfIndex:(NSInteger *)index andReferenceIndex:(NSInteger)referenceIndex
{
    if (*index>referenceIndex) {//往后找
        
        if (*index>self.sectionIndexs.count-1) {
            *index = 0;
            return;
        }
        
        NSString *title = [self.sectionIndexs objectAtIndex:*index];
        if ([title isEqualToString:L(@"Hot")]) {
            title = L(@"HotCity");
        }
        
        if ([self.sectionTitles containsObject:title]) {
            *index = [self.sectionTitles indexOfObject:title];
            return;
        }
        
        *index +=1;
        [self sectionOfIndex:index andReferenceIndex:referenceIndex];
        
    }else{
        
        if (*index<0) {//开始往后找
            *index = referenceIndex+1;
            [self sectionOfIndex:index andReferenceIndex:referenceIndex];
        }else
        {
            //往前找
            NSString *title = [self.sectionIndexs objectAtIndex:*index];
            if ([title isEqualToString:L(@"Hot")]) {
                title = L(@"HotCity");
            }

            
            if ([self.sectionTitles containsObject:title])
            {
                *index = [self.sectionTitles indexOfObject:title];
                return;
            }
            
            *index -=1;
            [self sectionOfIndex:index andReferenceIndex:referenceIndex];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.sectionTitles objectAtIndex:section];
    if ([key isEqualToString: L(@"HotCity")]) {
        key = @"HOT";
    }
    return [(NSArray *)[self.cityDic objectForKey:key] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [self.sectionTitles objectAtIndex:section];
    if ([title isEqualToString:@"HOT"]) {
        title = L(@"HotCity");
    }
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"CityCellReuse";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    NSString *key = [self.sectionTitles objectAtIndex:indexPath.section];
    if ([key isEqualToString:L(@"HotCity")]) {
        key = @"HOT";
    }
    
    SNCityFirstLetterDTO *city = [(NSArray *)[self.cityDic  objectForKey:key] safeObjectAtIndex:indexPath.row];
    
    if (!IsNilOrNull(city)) {
        cell.textLabel.text = city.cityName ;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.sectionTitles objectAtIndex:indexPath.section];
    if ([key isEqualToString:L(@"HotCity")]) {
        key = @"HOT";
    }

    NSArray  *citys = [self.cityDic objectForKey:key];
    SNCityFirstLetterDTO *cityDTO = [citys objectAtIndex:indexPath.row];
    
    if (self.cityCall) {
        self.cityCall(cityDTO);
    }
    
    [self backForePage];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
