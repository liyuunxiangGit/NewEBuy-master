//
//  AddressInfoPickerView.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      AddressInfoPickerView
 @abstract    用于展示地址信息的pick view
 @author      刘坤
 @version     v1.0.002  12-8-28
 @discussion  12-12-26  添加数组锁，解决线程安全的问题，修复ios时pickerView的行数为空时崩溃错误。
 */

#import <UIKit/UIKit.h>
#import "AddressInfoService.h"
#import "AddressInfoDTO.h"

@protocol AddressInfoPickerViewDelegate;

/*!
 @enum      AddressPickerViewCompentCount
 @abstract  地址pickerView的组件个数，共三种选择:2个, 3个, 4个
 */
typedef enum {
    AddressPickerViewCompentTwo = 2,
    AddressPickerViewCompentThree = 3,
    AddressPickerViewCompentFour = 4
}AddressPickerViewCompentCount;

/*!
 @class     AddressInfoPickerView
 @abstract  用于展示地址信息的pick view
 */
@interface AddressInfoPickerView : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource, AddressInfoServiceDelegate>
{
    AddressInfoService *_service;
    
    BOOL                _isLoadProvinceOk;
}

@property (nonatomic, strong) AddressInfoService *service;

/*!
 初始的地址信息，可重设
 */
@property (nonatomic, strong) AddressInfoDTO *baseAddressInfo;

/*!
 选中的地址信息
 */
@property (nonatomic, strong) AddressInfoDTO *selectAddressInfo;

/*!
 地址pickerView的组件个数
 */
@property (nonatomic,assign) AddressPickerViewCompentCount compentCount;

/*!
 代理
 */
// XZoscar 2014-05-29 10:00 修改
@property (nonatomic, weak) id<AddressInfoPickerViewDelegate> addressDelegate;
//@property (nonatomic, unsafe_unretained) id<AddressInfoPickerViewDelegate> addressDelegate;

/*!
 @method        initWithBaseAddressInfo:compentCount:
 @abstract      必须使用改方法进行初始化
 @param         baseAddress  初始的选择地址信息
 @param         count pickerView的compentCount数。只能是2,3和4。
 */
- (id)initWithBaseAddressInfo:(AddressInfoDTO *)baseAddress 
                 compentCount:(AddressPickerViewCompentCount)count;


/*!
 @method        reloadAddressData
 @abstract      刷新地址数据
 */
- (void)reloadAddressData;


/*!
 @method        isLoadProvincesOk
 @abstract      省份信息是否加载成功
 @discussion    调用情况，当更多页面的地址选择在无网络的情况下未加载成功时，
                再次进入页面的时候可以重新加载，不至于显示空白
 @result        yes：省列表加载成功， no: 省列表未加载成功
 */
- (BOOL)isLoadProvincesOk;

@end


/*!
 @protocol       AddressInfoPickerViewDelegate
 @abstract       AddressInfoPickerView的一个代理
 @discussion     第一次加载完成的回调方法
 */
@protocol AddressInfoPickerViewDelegate <NSObject>

@optional
/*!
 @method        addressPickerLoadDataOkWithSelectInfo:
 @abstract      加载数据完成后的回调方法
 @discussion    第一次加载完成会回调改方法，只回调一次，用于传回选择地址的详细信息
 @param         addressInfo  选中的地址信息
 */
- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo;

@end