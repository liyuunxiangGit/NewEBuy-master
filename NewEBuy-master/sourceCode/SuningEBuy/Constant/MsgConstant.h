//
//  HttpConstant.h
//  Common Application
//
//  Created by wangrui on 11/25/11.
//  Copyright (c) 2011 suning. All rights reserved.
//


#define HTTP_TIMEOUT    30.0f

typedef enum CmdCode
{
	// 系统命令
	CC_VersionCheck             = 0x0001,//3.8.5 检查版本号 Action:SNMobileGetClientVersionView
    CC_MessagePush              = 0x0002,//3.7.7 获取推送消息接口 Action:SNMobileMessageListView
	CC_NetCheck					= 0x0003,// 网络检测, 无接口
	CC_SpecialSubject           = 0x0004,//获取促销专栏列表
    
	// 个人信息命令
	CC_Login                    = 0x0101,//接口文档:3.2.1 用户登录 Action: SNiPhoneAppLogon
	CC_Logout					= 0x0102,//接口文档:3.2.3 用户注销 Action: SNiPhoneAppLogoff
    CC_Register                 = 0x0103,//接口文档:3.2.2 用户注册 Action: SNiPhoneAppUserRegister
    CC_AccountValidate          = 0x0104,//接口文档:3.2.26 忘记B2C密码 Action:SNmobileForgetPassword
    CC_ResetPassword            = 0x0105,//接口文档:3.2.27 重置B2C密码 Action:SNmobileResetPassword
    CC_DisCountInfo             = 0x0106,//接口文档:3.11.1 优惠券体信息查询接口 Action:MySuningIndexAjaxView
    //易付宝
    CC_EfubaoAcount             = 0x0107,//接口文档：3.2.12.1 易付宝余额接口new Action：SNiPhoneAppBalanceViewNew
    CC_BoundPhoneLogonByEmail   = 0x0108,//接口文档:3.2.31 绑定手机号接口 Action:SNiPhoneBindMobileCmd
    CC_CheckCode                = 0x0109,//接口文档:3.2.28 激活易付宝发送验证码接口 Action:SNmobileSendActMsgCmd
    CC_GeneralEfubao            = 0x010A,//接口文档：3.2.29 激活易付宝接口。Action:SNmobileActiveEppCmd    
    CC_ReadyEfubao              = 0x010B,//接口文档：3.11.5.1 激活云钻账号准备接口。Action:SNMobilePreCardInfoModify
    CC_ActiveEfubao             = 0x010C,//接口文档：3.2.29 激活易付宝接口。Action:SNmobileActiveEppCmd 
    //我的收藏
    CC_MyFavorite               = 0x010D,//接口文档:3.2.13 我的收藏 Action: SNiPhoneAppInterestListView
    CC_MyFavoriteDelete         = 0x010E,//接口文档:3.2.14 删除收藏 Action: SNiPhoneAppInterestClear 
    CC_BoundPhoneLogonByPhone   = 0x010F,//接口文档:3.2.32 手机账号注册验证接口 Action:SNiPhoneConfirmMobileAccount
    
    //搜索
    CC_HotKeyword               = 0x0201,//接口文档:3.12.2 热门关键字 Action:SNiPhoneHotWordView
    CC_IsbnSearch               = 0x0202,//接口文档:3.1.3 商品详情接口(条码搜索) Action: SNiPhoneAppProductDisplay
    CC_AssociationalWord        = 0x0203,//接口文档:3.4.6 联想词搜索 Action: SNGetKeywordCmd
    CC_SearchList               = 0x0204,//接口文档:3.4.3, 3.4.4, 3.12.1 搜索接口 Actions: SNmobileElectricalSearch SNmobileBookSearch SNiPhoneMixSearch
    //类目
    CC_FirstCategory            = 0x0205,//接口文档：3.1.10 商品首级目录接口 Action: SNmobileTopMenu
    CC_SecondCategory           = 0x0206,//接口文档：3.1.1 二级品类获取数据接口 Action: SNmobileSecMenuView
    CC_ThirdCategory            = 0x0207,//接口文档：3.1.2 三级品类获取数据接口 Action: SNmobileThirdMenuView
    CC_NoResSugProduct          = 0x0208,
    
    
    //八联版 促销模块
    CC_RequestEightBannerImages = 0x0301,
    CC_Recommend                = 0x0302,
    CC_Model1                   = 0x0303,
    CC_Model2                   = 0x0304,
    CC_Model3                   = 0x0305,
    CC_Model4                   = 0x0306,
    CC_Model5                   = 0x0307,
    //热门促销
    CC_HotSale                  = 0x0308,//接口文档：3.7.3 获取热销商品清单 Action:SNiPhoneHotZoneView
    //抢购团购
    CC_PanicPurchase            = 0x0309,//接口文档：3.7.2 获取抢购商品清单 Action:SNiPhoneQuickBuyView
    CC_GroupPurchase            = 0x030A,//接口文档：3.7.4 获取团购商品清单 Action:SNiPhoneGroupPurchaseView
    CC_PanicPurchaseDetail      = 0x030C,//获取抢购详情接口，抢购新添加接口
    CC_PanicPurchaseLimit       = 0x030D,//获取抢购权限接口，抢购新添加接口
    //新促销模块
    CC_ActivityProduct          = 0x030E,//新促销模块促销活动商品
    //八连版内页
    CC_RequestEightBannerInner  = 0x030F,
    
    //地址
    CC_AddressProvince          = 0x0401,//3.8.1 获取省份接口 Action: SNiPhoneProvinceView
    CC_AddressCity              = 0x0402,//3.8.2 获取省份中城市的接口 Action: SNiPhoneCityView
    CC_AddressDistrict          = 0x0403,//3.8.3 获取城市下区镇的接口 Action: SNiPhoneDistrictView
    CC_AddressTown              = 0x0404,//3.8.4 获取区下的范围的接口 Action: SNiPhoneTownView
    CC_AddressList              = 0x0405,//3.2.16 用户配送地址列表查询接口 Aciton: SNiPhoneAppAddressView
    CC_AddAddress               = 0x0406,//3.2.17 配送地址新建接口  Action: SNiPhoneAppAddressAdd
    CC_EditAddress              = 0x0407,//3.2.18 配送地址新建接口  Action: SNiPhoneAppAddressUpdate
    CC_DeleteAddress            = 0x0408,//3.2.24 配送地址删除接口  Action: SNiPhoneAppAddressDelete
    
    //图书馆
    CC_TopBanner                = 0x0501,
    CC_BooksChannel             = 0x0502,
    CC_LibraryName              = 0x0503,
    CC_TopBannerAndBooksChannel = 0x0504,
    CC_LibraryAdModel3          = 0x0505,
    CC_HotBooksSaleService      = 0x0506,
    CC_ThreeUnitePage           = 0x0507,
    
    //彩票
    CC_LotteryHall              = 0x0601,
    CC_LotteryOrderList         = 0x0602,
    CC_LotteryOrderDetail       = 0x0603,
    CC_TicketPayment            = 0x0604,
    CC_DealsList                = 0x0605,
    CC_DealsSerialNumberList    = 0x0606,
    CC_FollowOrderProject       = 0x0607,
    CC_FollowOrderDetail        = 0x0608,
    CC_lotteryPay               = 0x0609,
    CC_ChaseNumberPayment       = 0x060a,
    CC_AgentPurchasePayment     = 0x060b,// 代购订单支付
    CC_CouponQuery              = 0x060c,//用劵查询
    CC_CouponUserQuery          = 0x060d,//用劵人信息查询
    CC_CheckCoupon              = 0x060e,//用劵检查
    CC_PayRemainMoney           = 0x060f,//用劵检查
    CC_CancelCoupon             = 0x0611,//用劵检查

    
    //我的易购
    CC_ChangeUserImage          = 0x0709,
    CC_WBCardDetailSave         = 0x070A,
    
    CC_OrdersNumber             = 0x070B,
    
    //订单中心
    CC_OrderCenter              = 0x0701,//接口文档: 3.2.8 各类型订单数量查询 Action: SNiPhoneAppOrderStatusView
    CC_OrderList                = 0x0702,//接口文档: 3.2.9 某类型订单列表查询 Action: SNiPhoneAppOrderListViewSNiPhoneAppOrderStatusView
    CC_OrderDetail              = 0x0703,//接口文档: 3.2.10 订单明细查询接口 Action:SNiPhoneAppOrderDisplayView
    CC_CancelOrder              = 0x0704,//接口文档: 3.2.11 非货到付款订单取消接口 Action:SNiPhoneAppOrderCancel
    CC_editNickName             = 0x0705,//修改昵称
    CC_OrderConfirmAccept       = 0x0709,//确认收货
    
    CC_OrderRemove              = 0x0710, // 删除订单 xzoscar 2014/08/21 add

    CC_ShopOrderList            = 0x706,//门店订单列表入口
    CC_ShopSnxpress             = 0x707,//门店订单物流查询接口
    CC_ShopOrderDetail          = 0x708,//门店订单详情接口
    
    //送货安装
    CC_ServiceTrackList         = 0x0801,
    CC_ServiceDetail            = 0x0802,
    CC_EvaluateList             = 0x0803,
    CC_EvaluateValidate         = 0x0804,
    CC_EvaluatePublish          = 0x0805,
    CC_EvaluateProduct          = 0x0806,
    //CC_EvaluateNumber           = 0x0807,
    //CC_EvaluateLabel            = 0x0808,
    
    //资讯
    CC_PromotionInfo            = 0x0901,
    
    //商品模块
    CC_ProductDetail            = 0x0A01,//接口文档：3.1.3 商品详情数据接口 Action: SNiPhoneAppProductDispaly
    CC_AddToFavorite            = 0x0A02,//接口文档：3.2.7 商品添加收藏接口 Action: SNiPhoneAppInterestItemAdd
    CC_ProductParam             = 0x0A03,//接口文档：3.1.5 商品参数数据接口 Action: SNiPhoneAppProductAttrView
                                         //图书：3.1.11 图书商品参数接口 Action: SNiPhoneBookPublishView
    CC_ProductAppraisal         = 0x0A04,//接口文档3.1.8 获取电器商品评价数据接口 ActionSNiPhoneAppProductEvalView
    //图书评价 
    CC_BookAppraisal            = 0x0A05,//3.1.16 获取图书商品评价和咨询接口 Action:SNiPhoneBookAppraiseConsultView
    CC_ProductConsultant        = 0x0A06,
    
    //商品咨询
    CC_ApplianceConstant        = 0x0A07,//接口文档：3.1.7  获取电器商品咨询数据接口  Action:SNiPhoneAppProductConsView
    CC_New_Consultant           = 0x0A08,//接口文档：3.1.13  发表电器商品评价和咨询接口  Action:SNiPhonePublishArticle

    //用户是否可以对商品进行评价
    CC_Validate                 = 0x0A09,
    
    //获取推荐商品
    CC_RecommendListProduct     = 0x0A10,
    
    //大聚惠详情
    CC_BigSaleProduct           = 0x0A11,
    
    //预约详情
    CC_AppointmentProduct       = 0x0A12,
    
    //预约抢购资格
    CC_AppointmentActoin        = 0x0A13,
    
    //s码购买资格
    CC_ScScodeAcion             = 0x0A14,
    
    //支持附近现货
    CC_SpotSupport              = 0x0A15,
    
    //发表新的评价
    CC_Evaluate                 = 0x0A0A,
    //晒单
    CC_DisorderById             = 0x0A0B,//根据id获取晒单详情
    CC_DisorserList             = 0x0A0C,//获取晒单列表请求
    //图书咨询
    CC_BookConstant             = 0x0A0D,//接口文档3.1.16 获取图书咨询接口 Action:SNiPhoneBookAppraiseConsultView
    CC_AddShopListInfoCmd       = 0x0A0E, //商家列表
    
    
    //我的易购卷
    CC_MyCoupon                 = 0x0B01,
    CC_MyExCoupon               = 0x0B02,
    
    //我的云钻
    CC_MyIntegral               = 0x0C01,//3.11.4 我的云钻接口 Action:SNMobileAchievementInquireView
    CC_PreCardInfo              = 0x0C02,//3.11.5.1 激活云钻账号准备接口 Action:SNMobilePreCardInfoModify
    CC_ActiveInteger            = 0x0C03,//3.11.5.2 激活云钻账号接口 Action:SNMobileCardInfoModify
    CC_IntegralDetail           = 0x0C04,//3.2.30 获取云钻明细接口 Action:SNMobileAchievementListView
    CC_ExchangeIntegral         = 0x0C05,//3.2.30 获取云钻明细接口 Action:SNMobileAchievementListView

    
    //手机充值
    CC_Preferential             = 0x0D01,//3.9.2 话费充值-查询优惠金额 Action:SNiPhoneFillGetReduceView
    CC_MobileNumber             = 0x0D02,//3.9.1 话费充值-获取手机所属运营商和省份 Action:SNiPhoneFillGetIspView
    CC_MobilePay                = 0x0D03,//3.9.4 话费充值-支付订单 Action:SNiPhoneFillPayOrderView
    CC_HuifuMobilePay           = 0x0D04,//3.9.12 话费充值-汇付支付下订单接口 Action:SNMCreatelPhonePayOrder
    CC_MobilepayOrderList       = 0x0D05,//3.9.5 话费充值-查询订单 Action:SNiPhoneFillQueryAllOrderView
    CC_MobilePayOnBank          = 0x0D06,//银联支付

    //水电煤充值
    CC_RegionInfo               = 0x0D06,//3.9.6 水电煤缴费-根据缴费类型查询缴费地区 Action:SNiPhoneAppGetAreaByFeeTypeView
    CC_CompanyList              = 0x0D07,//3.9.7 水电煤缴费-查询收缴单位 Action:SNiPhoneAppGetCompanyByAreaView
    CC_FeeMode                  = 0x0D08,//3.9.8 水电煤缴费-查询账户类型 Action:SNiPhoneAppGetFeeModeView
    CC_AccountInfo              = 0x0D09,//3.9.9 水电煤缴费-查询缴费账户信息 Action:SNiPhoneAppGetAccountInfoView
    CC_PaymentQuery             = 0x0D0A,//3.9.11 水电煤缴费-缴费查询 Action:SNiPhoneAppFeePaymentQueryView
    CC_ChargeCityList           = 0x0D10,// 水电煤缴费-缴费城市列表
    CC_ChargeMode               = 0x0D11,// 水电煤缴费-查询账户类型
    
    CC_EFuBao                   = 0x0D0B,//3.2.12 易付宝余额接口 Action:SNiPhoneAppBalanceView
    CC_PaymentApply             = 0x0D0C,
    CC_PaymentPayOnBank         = 0x0D0D,//银联支付
    CC_MobilePaySdkOnBank       = 0x0D0E,//sdk支付
    CC_GDWPaySdkOnBank          = 0x0D0F,//sdk支付

    
    //购物车
    CC_SyncShopCart             = 0x0E01,//3.14.2.1 查询购物车中商品new Action:SNMobileSCOrderItemsSearch
    CC_DeleteShopCartProduct    = 0x0E02,
    CC_CheckProductToShopCart   = 0x0E03,
    
    //支付流程
    CC_OrderCheckOut            = 0x0E04,//3.14.4 去结算 Action: SNMobileOrderCheckOut
    CC_SubmitOrder              = 0x0E05,//3.14.5 提交订单 Action: SNMobileSubmitOrder
    CC_PaySubmit                = 0x0E06,//3.14.6 确认支付 Action: SNMobilePaySubmit
    CC_LastShipInfo             = 0x0E07,//3.14.7 用户最近配送、自提信息 Action: SNMobileLastShipInfoView
    CC_BuyNowOrder              = 0x0E08,
    
    CC_ConfirmDelivery          = 0x0E10,//2.10.4 确认配送方式和地址
    CC_PaymentChoose            = 0x0E11,//2.10.5 可支持的支付方式
    CC_SavePayMethod            = 0x0E12,//2.10.6 确认支付方式 
    CC_SaveCardAndCoupon        = 0x0E13,//2.10.14 确认优惠券、礼品卡、联盟号
    
    
    //获取可用优惠券列表
    CC_GiftCouponList           = 0x0E08,
    CC_GetShops                 = 0x0E09,
    CC_GetVerifyCode            = 0x0E0A,
    CC_SecondPayment            = 0x0E0B, //二次支付
    CC_ActiveGiftCoupon         = 0x0E0C, //激活券
    
    CC_ShopCartUpdate           = 0x0E0D, 
    
    //获取用户可用云钻
    CC_CloudDiamond             = 0x0E0E,
    
    //查询送货时间
    CC_DelAndInsend             = 0x0E0F,
    //查询安装时间
    CC_InstallDate              = 0x0E1A,
    
    //注册送券
    CC_GetSwitchList            = 0x0F01,//3.8.6 活动开关查询接口 Action:SNMobileSwitchListView
    CC_ActivityAction           = 0x0F02,//3.11.11 活动送券的接口 Action:SNMobileIssueCouponForActivity
    
    //C店商品详情
    CC_CStoreProDetail          = 0x0F03,//C店商品详情接口SNiPhoneAppShopProductDispaly
    
    
    //机票订单查询
    CC_FlightOrderList          = 0x1001,
    CC_FlightOrderDetail        = 0x1002, 
    CC_FlightOrderCancel        = 0x1003,
    //机票相关查询    
    CC_GoFlightInfoList         = 0x1004, //去程机票列表请求
    CC_BackFlightInfoList       = 0x1005, //返程机票列表请求 
    CC_FlightTicketRule         = 0x1006, //航班机票规则
    CC_NewBoarding              = 0x1007, //添加登机人
    CC_BoardingList             = 0x1008, //登机人列表请求
    CC_DeleteBoarding           = 0x1009, //删除登机人
    CC_FlightPayByEpp           = 0x100A, //易付宝支付航班
    CC_FlightPayByHftx          = 0x100B, //汇付天下支付
    CC_FlightOrderSubmit        = 0x100C, //机票订单提交请求 Action：submitOrder.htm
    CC_QueryInsurance           = 0x100D, //查询险种的接口
    CC_FlightPayOnBank          = 0x100E, //航班银联支付

    
    //一键购
    CC_EasilyBuyList            = 0x1101,//3.13.4 查询一键购列表  Action: SNiPhoneEasilyBuyList
    CC_AddEasilyBuy             = 0x1102,//3.13.1 新增一键购     Action: SNiPhoneEasilyBuy
    CC_UpdateEasilyBuy          = 0x1103,//3.13.2 更新一键购   Action: 同上
    CC_DeleteEasilyBuy          = 0x1104,//3.13.3 删除一键购   Action: 同上
    //一键购支付
    CC_OrderItemAdd             = 0x1105,
    CC_OrderProgress            = 0x1106,
    
    
    //退货
    CC_ReturnGoodsQuery         = 0x1201,//3.5.10 已退货订单查询   Action:SNMobileReturnGoodsQueryDetailView
    CC_RetrunGoodsList          = 0x1202,//3.5.7 可退货订单行查询  Action:SNMobileRGOrderitemsListView
    CC_ReturnGoodsApplication   = 0x1203,//3.5.8 退货申请准备     Action:SNRetWorkOrderTypeChange
    CC_ReturnGoodsSubmit        = 0x1204,//3.5.9 退货申请        Action:SNMobileRetCashOnDelivery//
    //c店退货
    CC_ReturnCShopGoodsApplication = 0x1205,//3.5.8 退货申请准备     Action:SNRetWorkOrderValidate
    CC_ReturnCShopGoodsconfirm   = 0x1206,//3.5.8 退货申请退货
    CC_ReturnCShopGoodsExpress = 0x1207,//3.5.8 退货申请退货
    
    
    

    //酒店接口
    CC_SearchHotel              = 0x1301,
    CC_HotelLocation            = 0x1302,
    CC_HotelDetail              = 0x1303,
    CC_HotelRoomType            = 0x1304,
    CC_HotelOrderSubmit         = 0x1305,
    
    //晒单
    CC_DisorderDetail           = 0x1401,
    CC_URPhotoExist             = 0x1402,
    
    //促销活动
    CC_ChouJiang                = 0x1501, //翻牌抽奖
        
    //兄弟秒杀接口
    CC_SecondKillList           = 0x0109,
    
    //新团购接口
    CC_GBGoodsDetail            = 0x1601,
    CC_GBAllCityList            = 0x1602,
    CC_GBHotCityList            = 0x1603,
    CC_GBAllandHotCityList      = 0x1604,
    CC_GBReferOrder             = 0x1605,
    CC_GBPayByEpp               = 0x1606,
    CC_GBPayByMobile            = 0x1607,
    CC_GBGoodsList              = 0x1608,//3.2获取团购商品列表 Action：getGoodsList.htm
    CC_GBOrderList              = 0x1609,//3.8获取团购订单列表 Action：getOrderList.htm
    CC_GBOrderDetail            = 0x160A,//3.8获取团购订单列表 Action：getOrderDetail.htm
    CC_GBSearch                 = 0x160B,
    CC_GBCancelOrder            = 0x160C,
    CC_GBRefund                 = 0x160D,
    
    //附近苏宁接口
    CC_NearbySuningSearch       = 0x1701,
    //云信苏宁门店接口
    CC_StoreList                = 0x1702,
    CC_StoreDetailInfo          = 0x1703,
    CC_VoiceActity              = 0x1704,
    
    CC_ServiceList              = 0x1705,
    CC_CampaignList             = 0x1706,
    CC_CampStoreList            = 0x1707,
    CC_ServeStoreList           = 0x1708,
    CC_UpdateFavoStore          = 0x1709,
    CC_MyFavoStore              = 0x170A,
    CC_TopCampaignList          = 0x170B,
    CC_NearestStore             = 0x170C,
    
    CC_NearbySpotStore          = 0x170D,//附近现货
    
    //新注册
    CC_UserRegister             = 0x1801,//新用户注册 Action: SNMTUserRegister
    CC_FindPassword             = 0x1802,//找回密码 Action:SNMTRetrievePsw
    
    CC_SearchBindedInfo         = 0x1803,//验证短信验证码&&检索出易购账号+门店会员卡 Action:SNMTSearchBindedInfoCmd
    CC_MbrCardBindAccount       = 0x1804,//绑定易购账号 Action:SNMTMbrCardBindAccount
    CC_SearchMbrCardInfo        = 0x1805,//登录状态查询门店卡绑定信息 Action:SNMTSearchMbrCardInfoCmd
    CC_GetBindMbrCardView       = 0x1806,//登录状态绑定手机号查询门店卡信息 Action:SNMTGetBindMbrCardView
    CC_AccountBindMbrCard       = 0x1807,//登录状态合并会员卡 Action:SNMTAccountBindMbrCard
    CC_MergeNewAccount          = 0x1808,//新建易购账号合并 Action:SNMTMergeNewAccount
    CC_SendMergeValidCode       = 0x1809,//验证码 Action:SNMTSendMergeValidCode
    CC_GetValidateCode          = 0x1810,//新用户注册获取验证码
    CC_ValidateRegist           = 0x1811,//新用户注册验证手机号码与验证码

    //dm单
    CC_DMOrder                  = 0x1901,
    
    CC_DMArray                  = 0x1902,
    
    CC_HomeFloor                = 0x1A01,
    CC_HomeSignPic              = 0x1A02,
    CC_HomeFloorPanic           = 0x1A03,
    CC_HomeRushGrp              = 0x1A04,
    CC_HomeFloor2               = 0x1A05,
    
    CC_HomePage                 = 0x1A11,
    CC_CuXiaoZhuanTi            = 0x1A12,
    CC_LianBanZhuanTi           = 0x1A13,
    CC_ShangPinLieBiao          = 0x1A14,
    CC_HomeVersion              = 0x1A15,
    CC_HomeSecondPage           = 0x1A16,
    //首页猜你喜欢模块
    CC_HomeGuessYouLike         = 0x1A16,
    
    //单价团
    CC_DJGroupList              = 0x1B01,
    CC_DJGroupDetail            = 0x1B02,
    CC_DJGroupApply             = 0x1B03,
    
    //签到
    CC_RegistrationPrepare      = 0x1C01,
    CC_RegistrationDetail       = 0x1C02,
    CC_StoresRegistration       = 0x1C03,
    
    //消息中心
    CC_InformationList          = 0x1D01,
    CC_InformationDetail        = 0x1D02,

    
    //用户反馈
    CC_UserFeedback             = 0x1F01,
    
    
    //四级页面收藏
    CC_CollectDetail            = 0x1F03,
    
    //在线客服
    CC_OSGetB2CStatus           = 0x2001,
    CC_OSGetCStatus             = 0x2002,
    CC_OSCreateB2CChat          = 0x2003,
    CC_OSCreateCChat            = 0x2004,
    CC_OSWaitQueue              = 0x2005,
    CC_OSExitWaitQueue          = 0x2006,
    CC_OSSendMsg                = 0x2007,
    CC_OSGetMessage             = 0x2008,
    CC_OSEndChat                = 0x2009,
    CC_OSOpinion                = 0x200A,
    CC_OSLeaveMessage           = 0x200B,
    CC_OSQuickAsk               = 0x200C,
    
    //门店评价
    CC_StoreEvaluationList           = 0x2100,  //待评价门店订单
    CC_StoreEvaluationState          = 0x2101,  //门店订单评价状态
    CC_StoreEvaluationCommit         = 0x2102,   //门店订单评价提交

    //登录验证是否需要验证码
    CC_CheckNeedVerifyCode      = 0x3001,
    
    //cpa&cps
    CC_INVITATION               = 0X3002,
    CC_QUERYREWARD              = 0X3003,
    CC_GETREDPACK               = 0x3004,               //新人领取红包
    CC_GETRED                   = 0X3005,                 //领取红包
    
    /*
     // Command :CC_YaoYiYaoActiveQuery
                 CC_YaoYiYaoActiveShakeJiang
                 CC_YaoYiYaoActiveCloneValidate
     // Description : YaoYiYao(摇易摇)
     // Date : 2014-04-03 11:00:00
     // Author : XZoscar
     */
    CC_YaoYiYaoActiveQuery          = 0x4001,  // 活动查询
    CC_YaoYiYaoActiveShakeJiang     = 0x4002,  // 摇奖
    CC_YaoYiYaoActiveCloneValidate  = 0x4003,  // 克隆给朋友 合法性校验
    CC_YaoYiYaoScoreParkServeItems  = 0x4004,  // 云钻乐园 2014-05-30 新增

    CC_SearchNoResultRecommendForKeySearch = 0x5001, //新搜索推荐接口，for 关键词搜索无结果场景
    CC_SearchNoResultRecommendForCategoryFilter = 0x5002,  //新搜索推荐接口，for 分类筛选无结果场景
    
    CC_GetConsultList              = 0x6001,    //获取商品咨询列表
    CC_GetConsultCount             = 0x6002,    //获取商品咨询数量
    CC_GetMyConsultList               = 0x6003,     //获取我的咨询历史
    CC_PublichConsult               = 0x6004,     //发表咨询
    CC_ConsultNumDetail            = 0x6005,       //咨询概况
    CC_ConsultSatisfaction         = 0x6006,         //咨询满意度
    CC_ConsultationType            = 0x6007,         //咨询类型
    
    CC_ScanerCodeActionLogin       = 0x7001,    // 扫码登录（passport调度其它终端同时登录）
    CC_ScanerCodeActionAuthorize   = 0x7002,     // 扫码登录（客户端授权操作）

    CC_ShopSearchList              = 0x7003,     //店铺搜索
    
    CC_SearchMtsPromotion          = 0x7004,     //mts一拖2促销
    
    
    /*
     // Command :身边顾问 相关 cmd
     // Description : 身边顾问 相关 cmd,占用0x800x
     // Date : 2014-09-22 14:00:00
     // Author : XZoscar
     */
    CC_NBYGetHomeChannels            = 0x8000,  // 频道 tabs
    CC_NBYHomeFixedModeChannelList   = 0x8001,  // 首个 频道列表 (身边精华)
    CC_NBYHomeNormalModeChannelList  = 0x8002,  // 普通频道列表
    CC_NBYGetCommentsList            = 0x8003,  // 获取评论列表
    CC_NBYSendComment                = 0x8004,  // 发送评论
    CC_NBYGetDaShangsList            = 0x8005,  // 获取打赏列表
    CC_NBYSendDaShang                = 0x8006,  // 打赏
    CC_NBYReportPublish              = 0x8007,  // 举报 帖子
    CC_NBYGetScoreConfList           = 0x8008,  // 获取打赏积分/云钻列表 (打赏属性列表)
    CC_NBYDoReward                   = 0x8009,  // 对帖子进行打赏
    CC_NBYGetMoreSticksListByPos     = 0x8010,  // 获取更多帖子列表 按分组
    CC_NBYGetDynamicNoticeCount      = 0x8011,  // 获取动态提示数字
    CC_NBYGetDynamicNoticesList      = 0x8012,  // 获取动态列表 分页
    CC_NBYPublicStick                = 0x8013,  // 发布帖子
    CC_NBYGetStickDetail             = 0x8014,  // 获取帖子详情
    CC_NBYUploadPicture              = 0x8015,  // 上传要发布的图片
    CC_NBYNormalMoreModeChannelList  = 0x8016,  // 地理位置 分组 更多
    CC_SearchQueryRecommendedBrand   = 0x8017,  //搜索列表热销品牌
    CC_ReturnGoodsUpPic              = 0x9000,
    CC_ReturnGoodsDeletePic          = 0x9001,
    
    CC_CommentShareValidate          = 0xA000,   //251评价晒单验证接口
    CC_CommentShareImageUpload       = 0xA001,   //251评价晒单图片上传
    CC_CommentSharePublish           = 0xA002   //251评价晒单发布接口
    
    
} E_CMDCODE;


