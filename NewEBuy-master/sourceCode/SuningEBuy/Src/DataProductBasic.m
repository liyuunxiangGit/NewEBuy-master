#import "DataProductBasic.h"
#import "ProductUtil.h"
#import "SearchMtsPromotionDataService.h"
@implementation DataProductBasic

@synthesize		productCode  = _productCode;
@synthesize		productId    = _productId;
@synthesize		productName  = _productName;
@synthesize		cityCode	 = _cityCode;
@synthesize     xsection     = _xsection;
@synthesize		imageNum     = _imageNum;
@synthesize		hasStorage   = _hasStorage;
@synthesize		canTake		 = _canTake;
@synthesize		isOldToNew   = _isOldToNew;
@synthesize		hasAnnex     = _hasAnnex;
@synthesize		marketPrice  = _marketPrice;
@synthesize		suningPrice  = _suningPrice;
@synthesize		productFeature = _productFeature;
@synthesize		packageList    = _packageList;
@synthesize     productImageURL = _productImageURL;
@synthesize		evaluation = _evaluation;
@synthesize		isLoadMore = _isLoadMore;
@synthesize		price = _price;
@synthesize     userId = _userId;
@synthesize		special = _special;
@synthesize     shipOffset = _shipOffset;
@synthesize     shipOffSetText = _shipOffSetText;

@synthesize collectTime = _collectTime;
@synthesize isService = _isService;
@synthesize isSupportCash = _isSupportCash;
@synthesize ProductNum = _ProductNum;
@synthesize serviceProductCode	= _serviceProductCode;
@synthesize serviceProductId	= _serviceProductId;
@synthesize sendType		= _sendType;
@synthesize invoice			= _invoice;
@synthesize isProducerSent	= _isProducerSent;
@synthesize isABook         = _isABook;

@synthesize colorCurr = colorCurr_;
@synthesize colorItemList = colorItemList_;
@synthesize versionCurr = versionCurr_;
@synthesize versionDesc = versionDesc_;
@synthesize versionItemList = versionItemList_;
@synthesize colorVersionMap = colorVersionMap_;

@synthesize commentCount = _commentCount;
@synthesize advisoryCount = _advisoryCount;
@synthesize showOrdeCount = _showOrdeCount;

@synthesize goodevaluate = _goodevaluate;
@synthesize midEvaluate = _midEvaluate;
@synthesize badEvaluate = _badEvaluate;

@synthesize powerFlgOrAmt = _powerFlgOrAmt;
@synthesize qianggouPrice = _qianggouPrice;
@synthesize tuangouPrice  = _tuangouPrice;

@synthesize quickbuyId  = _quickbuyId;
@synthesize danjiaGroupId = _danjiaGroupId;
@synthesize rushProcessId = _rushProcessId;

@synthesize qianggouActId = _qianggouActId;
@synthesize qianggouFlag = _qianggouFlag;
@synthesize bookmarkFlag = _bookmarkFlag;

@synthesize tuangouActId = _tuangouActId;
@synthesize tuangouFlag = _tuangouFlag;

@synthesize favourDesc = _favourDesc;

@synthesize supplierNum = _supplierNum;
@synthesize bestPrice = _bestPrice;
@synthesize inventory = _inventory;
@synthesize allInventory = _allInventory;

