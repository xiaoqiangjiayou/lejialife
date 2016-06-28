//
//  Netinterface.h
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#ifndef Netinterface_h
#define Netinterface_h
#define BAIDUAK  @"sBrSreGsNg3DuB8NMm9uw1TrqA55t6QA"
//友盟appkey
#define YMAPPKEY @"575787c7e0f55ac8dc000452"
//微信appid
#define WXAPPID @"wx33a3dfdf616041a6"
//微信api密匙
#define WXSECRECT @"fdade8409ebf3f22470764d1401739a3"
//商户号
#define WXMECRENT @"1328668401"

#define SNACKSLIST @"http://123.57.185.8/shop/product?page=%ld&productType=1"
#define FURNISHING @"http://123.57.185.8/shop/product?page=%ld&productType=2"
#define LIFELIST   @"http://123.57.185.8/shop/product?page=%ld&productType=3"
#define KITCHENLIFT @"http://123.57.185.8/shop/product?page=%ld&productType=4"
#define SNACKDETAILLIST @"http://123.57.185.8/shop/product/%ld"
//详情立即购买
#define SNACKDETAILCREATORDER @"http://123.57.185.8/order/confirm"
//首页及周边商家列表
#define MERCHANT @"http://123.57.185.8/merchant/reload"
//商家详情
#define MERCHANTDETAIL @"http://123.57.185.8/merchant/detail"

//打开软件
#define HOME @"http://123.57.185.8/user/open"
//
#define TOPIC @"http://123.57.185.8/topic/list?page=%ld"
//登录
#define LOGIN @"http://123.57.185.8/user/login"
//我的订单
#define MYORDER @"http://123.57.185.8/order/orderList"
//发送手机号(获取验证码)
#define SENDPHONENUMBER @"http://123.57.185.8/user/sendCode"

//发送验证码(提交验证码)
#define SENDCODE @"http://123.57.185.8/user/register"
//设置密码
#define SETPASSWORD @"http://123.57.185.8/user/setPwd"
//收货地址列表
#define ADDRESSLIST @"http://123.57.185.8/address/list"
//修改默认地址
#define CHANGEDEFAULTADDRESS @"http://123.57.185.8/address/changeState"
//删除地址
#define DELETETADDRESS @"http://123.57.185.8/address/delAddress"
//编辑地址
#define EDITADDRESS @"http://123.57.185.8/address/edit"
//红包列表
#define SCORELISTA @"http://123.57.185.8/score/listA";
//积分列表
#define SCORELISTB @"http://123.57.185.8/score/listB"
//下订单
#define CREATCARTORDER @"http://123.57.185.8/order/createCartOrder?token="
//我的订单列表下订单
#define ORDERCREATORDER @"http://123.57.185.8/order/orderDetail"
//取消订单
#define ORDERCANCLE @"http://123.57.185.8/order/orderCancle"
//修改订单地址
#define EDITORDERADDRESS @"http://123.57.185.8/order/editOrderAddr"
//微信支付
#define WXPAY @"http://123.57.185.8/order/weixinpay"
//支付成功请求数据
#define PAYSUCCESS @"http://123.57.185.8/order/paySuccess"
//确认收货
#define ORDERCONFIRM @"http://123.57.185.8/order/orderConfirm"
//微信登录
#define WXLOGIN @"http://192.168.1.136:8080/user/wxLogin"
#endif /* Netinterface_h */
