//
//  SearchHotelViewController.h
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-7-2.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchCityListViewController.h"
#import "SearchHotelLocationByCityNameViewController.h"
#import "CalendarViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "QueryConditionDTO.h"
#import "FlightListViewController.h"
#import "ToolBarTextField.h"
#import "HotelOrderBaseViewController.h"


@interface SearchHotelViewController : HotelOrderBaseViewController<SearchHotelCityListViewControllerProtocol,CalendarViewControllerDelegate,UITextFieldDelegate,SearchHotelLocationViewControllerProtocol,ToolBarTextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UITableView     *tpTableView_;          //个性化tableiew
    NSMutableArray  *_itemsValueArray;      //保存各个字段的值，最后传个搜索接口
    UIView          *_footView;             //尾试图，存放确定按钮
    UIButton        *_queryBtn;             //查询按钮
    NSString        *_queryDate;
    
    UILabel         *_cityLable;            //城市标题
    UILabel         *_locationLable;        //位置标题
    UILabel         *_nameLable;            //名称标题
    UILabel         *_dataLable;            //日期标题
    UILabel         *_numberOfDateLable;    //天数标题
    UILabel         *_priceLable;           //价格标题
    UILabel         *_starLable;            //星级标题
    
    UIButton        *_cityBtn;              //城市对话框
    UIButton        *_locationBtn;          //位置对话框
    UIButton        *_dateBtn;              //日期对话框
    
    UITextField     *_nameTextField;        //名称对话框
    UITextField     *_numberOfDateTextField;//天数对话框
}


@property (nonatomic ,strong) UILabel         *cityLable;           //城市标题
@property (nonatomic ,strong) UILabel         *locationLable;       //位置标题
@property (nonatomic ,strong) UILabel         *nameLable;           //名称标题
@property (nonatomic ,strong) UILabel         *dataLable;           //日期标题
@property (nonatomic ,strong) UILabel         *numberOfDateLable;   //天数标题
@property (nonatomic ,strong) UILabel         *priceLable;          //价格标题
@property (nonatomic ,strong) UILabel         *starLable;           //星级标题

@property (nonatomic ,strong) UIButton        *cityBtn;             //城市对话框
@property (nonatomic ,strong) UIButton        *locationBtn;         //位置对话框
@property (nonatomic ,strong) UIButton        *dateBtn;             //日期对话框

@property (nonatomic ,strong) UITextField     *nameTextField;       //名称对话框
@property (nonatomic ,strong) UITextField     *numberOfDateTextField;//天数对话框
@property (nonatomic ,strong) NSMutableArray  *itemsValueArray;     //保存各个字段的值，最后传个搜索接口

@property (nonatomic ,strong) UIView           *footView;            //尾试图，存放确定按钮
@property (nonatomic ,strong) UIButton         *queryBtn;            //查询按钮 
@property (nonatomic ,copy  ) NSString         *queryDate;           //查询日期
@property (nonatomic ,strong) NSArray          *priceList;           //价格列表
@property (nonatomic ,strong) NSArray          *starList;            //星级列表
@property (nonatomic ,strong) ToolBarTextField *priceTextField;      //价格输入框
@property (nonatomic ,strong) ToolBarTextField *starTextField;       //星级输入框
@property (nonatomic ,strong) UIPickerView     *pricePicker;         //价格选择器
@property (nonatomic ,strong) UIPickerView     *starPicker;          //星级选择器

-(NSString *)getDate;//获取当前日期
-(BOOL) validateHTTPReqestParam :(NSArray *) arr; //验证传值数组（3个月后、超过20天，提醒报错）
- (NSString *)calculateLeaveTime:(NSString *)arriveTime date:(NSString *)date;//根据入住日期、入住天数，计算出退房时间
-(BOOL)outOfdate;
@end