- (void)dealloc
{
    if (_promotionService)
    {
        [_promotionService cancelRequest];
        _promotionService = nil;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        self.quantity = 1;
        _activityId = @"";
        _vendor = @"";
    }
    return self;
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
	NSString *imageNumber		= [dic objectForKey:kHttpResponseImageNum];
	NSString *proName			= [dic objectForKey:kHttpResponseProductName];
	NSString *proCode			= [dic objectForKey:kHttpResponseProductCode];
	NSString *proId				= [dic objectForKey:kHttpResponseProductId];
	NSString *cityCo			= [dic objectForKey:kHttpResponseCityCode];
    NSString *xsecStr           = [dic objectForKey:kHttpResponseSectionCode];
	NSString *hasStor			= [dic objectForKey:kHttpResponseHasStorage];
	NSString *canTak			= [dic objectForKey:kHttpResponseCanTake];
	NSString *isOToN			= [dic objectForKey:kHttpResponseIsOldToNew];
	NSString *annex				= [dic objectForKey:kHttpResponseHasAnnex];
	NSString *markPrice			= [dic objectForKey:kHttpResponseMarketPrice];
    NSString *proPrice          = [dic objectForKey:kHttpResponsePromotionPrice];
//	NSString *snPrice			= [dic objectForKey:kHttpResponseSuningPrice];
//    NSString *itemPrice         = [dic objectForKey:kHttpResponseItemPrice];
    NSString *netPrice          = [dic objectForKey:kHttpResponseHomeTopProductPrice];
	NSString *proFeature		= [dic objectForKey:kHttpResponseProductFeature];
	NSString *pacList			= [dic objectForKey:kHttpResponsePackageList];
	NSString *star				= [dic objectForKey:kHttpResponseEvaluation];
	NSString *listPrice			= [dic objectForKey:kHttpResponseListPrice];
	NSString *user              = [dic objectForKey:kHttpResponseUserId];
	NSString *ship				= [dic objectForKey:kHttpResponseShipOffSet];
    NSString *shipOffSetText    = [dic objectForKey:kHttpResponseShipOffSetText];
	
	NSString *time              = [dic objectForKey:kResponseMemberCollectTime];
	
	NSString *specialWords      = [dic objectForKey:kHttpRequestSearchSpecial];
	
	NSString *isSent			= [dic objectForKey:kHttpResponseIsProducerSent];
    
    NSString *isBook           = [dic objectForKey:kHttpResponseIsABook];
    
    NSString *currColor         = [dic objectForKey:@"colorCur"];
    NSArray  *colorArray        = [dic objectForKey:@"colorItemList"];
    NSString *currVersion       = [dic objectForKey:@"versionCur"];
    NSString *versionDes        = [dic objectForKey:@"versionDesc"];
    NSArray  *versionArray      = [dic objectForKey:@"versionItemList"];
    NSArray  *coloVerMap        = [dic objectForKey:@"colorVersionMap"];
    
    NSString *commentCounts           = [dic objectForKey:@"articleCount"];
    NSString *advisoryCounts           = [dic objectForKey:@"zixunCount"];
    NSString *showOrdeCounts           = [dic objectForKey:@"shaidanCount"];
    NSString *zixunCounts            = [dic objectForKey:@"zixunCount"];
    
    NSString *goodevaluates           = [dic objectForKey:@"goodevaluate"];
    NSString *midEvaluates           = [dic objectForKey:@"midEvaluate"];
    NSString *badEvaluates           = [dic objectForKey:@"badEvaluate"];
    
    NSString *powerFlgOrAmtTemp = [dic objectForKey:@"powerFlgOrAmt"];
    NSString *__qianggouPrice = [dic objectForKey:@"qianggouPrice"];
    NSString *__tuangouPrice = [dic objectForKey:@"tuangouPrice"];
	
    NSString *___promIcon = EncodeStringFromDic(dic, @"promIcon");//[dic objectForKey:@"promIcon"];
    
    NSString *countOfarticle = [dic objectForKey:@"countOfarticle"];

    if(NotNilAndNull(___promIcon)){
		self.promIcon = ___promIcon;
	}
    
	if(NotNilAndNull(imageNumber)){
		self.imageNum = imageNumber;
	}	
    
	if (NotNilAndNull(proName)) {
        self.productName = proName;
        DLog(@"%@", self.productName);
	}
	if (NotNilAndNull(proCode)) {
		self.productCode = proCode;
	}
	if (NotNilAndNull(proId)) {
		self.productId = proId;
	}
	if (NotNilAndNull(cityCo)) {
		self.cityCode = cityCo;
	}
    if (!IsStrEmpty(xsecStr)) {
        self.xsection = xsecStr;
    }
	if (NotNilAndNull(hasStor)) {
		self.hasStorage = hasStor;
	}
	if (NotNilAndNull(canTak)) {
		self.canTake = canTak;
	}
	if (NotNilAndNull(isOToN)) {
		self.isOldToNew = isOToN;
	}
	if (NotNilAndNull(annex)) {
		self.hasAnnex = annex;
	}
	if (NotNilAndNull(markPrice)) {
		self.marketPrice = [NSNumber numberWithFloat:[markPrice doubleValue]];
	}
    
    
    
    self.isCShop = [EncodeStringFromDic(dic, @"isCShop") isEqualToString:@"1"];
    
    if (NotNilAndNull(isBook) && [isBook isEqualToString:@"true"]) {
        self.isABook = YES;
    }else{
        self.isABook = NO;
    }
        
    if (!IsStrEmpty(proPrice)) {
        self.suningPrice = [NSNumber numberWithFloat:[proPrice doubleValue]];
        self.isOnlyNetPrice = NO;
    }
    else
    {
        self.suningPrice = [NSNumber numberWithFloat:[netPrice doubleValue]];
        self.isOnlyNetPrice = YES;
    }
    
    if (NotNilAndNull(netPrice)) {
        self.netPrice = [NSNumber numberWithFloat:[netPrice doubleValue]];
    }
    
	if (NotNilAndNull(proFeature)) {
		self.productFeature = proFeature;
	}
	if (NotNilAndNull(pacList) && !IsStrEmpty(pacList)) {
		self.packageList = pacList;
	}else{
        self.packageList = @"";
    }

	
	if (NotNilAndNull(star)) {
		self.evaluation =  star;
	}
	if (NotNilAndNull(user)) {
		self.userId = user;
	}
	if (NotNilAndNull(ship)) {
		self.shipOffset = ship;
	}
    if (NotNilAndNull(shipOffSetText)) {
        self.shipOffSetText = shipOffSetText;
    }
	
	if (NotNilAndNull(listPrice)) {
		NSNumber *priceNumber = [[NSNumber alloc] initWithFloat:[listPrice doubleValue]];
		self.price = priceNumber;
	}
	
	if (NotNilAndNull(time)) {
		self.collectTime = time;
	}
	
	if (NotNilAndNull(specialWords)) {
		self.special = [self deleteSpecalChar:specialWords];
	}
    
    if (NotNilAndNull(isSent) && [isSent isEqualToString:@"Y"]) {
        self.isSupportCash = YES;
    }else{
        self.isSupportCash = NO;
    }
    
    
	
    if (NotNilAndNull(commentCounts)) {
		self.commentCount = commentCounts;
	}
    
    if (NotNilAndNull(advisoryCounts)) {
		self.advisoryCount = advisoryCounts;
	}
    
    if (NotNilAndNull(showOrdeCounts)) {
		self.showOrdeCount = showOrdeCounts;
	}
    if (NotNilAndNull(zixunCounts)) {
        self.zixunCount = zixunCounts;
    }
    if (NotNilAndNull(goodevaluates)) {
		self.goodevaluate = goodevaluates;
	}
    if (NotNilAndNull(midEvaluates)) {
		self.midEvaluate = midEvaluates;
	}
    if (NotNilAndNull(badEvaluates)) {
		self.badEvaluate = badEvaluates;
	}
    
    
    //设置图片url
    [self assembleImageUrl];
    
    //商品簇
    if (NotNilAndNull(currColor)) {
        self.colorCurr = currColor;
    }
    if (NotNilAndNull(colorArray) && [colorArray count] > 0) {
        /*
         [{
            colorId : 颜色id
            colorNm : 颜色名称
         }]
         */
        self.colorItemList = colorArray;
    }
    if (NotNilAndNull(currVersion) && ![currVersion isEmptyOrWhitespace]) {
        self.versionCurr = currVersion;
    }
    if (NotNilAndNull(versionDes) && ![versionDes isEmptyOrWhitespace]) {
        self.versionDesc = versionDes;
    }
    if (NotNilAndNull(versionArray) && [versionArray count] > 0) {
        /*
         [{
            versionId : 版本id
            versionNm : 版本名称
         }]
         */
        self.versionItemList = versionArray;
    }
    if (NotNilAndNull(coloVerMap) && [coloVerMap count] > 0) {
        NSMutableArray *maps = [[NSMutableArray alloc] initWithCapacity:[coloVerMap count]];
        for (NSDictionary *item in coloVerMap){
            DataProductBasic *newProductBasic = [[DataProductBasic alloc] init];
            newProductBasic.cityCode = self.cityCode;
            newProductBasic.colorCurr = [item objectForKey:@"colorId"];
            newProductBasic.versionCurr = [item objectForKey:@"versionId"];
            newProductBasic.productId = [item objectForKey:@"productId"];
            newProductBasic.productCode = [item objectForKey:@"partNumber"];
            [maps addObject:newProductBasic];
        }
        self.colorVersionMap = maps;
    }
    if(NotNilAndNull(powerFlgOrAmtTemp)) {
		self.powerFlgOrAmt = powerFlgOrAmtTemp;
	}
    if (NotNilAndNull(__qianggouPrice)) {
        self.qianggouPrice = [NSNumber numberWithDouble:[__qianggouPrice doubleValue]];
    }
    if (NotNilAndNull(__tuangouPrice)) {
        self.tuangouPrice = [NSNumber numberWithDouble:[__tuangouPrice doubleValue]];
    }
    
    self.shopName = EncodeStringFromDic(dic, @"shopName");
    self.shopCode = EncodeStringFromDic(dic, @"shopCode");
    self.shopSize = EncodeStringFromDic(dic, @"shopSize");
    self.companyName = EncodeStringFromDic(dic, @"companyName");
    
    self.supplierNum = self.shopSize;
    self.shopGrade = EncodeStringFromDic(dic, @"shopGrade");
    self.serviceSatisfy = EncodeStringFromDic(dic, @"serviceSatisfy");
    self.deliverSpeed = EncodeStringFromDic(dic, @"deliverSpeed");
    self.sellerSpeed = EncodeStringFromDic(dic, @"sellerSpeed");
    self.fare = EncodeStringFromDic(dic, @"fare");
    
    //13-5-15新加
    self.productService = EncodeStringFromDic(dic, @"productService");
    NSString *saleOrgStr = EncodeStringFromDic(dic, @"salesOrg");
    if (IsStrEmpty(self.shopCode)) //自营商品才有销售组织
    {
        self.saleOrg = saleOrgStr;
    }
    else
    {
        self.saleOrg = @"";
    }
    NSString *packageTypeStr = EncodeStringFromDic(dic, @"packageType");
    if ([packageTypeStr isEqualToString:@"n"]) {
        self.packageType = PackageTypeNormal;
    }else if ([packageTypeStr isEqualToString:@"a"]){
        self.packageType = PackageTypeAccessory;
        
        //解析配件套餐
        NSArray *accessoryList = EncodeArrayFromDic(dic, @"accessoryPackageList");
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[accessoryList count]];
        for (NSDictionary *item in accessoryList)
        {
            AccessoryPackageDTO *dto = [[AccessoryPackageDTO alloc] init];
            dto.cityCode = self.cityCode;
            [dto encodeFromDictionary:item];
            [array addObject:dto];
        }
        self.accessoryPackageList = array;
        
        //因iPhone版只显示一个列表，故整合array;
        NSMutableArray *arrayAll = [NSMutableArray array];
        for (AccessoryPackageDTO *dto in self.accessoryPackageList)
        {
            for (DataProductBasic *innerProduct in dto.packageList)
            {
                [arrayAll addObject:innerProduct];
            }
        }
        self.allAccessoryProductList = arrayAll;
        
    }else if ([packageTypeStr isEqualToString:@"s"]){
        self.packageType = PackageTypeSmall;
        
        //解析小套餐
        NSArray *smallList = EncodeArrayFromDic(dic, @"smallPackageList");
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[smallList count]];
        for (NSDictionary *item in smallList)
        {
            DataProductBasic *dto = [[DataProductBasic alloc] init];
            dto.productId = EncodeStringFromDic(item, @"productId");
            dto.productCode = EncodeStringFromDic(item, @"partNumber");
            dto.productName = EncodeStringFromDic(item, @"productName");
            dto.suningPrice = EncodeNumberFromDic(item, @"productPrice");
            dto.cityCode = self.cityCode;
            dto.packageType = PackageTypeSmall;
            [array addObject:dto];
        }
        self.smallPackageList = array;
        
        self.primaryPrice = EncodeNumberFromDic(dic, @"primaryPrice");
        self.savePrice = EncodeNumberFromDic(dic, @"savePrice");
        self.smallPackagePrice = EncodeNumberFromDic(dic, @"packagePrice");
    }
    self.qianggouFlag = EncodeStringFromDic(dic, @"qianggouFlag");

    self.qianggouActId = EncodeStringFromDic(dic, @"qianggouActId");
    self.rushPurChan = EncodeStringFromDic(dic, @"rushPurChan");
    self.bookmarkFlag = EncodeStringFromDic(dic, @"bookmarkFlag");
    self.tuangouFlag = EncodeStringFromDic(dic, @"tuangouFlag");
    self.tuangouActId = EncodeStringFromDic(dic, @"tuangouActId");
    
    self.favourDesc = @"";//@"很火很火人；来就送；很火；偶哈哈；来就送；很火；偶哈哈；来就送；很火；偶哈哈；来就送；很火；偶哈哈；来就送；很火；偶哈哈";
    NSString *__vourcher = EncodeStringFromDic(dic, @"voucher");
    NSString *__couponProduct = EncodeStringFromDic(dic, @"couponProduct");
    NSString *__couponOrder = EncodeStringFromDic(dic, @"couponOrder");
    NSString *__point = EncodeStringFromDic(dic, @"point");
    NSString *__account = EncodeStringFromDic(dic, @"accountAddTotalAmt");
    
    NSString *accountAddTotalAmt = @"";
    if (!IsStrEmpty(__account) && ![__account isEqualToString:@"0"]) {
        accountAddTotalAmt = [NSString stringWithFormat:@"%@%@%@",L(@"Product_BuyReturn"),__account,L(@"CloudDiamond")];
    }
    [self addToString:__vourcher];
    [self addToString:__couponProduct];
    [self addToString:__couponOrder];
    [self addToString:__point];
    [self addToString:accountAddTotalAmt];
    if (!IsStrEmpty(self.favourDesc)) {
        if (IsStrEmpty(__account) || [__account isEqualToString:@"0"]) {
            self.favourDesc = [self.favourDesc substringToIndex:self.favourDesc.length-1];
        }
    }
    
    self.isRtnNoReason =[EncodeStringFromDic(dic, @"isRtnNoReason") isEqualToString:@"1"];
    //xmy 2013-10-17
    self.factorySendFlag = [EncodeStringFromDic(dic, @"factorySendFlag") isEqualToString:@"1"];
    self.isPublished = [EncodeStringFromDic(dic, @"isPublished") isEqualToString:@"true"];
    
    self.returnCate = EncodeStringFromDic(dic, @"returnCate");
    
    //刘坤在线客服字段
    self.thirdCategoryId = EncodeStringFromDic(dic, @"thirdCategoryId");
    self.catentryIds = EncodeStringFromDic(dic, @"catentryIds");
    self.vendorCode = EncodeStringFromDic(dic, @"vendorCode");
    self.vendorName = EncodeStringFromDic(dic, @"vendorName");
    