//需要登录的接口
static const int CC_NEED_LOGIN_QUEUE[] = 
{
    0x0106,
    0x0107,
    0x0108,
    0x0109,
    0x010A,
    0x010B,
    0x010C,
    0x010D,
    0x010E,
    0x010F,
    
    0x030B,
    0x030D,
    
    0x0405,
    0x0406,
    0x0407,
    0x0408,

    
    0x0602,
    0x0603,
    0x0604,
    0x0605,
    0x0605,
    0x0606,
    0x0607,
    0x0608,
    0x0609,
    0x060a,
    0x060b,
    
    
    0x0701,
    0x0702,
    0x0703,
    0x0704,
    
    0x0801,
    0x0802,

    0x0A02,
    0x0A08,
    0x0A09,
    0x0A0A,
    
    0x0B01,
    0x0B02,
    
    0x0C01,
    0x0C02,
    0x0C03,
    0x0C04,
    0x0C05,
    
    0x0D03,
    0x0D04,
    0x0D05,
    0x0D0A,
    0x0D0B,
    0x0D0C,
    
    0x0E04,
    0x0E05,
    0x0E06,
    0x0E07,
    0x0E08,
    0x0E09,
    0x0E0A,
    0x0E0B,

    0x1001,
    0x1002,
    0x1006,
    0x1007,
    0x1008,
    0x1009,
    0x100A,
    0x100B,
    
    0x1101,
    0x1102,
    0x1103,
    0x1104,
    0x1105,
    0x1106,

    0x1201,
    0x1202,
    0x1203,
    0x1204,
    
    0x1305,
    
    0x1605,
    0x1606,
    0x1607,
    0x1609,
    0x160C,
    0x160D,
    
    0x0702,
    0x706,
    0x707,
    0x708,
    
    0X3002
};

