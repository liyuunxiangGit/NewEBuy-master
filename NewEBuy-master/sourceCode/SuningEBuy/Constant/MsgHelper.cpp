//
//  MsgHelper.c
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-5.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#include <stdio.h>
#include "MsgConstant.h"
#include "MsgHelper.h"
#define KLen sizeof(CC_NEED_LOGIN_QUEUE)/sizeof(int)
//static int flag = 0;
static int partition(int a[],int l,int r)
{
    int v = CC_NEED_LOGIN_QUEUE[r];
    while (l < r)
    {
        while ((l < r)&&(a[l] <= v))++l;
        a[r] = a[l];
        while (((l < r))&&(v <= a[r]))--r;
        a[l] = a[r];
        
    }
    a[r] = v;
    return r;
}

//r = KLen-1;l = 0;
void CC_Sort_Data(int a[], int l,int r)
{
    if (l < r)
    {
        int i = partition(a,l,r);
        CC_Sort_Data(a,l,i - 1);
        CC_Sort_Data(a,i + 1,r);
    }
}

bool CC_Search_Data(int a[],int cmdCode)
{
    int l = 0;
    int r = KLen - 1;
    int mid = 0;
    while (l <= r)
    {
        mid = (r+l)/2;
        if (a[mid] == cmdCode)
        {
           return true;
        }
        if (a[mid] < cmdCode)
        {
            l = mid + 1;
        }
        else  if (a[mid] > cmdCode)
        {
            r = mid - 1;
        }
    }
    return false;
}

bool CC_Login_Contain(int cmdCode)
{
    int length = sizeof(CC_NEED_LOGIN_QUEUE)/sizeof(int);
    for (int i = 0; i < length; i++)
    {
        if (cmdCode == CC_NEED_LOGIN_QUEUE[i]) {
            return true;
        }
    }
    return false;
}


bool CC_Need_Cookie_Contain(int cmdCode)
{
    int length = sizeof(CC_NEED_COOKIE_QUEUE)/sizeof(int);
    for (int i = 0; i < length; i++)
    {
        if (cmdCode == CC_NEED_COOKIE_QUEUE[i]) {
            return true;
        }
    }
    return false;
}

bool CC_Can_Compress(int cmdCode)
{
    if (cmdCode == CC_LotteryHall ||
        cmdCode == CC_LotteryOrderDetail ||
        cmdCode == CC_LotteryOrderList ||
        cmdCode == CC_TicketPayment ||
        cmdCode == CC_ProductDetail ||
        cmdCode == CC_DMOrder ||
        cmdCode == CC_RegistrationPrepare ||
        cmdCode == CC_RegistrationDetail ||
        cmdCode == CC_StoresRegistration ||
        cmdCode == CC_UserFeedback ||
        cmdCode == CC_EvaluatePublish ||
        cmdCode == CC_HomeSignPic ||
        cmdCode == CC_Login ||
        cmdCode == CC_ShopOrderList)
    {
        return false;
    }
    return true;
}