#warning 此版本屏蔽屏蔽C店套餐
    if (self.isCShop)
    {
        self.packageType = PackageTypeNormal;
//        self.favourDesc = @"";
    }
    
    self.quantity = 1;
    
    if (NotNilAndNull(countOfarticle))
        self.countOfarticle = countOfarticle;
}

- (void)addToString:(NSString *)string
{
    if (!IsStrEmpty(string)) {
        if (IsStrEmpty(self.favourDesc)) {
            self.favourDesc = string;
        }else{
            self.favourDesc = [NSString stringWithFormat:@"%@%@",self.favourDesc,string];
        }
    }
}

- (void)assembleImageUrl
{
    if (_productCode) {
        self.productImageURL = [ProductUtil getImageUrlWithProductCode:self.productCode size:ProductImageSize120x120];
    }

}

- (void)encodeSearchNoResSugProductFromDic:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    NSString *__productId = [dic objectForKey:@"productId"];
    if (NotNilAndNull(__productId))   self.productId = __productId;
    
    NSString *__partNumber = [dic objectForKey:@"partNumber"];
    if (NotNilAndNull(__partNumber))   self.productCode = __partNumber;
    
    NSString *__productName = [dic objectForKey:@"productName"];
    if (NotNilAndNull(__productName))   self.productName = __productName;
    
    NSString *__descriptions = [dic objectForKey:@"description"];
    if (NotNilAndNull(__descriptions))   self.special = [self deleteSpecalChar:__descriptions];
    
    NSString *__price = [dic objectForKey:@"price"];
    if (NotNilAndNull(__price))   self.price = [NSNumber numberWithDouble:[__price doubleValue]];
    
    [self assembleImageUrl];
}