//需要重写cookie的接口，例如彩票服务器，酒店服务器的域名不同，需要重写下cookie，否则cookie不能带过去
static const int CC_NEED_COOKIE_QUEUE[] = 
{
    CC_LotteryHall              ,
    CC_LotteryOrderList         ,
    CC_LotteryOrderDetail       ,
    CC_TicketPayment            ,
    CC_DealsList                ,
    CC_DealsSerialNumberList    ,
    CC_FollowOrderProject       ,
    CC_FollowOrderDetail        ,
    CC_TicketPayment            ,
    CC_GBReferOrder             ,
    CC_GBCancelOrder            ,
    CC_GBRefund                 ,
    
    CC_CouponQuery              ,
    CC_CouponUserQuery          ,
    CC_CheckCoupon              ,
    CC_PayRemainMoney           ,
    CC_CancelCoupon             ,
    CC_lotteryPay               ,
    CC_ChaseNumberPayment       ,
    CC_AgentPurchasePayment     ,
    
    CC_EvaluateList             ,
    CC_EvaluateValidate         ,
    CC_EvaluatePublish          ,
    
    CC_RegistrationDetail       ,
    CC_StoresRegistration       ,
    CC_RegistrationPrepare      ,
//    CC_EvaluateProduct          ,
    CC_ScanerCodeActionLogin,
    CC_ScanerCodeActionAuthorize
};