- (void)encodeSearchResultProductFromDic:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    NSString *__productId = [dic objectForKey:@"catentryId"];
    if (NotNilAndNull(__productId))   self.productId = __productId;
    
    NSString *__partNumber = [dic objectForKey:@"partnumber"];
    if (NotNilAndNull(__partNumber))   self.productCode = __partNumber;
    
    NSString *__productName = [dic objectForKey:@"catentdesc"];
    if (NotNilAndNull(__productName))   self.productName = __productName;
    
    NSString *__descriptions = [dic objectForKey:@"auxdescription"];
    if (NotNilAndNull(__descriptions))   self.special = [self deleteSpecalChar:__descriptions];
    
    NSString *__price = [dic objectForKey:@"price"];
    if (NotNilAndNull(__price))   self.price = [NSNumber numberWithDouble:[__price doubleValue]];
    
    
    NSString *__articlePoint = [dic objectForKey:@"articlePoint"];
    if (NotNilAndNull(__articlePoint))   self.evaluation = __articlePoint;
    
    NSString *__catalogId = [dic objectForKey:@"catalogId"];
    if (NotNilAndNull(__catalogId) && [__catalogId isEqualToString:@"10051"]) {
        self.isABook = NO;
    }else{
        self.isABook = YES;
    }
    

//    示例："extenalFileds":{
//        "subs":"120759980|21138742|05漂白蓝,120759981|21138744|04月光绿,109627296|20582539|01白色,109627313|20582566|02绿色,109627314|20582561|03蓝色",
//        "mdmGroupId":"R6151002",
//        "subCatentryId":"21138742",
//        "subPartnumber":"120759980"
//    },
//    partnumber
    
//    NSDictionary *extendFields = [dic objectForKey:@"extenalFields"];
//    if ([extendFields objectForKey:@"subs"]) //是通码产品
//    {
//        self.isTongmaProduct = YES;
//        
//        //获取商品子码 chupeng 2014-5-9
//        NSString *partnumber = [dic objectForKey:@"subPartnumber"];
//        if (NotNilAndNull(partnumber))
//            self.partnumber = partnumber;
//    }
//    else //不是通码产品
//    {
//        self.isTongmaProduct = NO;
//    }
//    
    //评价数量
    NSString *countOfarticle = [dic objectForKey:@"countOfarticle"];
    if (NotNilAndNull(countOfarticle))
        self.countOfarticle = countOfarticle;
    
    
    self.supplierNum = EncodeStringFromDic(dic, @"supplierNum");
    self.shopSize = self.supplierNum;
    self.bestPrice = EncodeNumberFromDic(dic, @"bestPrice");
    self.inventory = EncodeStringFromDic(dic, @"inventory");
    self.allInventory = EncodeStringFromDic(dic, @"allInventory");
    
    [self assembleImageUrl];
    
    //促销活动，如果开关开了的话
    NSString *sscxkg = [SNSwitch getSearchPromotionValue];
    if (NotNilAndNull(sscxkg))
    {
        if ([sscxkg isEqualToString:@"1"])
        {
            [self parseItemOfsscxkgSwitchValueOf1:dic];
        }
        else if ([sscxkg isEqualToString:@"2"])
        {
            [self parseItemOfsscxkgSwitchValueOf2:dic];
        }
    }
    
}

- (void)parseItemOfsscxkgSwitchValueOf2:(NSDictionary *)dic
{
    if ([dic objectForKey:@"extenalFileds"] && [[dic objectForKey:@"extenalFileds"] isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *extenalFileds = [dic objectForKey:@"extenalFileds"];
        
        if ([extenalFileds objectForKey:@"bigPolys"] && [[extenalFileds objectForKey:@"bigPolys"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *bigPolys = [extenalFileds objectForKey:@"bigPolys"];
            NSString *strActivityId = [bigPolys strValue:@"activityId"];
            NSString *channelId = [bigPolys strValue:@"channelId"];
            NSString *vendor = [bigPolys strValue:@"vendor"];
            
            
            self.activityId = strActivityId;
            self.channelId = channelId;
            self.vendor = vendor;
            
        }
        
        if ([extenalFileds strValue:@"orderInfo"])
        {
            self.yuyueOrderInfo = [extenalFileds strValue:@"orderInfo"];
        }
    }
}

- (void)parseItemOfsscxkgSwitchValueOf1:(NSDictionary *)dic
{
    NSArray *arr = EncodeArrayFromDic(dic, @"activityInfo");
    if (arr != nil && arr.count > 0)
    {
        float minPrice = 0;
        BOOL firstValue = YES;
        for (NSDictionary *dic in arr) {
            SearchPromotionActivityDto *dto = [[SearchPromotionActivityDto alloc] init];
            dto.activityTypeId = EncodeStringFromDic(dic, @"activityTypeId");
            dto.salesPrice = EncodeStringFromDic(dic, @"salesPrice");
            
            if (dto.salesPrice != nil)
            {
                if (firstValue && [dto.salesPrice floatValue] > 0)
                {
                    minPrice = [dto.salesPrice floatValue];
                    firstValue = NO;
                }
                else if ([dto.salesPrice floatValue] < minPrice && [dto.salesPrice floatValue] > 0)
                    minPrice = [dto.salesPrice floatValue];
            }
            
            int typeID = [dto.activityTypeId intValue];
            switch (typeID) {
                case 1:
                {
                    self.flagOfPromotionImgView |= Qiang;
                    break;
                }
                case 2:
                {
                    self.flagOfPromotionImgView |= Tuan;
                    break;
                }
                case 3:
                {
                    self.flagOfPromotionImgView |= Quan;
                    break;
                }
                case 4:
                {
                    self.flagOfPromotionImgView |= Jiang;
                    break;
                }
                default:
                    break;
            }
            //                int k = self.flagOfPromotionImgView;
            [self.activityInfoArray addObject:dto];
        }
        
        //最小促销价格
        self.minPriceOfPromotion = [NSString stringWithFormat:@"%0.02f", minPrice];
    }
}

- (SearchMtsPromotionDataService *)promotionService
{
    if (!_promotionService)
    {
        _promotionService = [[SearchMtsPromotionDataService alloc] init];
        _promotionService.parentDto = self;
    }
    return _promotionService;
}

//使用mts一拖2接口发送促销请求
- (void)beginGetPromotionInfo
{
    if ([[SNSwitch getSearchPromotionValue] isEqualToString:@"2"])
    {
        NSString *productCode = [self.productCode substringFromIndex:9];
        [self.promotionService beginGetMtsPromotionInfoWithProductID:self.productId productCode:productCode bigPoloyActivityID:self.activityId bigPoloyVendor:self.vendor orderInfo:self.yuyueOrderInfo];

        
    }
}

- (void)cancelPromotionRequest
{
    if ([[SNSwitch getSearchPromotionValue] isEqualToString:@"2"])
    {
        [self.promotionService cancelRequest];
    }
}

- (int)selectAccessoryProductCount
{
    int count = 0;
    if (self.packageType == PackageTypeAccessory)
    {
        for (DataProductBasic *dto in self.allAccessoryProductList)
        {
            count += dto.isAccessorySelect;
        }
    }
    return count;
}

- (double)accessoryDiscount
{
    double discount = 0.0;
    if (self.packageType == PackageTypeAccessory)
    {
        for (DataProductBasic *dto in self.allAccessoryProductList)
        {
            if (dto.isAccessorySelect)
            {
                double d = [dto.suningPrice doubleValue] - [dto.accessoryPackagePrice doubleValue];
                discount += d;
            }
        }
    }
    return discount;
}

- (double)totalPrice
{
    double price = 0.0;
    if (self.packageType == PackageTypeAccessory)
    {
        unsigned int count = [self.allAccessoryProductList count];
        
        price += [self.suningPrice doubleValue] * self.quantity;
        
        for (int i = 0; i < count; i++)
        {
            DataProductBasic *pro = [self.allAccessoryProductList objectAtIndex:i];
            
            if (pro.isAccessorySelect) {
                price += [pro.accessoryPackagePrice doubleValue];
            }
        }
    }
    return price;
}

- (NSArray *)selectedAccessoryList
{
    if (self.packageType == PackageTypeAccessory)
    {
        NSArray *accessoryList = self.allAccessoryProductList;
        NSMutableArray *array = [NSMutableArray array];
        for (DataProductBasic *innerProduct in accessoryList)
        {
            //被选中
            if (innerProduct.isAccessorySelect)
            {
                [array addObject:innerProduct];
            }
        }
        return array;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.imageNum forKey:kHttpResponseImageNum];
    [aCoder encodeObject:self.productName forKey:kHttpResponseProductName];
    [aCoder encodeObject:self.productCode forKey:kHttpResponseProductCode];
    [aCoder encodeObject:self.productId forKey:kHttpResponseProductId];
    [aCoder encodeObject:self.cityCode forKey:kHttpResponseCityCode];
    [aCoder encodeObject:self.xsection forKey:kHttpResponseSectionCode];
    [aCoder encodeObject:self.hasStorage forKey:kHttpResponseHasStorage];
    [aCoder encodeObject:self.canTake forKey:kHttpResponseCanTake];
    [aCoder encodeObject:self.isOldToNew forKey:kHttpResponseIsOldToNew];
    [aCoder encodeObject:self.hasAnnex forKey:kHttpResponseHasAnnex];
    [aCoder encodeObject:self.marketPrice forKey:kHttpResponseMarketPrice];
    [aCoder encodeObject:self.suningPrice forKey:kHttpResponseSuningPrice];
    [aCoder encodeObject:self.itemPrice forKey:kHttpResponseItemPrice];
    [aCoder encodeObject:self.netPrice forKey:kHttpResponseHomeTopProductPrice];
    [aCoder encodeObject:[NSNumber numberWithBool: self.isOnlyNetPrice] forKey:@"isOnlyNetPrice"];
    [aCoder encodeObject:self.productFeature forKey:kHttpResponseProductFeature];
    [aCoder encodeObject:self.packageList forKey:kHttpResponsePackageList];
    [aCoder encodeObject:self.evaluation forKey:kHttpResponseEvaluation];
    [aCoder encodeObject:self.price forKey:kHttpResponseListPrice];
    [aCoder encodeObject:self.userId forKey:kHttpResponseUserId];
    [aCoder encodeObject:self.shipOffset forKey:kHttpResponseShipOffSet];
    [aCoder encodeObject:self.shipOffSetText forKey:kHttpResponseShipOffSetText];
    [aCoder encodeObject:self.collectTime forKey:kResponseMemberCollectTime];
    [aCoder encodeObject:self.special forKey:kHttpRequestSearchSpecial];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isSupportCash] forKey:kHttpResponseIsProducerSent];
    [aCoder encodeObject:self.productImageURL forKey:@"productImageURL"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.ProductNum] forKey:@"ProductNumber"];
    [aCoder encodeObject:[NSNumber numberWithBool: self.isABook] forKey:kHttpResponseIsABook];
    
    [aCoder encodeObject:self.colorCurr forKey:@"colorCurrent"];
    [aCoder encodeObject:self.colorItemList forKey:@"colorItemList"];
    [aCoder encodeObject:self.versionCurr forKey:@"versionCurrent"];
    [aCoder encodeObject:self.versionDesc forKey:@"versionDesc"];
    [aCoder encodeObject:self.versionItemList forKey:@"versionItemList"];
    [aCoder encodeObject:self.colorVersionMap forKey:@"colorVersionMap"];
    
    [aCoder encodeObject:self.commentCount forKey:@"commentCount"];
    [aCoder encodeObject:self.advisoryCount forKey:@"advisoryCount"];
    [aCoder encodeObject:self.showOrdeCount forKey:@"showOrdeCount"];
    [aCoder encodeObject:self.zixunCount forKey:@"zixunCount"];
    [aCoder encodeObject:self.goodevaluate forKey:@"goodevaluate"];
    [aCoder encodeObject:self.midEvaluate forKey:@"midEvaluate"];
    [aCoder encodeObject:self.badEvaluate forKey:@"badEvaluate"];
    
    [aCoder encodeObject:self.powerFlgOrAmt forKey:@"powerFlgOrAmt"];
    [aCoder encodeObject:self.qianggouPrice forKey:@"qianggouPrice"];
    [aCoder encodeObject:self.tuangouPrice forKey:@"tuangouPrice"];

    
    [aCoder encodeObject:self.quickbuyId forKey:@"quickbuyId"];
    [aCoder encodeObject:self.rushProcessId forKey:@"rushProcessId"];
    [aCoder encodeObject:self.danjiaGroupId forKey:@"danjiaGroupId"];
    
    [aCoder encodeObject:self.productService forKey:@"productService"];
    [aCoder encodeObject:self.saleOrg forKey:@"saleOrg"];
    [aCoder encodeObject:__INT(self.packageType) forKey:@"packageType"];
    [aCoder encodeObject:self.accessoryPackageList forKey:@"accessoryPackageList"];
    [aCoder encodeObject:self.smallPackageList forKey:@"smallPackageList"];
    [aCoder encodeObject:self.accessoryPackagePrice forKey:@"accessoryPackagePrice"];
    [aCoder encodeObject:self.masocceceId forKey:@"masocceceId"];
    [aCoder encodeObject:__INT(self.isAccessorySelect) forKey:@"isAccessorySelect"];
    [aCoder encodeObject:self.primaryPrice forKey:@"primaryPrice"];
    [aCoder encodeObject:self.savePrice forKey:@"savePrice"];
    [aCoder encodeObject:self.smallPackagePrice forKey:@"smallPackagePrice"];
    [aCoder encodeObject:self.qianggouActId forKey:@"qianggouActId"];
    [aCoder encodeObject:self.qianggouFlag forKey:@"qianggouFlag"];
    [aCoder encodeObject:self.bookmarkFlag forKey:@"bookmarkFlag"];

    [aCoder encodeObject:self.tuangouActId forKey:@"tuangouActId"];
    [aCoder encodeObject:self.tuangouFlag forKey:@"tuangouFlag"];

    [aCoder encodeObject:self.favourDesc forKey:@"favourDesc"];
    
    [aCoder encodeObject:self.supplierNum forKey:@"supplierNum"];
    [aCoder encodeObject:self.bestPrice forKey:@"bestPrice"];
    [aCoder encodeObject:self.inventory forKey:@"inventory"];
    [aCoder encodeObject:self.allInventory forKey:@"allInventory"];
    
    
    [aCoder encodeObject:self.shopName forKey:@"shopName"];
    [aCoder encodeObject:self.shopCode forKey:@"shopCode"];
    [aCoder encodeObject:self.shopSize forKey:@"shopSize"];
    [aCoder encodeObject:self.shopGrade forKey:@"shopGrade"];
    [aCoder encodeObject:self.serviceSatisfy forKey:@"serviceSatisfy"];
    [aCoder encodeObject:self.deliverSpeed forKey:@"deliverSpeed"];
    [aCoder encodeObject:self.sellerSpeed forKey:@"sellerSpeed"];
    [aCoder encodeObject:self.fare forKey:@"fare"];
    [aCoder encodeObject:@(self.isCShop) forKey:@"isCShop"];

    [aCoder encodeObject:@(self.isJuhui) forKey:@"isJuhui"];
    [aCoder encodeObject:self.juhuiPrice forKey:@"juhuiPrice"];
    
    [aCoder encodeObject:self.appointPrice forKey:@"appointPrice"];
    [aCoder encodeObject:self.appointActivityId forKey:@"appointActivityId"];
    
    [aCoder encodeObject:self.scScodeActivetyId forKey:@"scScodeActivetyId"];
    
    [aCoder encodeObject:@(self.isPublished) forKey:@"isPublished"];
    [aCoder encodeObject:@(self.isRtnNoReason) forKey:@"isRtnNoReason"];
    [aCoder encodeObject:@(self.factorySendFlag) forKey:@"factorySendFlag"];
    [aCoder encodeObject:self.returnCate forKey:@"returnCate"];

    [aCoder encodeObject:self.rushPurChan forKey:@"rushPurChan"];
    
    [aCoder encodeObject:self.thirdCategoryId forKey:@"thirdCategoryId"];
    [aCoder encodeObject:self.catentryIds forKey:@"catentryIds"];
    [aCoder encodeObject:self.vendorCode forKey:@"vendorCode"];
    [aCoder encodeObject:self.vendorName forKey:@"vendorName"];
    
    [aCoder encodeObject:self.limitBuyNum forKey:@"limitBuyNum"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init])
    {
        
        self.imageNum = [aDecoder decodeObjectForKey:kHttpResponseImageNum];
        self.productName = [aDecoder decodeObjectForKey:kHttpResponseProductName];
        self.productCode = [aDecoder decodeObjectForKey:kHttpResponseProductCode];
        self.productId = [aDecoder decodeObjectForKey:kHttpResponseProductId];
        self.cityCode = [aDecoder decodeObjectForKey:kHttpResponseCityCode];
        self.xsection = [aDecoder decodeObjectForKey:kHttpResponseSectionCode];
        self.hasStorage = [aDecoder decodeObjectForKey:kHttpResponseHasStorage];
        self.canTake = [aDecoder decodeObjectForKey:kHttpResponseCanTake];
        self.isOldToNew = [aDecoder decodeObjectForKey:kHttpResponseIsOldToNew];
        self.hasAnnex = [aDecoder decodeObjectForKey:kHttpResponseHasAnnex];
        self.marketPrice = [aDecoder decodeObjectForKey:kHttpResponseMarketPrice];
        self.suningPrice = [aDecoder decodeObjectForKey:kHttpResponseSuningPrice];
        self.itemPrice = [aDecoder decodeObjectForKey:kHttpResponseItemPrice];
        self.netPrice = [aDecoder decodeObjectForKey:kHttpResponseHomeTopProductPrice];
        self.isOnlyNetPrice = [(NSNumber *)[aDecoder decodeObjectForKey:@"isOnlyNetPrice"] boolValue];
        self.productFeature = [aDecoder decodeObjectForKey:kHttpResponseProductFeature];
        self.packageList = [aDecoder decodeObjectForKey:kHttpResponsePackageList];
        self.evaluation = [aDecoder decodeObjectForKey:kHttpResponseEvaluation];
        self.price = [aDecoder decodeObjectForKey:kHttpResponseListPrice];
        self.userId = [aDecoder decodeObjectForKey:kHttpResponseUserId];
        self.shipOffset = [aDecoder decodeObjectForKey:kHttpResponseShipOffSet];
        self.shipOffSetText = [aDecoder decodeObjectForKey:kHttpResponseShipOffSetText];
        self.collectTime = [aDecoder decodeObjectForKey:kResponseMemberCollectTime];
        self.special = [aDecoder decodeObjectForKey:kHttpRequestSearchSpecial];
        self.isSupportCash = [(NSNumber *)[aDecoder decodeObjectForKey:kHttpResponseIsProducerSent] boolValue];
        self.productImageURL = [aDecoder decodeObjectForKey:@"productImageURL"];
        self.ProductNum = [(NSNumber *)[aDecoder decodeObjectForKey:@"ProductNumber"] integerValue];
        self.isABook = [(NSNumber *)[aDecoder decodeObjectForKey:kHttpResponseIsABook]boolValue];
        
        self.colorCurr = [aDecoder decodeObjectForKey:@"colorCurrent"];
        self.colorItemList = [aDecoder decodeObjectForKey:@"colorItemList"];
        self.versionCurr = [aDecoder decodeObjectForKey:@"versionCurrent"];
        self.versionDesc = [aDecoder decodeObjectForKey:@"versionDesc"];
        self.versionItemList = [aDecoder decodeObjectForKey:@"versionItemList"];
        self.colorVersionMap = [aDecoder decodeObjectForKey:@"colorVersionMap"];
        
        self.commentCount = [aDecoder decodeObjectForKey:@"commentCount"];
        self.advisoryCount = [aDecoder decodeObjectForKey:@"advisoryCount"];
        self.showOrdeCount = [aDecoder decodeObjectForKey:@"showOrdeCount"];
        self.zixunCount = [aDecoder decodeObjectForKey:@"zixunCount"];
        self.goodevaluate = [aDecoder decodeObjectForKey:@"goodevaluate"];
        self.midEvaluate = [aDecoder decodeObjectForKey:@"midEvaluate"];
        self.badEvaluate = [aDecoder decodeObjectForKey:@"badEvaluate"];
        
        self.powerFlgOrAmt = [aDecoder decodeObjectForKey:@"powerFlgOrAmt"];
        self.qianggouPrice = [aDecoder decodeObjectForKey:@"qianggouPrice"];
        self.tuangouPrice  = [aDecoder decodeObjectForKey:@"tuangouPrice"];
        
        self.quickbuyId = [aDecoder decodeObjectForKey:@"quickbuyId"];
        self.rushProcessId = [aDecoder decodeObjectForKey:@"rushProcessId"];
        self.danjiaGroupId = [aDecoder decodeObjectForKey:@"danjiaGroupId"];
        
        self.productService = [aDecoder decodeObjectForKey:@"productService"];
        self.saleOrg = [aDecoder decodeObjectForKey:@"saleOrg"];
        self.packageType = [[aDecoder decodeObjectForKey:@"packageType"] intValue];
        self.accessoryPackageList = [aDecoder decodeObjectForKey:@"accessoryPackageList"];
        self.smallPackageList = [aDecoder decodeObjectForKey:@"smallPackageList"];
        self.accessoryPackagePrice = [aDecoder decodeObjectForKey:@"accessoryPackagePrice"];
        self.masocceceId = [aDecoder decodeObjectForKey:@"masocceceId"];
        self.isAccessorySelect = [[aDecoder decodeObjectForKey:@"isAccessorySelect"] boolValue];
        self.primaryPrice = [aDecoder decodeObjectForKey:@"primaryPrice"];
        self.savePrice = [aDecoder decodeObjectForKey:@"savePrice"];
        self.smallPackagePrice = [aDecoder decodeObjectForKey:@"smallPackagePrice"];
        self.qianggouFlag = [aDecoder decodeObjectForKey:@"qianggouFlag"];
        self.qianggouActId = [aDecoder decodeObjectForKey:@"qianggouActId"];
        self.bookmarkFlag = [aDecoder decodeObjectForKey:@"bookmarkFlag"];
        
        self.tuangouFlag = [aDecoder decodeObjectForKey:@"tuangouFlag"];
        self.tuangouActId = [aDecoder decodeObjectForKey:@"tuangouActId"];

        self.favourDesc = [aDecoder decodeObjectForKey:@"favourDesc"];
        
        self.shopName = [aDecoder decodeObjectForKey:@"shopName"];
        self.shopCode = [aDecoder decodeObjectForKey:@"shopCode"];
        self.shopSize = [aDecoder decodeObjectForKey:@"shopSize"];
        self.shopGrade = [aDecoder decodeObjectForKey:@"shopGrade"];
        self.serviceSatisfy = [aDecoder decodeObjectForKey:@"serviceSatisfy"];
        self.deliverSpeed = [aDecoder decodeObjectForKey:@"deliverSpeed"];
        self.sellerSpeed = [aDecoder decodeObjectForKey:@"sellerSpeed"];
        self.fare = [aDecoder decodeObjectForKey:@"fare"];
        self.isCShop = [[aDecoder decodeObjectForKey:@"isCShop"] boolValue];
        
        self.supplierNum = [aDecoder decodeObjectForKey:@"supplierNum"];
        self.bestPrice = [aDecoder decodeObjectForKey:@"bestPrice"];
        self.inventory = [aDecoder decodeObjectForKey:@"inventory"];
        self.allInventory = [aDecoder decodeObjectForKey:@"allInventory"];
        
        self.isJuhui = [[aDecoder decodeObjectForKey:@"isJuhui"] boolValue];
        self.juhuiPrice = [aDecoder decodeObjectForKey:@"juhuiPrice"];
        
        self.appointActivityId = [aDecoder decodeObjectForKey:@"appointActivityId"];
        self.appointPrice = [aDecoder decodeObjectForKey:@"appointPrice"];
        
        self.scScodeActivetyId = [aDecoder decodeObjectForKey:@"scScodeActivetyId"];

        self.factorySendFlag = [[aDecoder decodeObjectForKey:@"factorySendFlag"] boolValue];
        self.isPublished = [[aDecoder decodeObjectForKey:@"isPublished"] boolValue];
        self.isRtnNoReason = [[aDecoder decodeObjectForKey:@"isRtnNoReason"] boolValue];
        self.returnCate = [aDecoder decodeObjectForKey:@"returnCate"];
        
        self.rushPurChan = [aDecoder decodeObjectForKey:@"rushPurChan"];
        
        self.thirdCategoryId = [aDecoder decodeObjectForKey:@"thirdCategoryId"];
        self.catentryIds = [aDecoder decodeObjectForKey:@"catentryIds"];
        self.vendorCode = [aDecoder decodeObjectForKey:@"vendorCode"];
        self.vendorName = [aDecoder decodeObjectForKey:@"vendorName"];

        self.limitBuyNum = [aDecoder decodeObjectForKey:@"limitBuyNum"];
    }
    
    return self;
}

-(void)initData
{
    //robin
    self.ProductNum = 1;
    self.sendType = 1;
    self.isProducerSent = self.isSupportCash;
    self.isService = NO;
}

/*因商品详情的描述是productFeature，则在赋予productFeature同时赋给speal*/

- (void)setProductFeature:(NSString *)productFeature
{
    if (productFeature != _productFeature)
    {
        
        _productFeature = [productFeature copy];
        
        self.special = [self deleteSpecalChar: _productFeature];
    }
}

//请求完详情的价格反赋给price
- (void)setSuningPrice:(NSNumber *)suningPrice
{
    if (suningPrice != _suningPrice)
    {
        
        _suningPrice = [suningPrice copy];
        
        self.price = _suningPrice;
    }
}

//补全productCode
- (void)setProductCode:(NSString *)productCode
{
    if (_productCode != productCode) {
        
        if (productCode.length && productCode.length != 18) {
            productCode = [NSString stringWithFormat:@"%018d",[productCode integerValue]];
        }
        _productCode = productCode;
    }
}

//是否有商品簇
- (BOOL)hasClustor
{
    if ((self.colorCurr == nil || [self.colorCurr isEmptyOrWhitespace]) &&
        (self.versionCurr == nil || [self.versionCurr isEmptyOrWhitespace]))
    {
        return NO;
    }
    return YES;
}

//是否是套餐商品
- (BOOL)hasPackageList
{
    if (self.packageType == PackageTypeAccessory)
    {
        return [self.accessoryPackageList count] > 0 ? YES : NO;
    }
    else if (self.packageType == PackageTypeSmall)
    {
        return [self.smallPackageList count] > 0 ? YES : NO;
    }
    return NO;
}

- (BOOL)hasSunOrder
{
    //图书商品和小套餐没有晒单
    if (self.isABook || self.packageType == PackageTypeSmall)
    {
        return NO;
    }
    return YES;
}

- (BOOL)hasQianGouing
{
    if ([self.qianggouFlag isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}


-(NSString*)deleteSpecalChar:(NSString*)str
{
    
    str = [str stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"&nbs" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"&nb" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"&n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return str;
}

@end


@implementation AccessoryPackageDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.groupName = EncodeStringFromDic(dic, @"groupName");
    self.size = EncodeStringFromDic(dic, @"size");
    
    NSArray *packages = [dic objectForKey:@"packages"];
    
    if ([packages count] > 0)
    {
        NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:[packages count]];
        for (NSDictionary *item in packages)
        {
            DataProductBasic *product = [[DataProductBasic alloc] init];
            product.suningPrice = EncodeNumberFromDic(item, @"egoPrice");
            product.accessoryPackagePrice = EncodeNumberFromDic(item, @"packagePrice");
            product.productCode = EncodeStringFromDic(item, @"partNumber");
            product.productId = EncodeStringFromDic(item, @"productId");
            product.masocceceId = EncodeStringFromDic(item, @"massocceceId");
            product.productName = EncodeStringFromDic(item, @"productName");
            product.saleOrg = EncodeStringFromDic(item, @"saleOrg");
            product.cityCode = self.cityCode;
            product.packageType = PackageTypeAccessory;
            [temp addObject:product];
        }
        
        self.packageList = temp;
    }
}



- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cityCode forKey:@"cityCode"];
    [aCoder encodeObject:self.groupName forKey:@"groupName"];
    [aCoder encodeObject:self.size forKey:@"size"];
    [aCoder encodeObject:self.packageList forKey:@"packageList"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.cityCode = [aDecoder decodeObjectForKey:@"cityCode"];
        self.groupName = [aDecoder decodeObjectForKey:@"groupName"];
        self.size = [aDecoder decodeObjectForKey:@"size"];
        self.packageList = [aDecoder decodeObjectForKey:@"packageList"];
    }
    return self;
}

@end



@implementation SearchPromotionActivityDto


@end


