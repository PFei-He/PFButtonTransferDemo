//
//  RootView.h
//  PFButtonTransferDemo
//
//  Created by PFei_He on 14-7-30.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import <UIKit/UIKit.h>

UIButton *externButton;

@protocol RootViewDelegate <NSObject>

@required
/**
 *  @brief 代理一方法（必须）
 */
- (void)RootViewDelegateRequired1:(UIButton *)button;

/**
 *  @brief 代理二方法（必须）
 */
- (void)RootViewDelegateRequired2;

@optional
/**
 *  @brief 代理一方法（可选）
 */
- (void)RootViewDelegateOptional1:(UIButton *)button;

/**
 *  @brief 代理二方法（可选）
 */
- (void)RootViewDelegateOptional2;

@end

typedef void (^PFBlcok)();

@interface RootView : UIView
{
    UIButton *delegateButton1;   //代理一
    UIButton *blockButton1;     //块一
}

///属性一
@property (nonatomic, strong) UIButton *propertyButton1;

///属性二
@property (nonatomic, strong) UIButton *propertyButton2;

///代理
@property (nonatomic, assign) id<RootViewDelegate> delegate;

///监听值
@property (nonatomic, assign) NSUInteger KVONumber;

///块二
@property (nonatomic, copy)   PFBlcok block2;

/**
 *  @brief 块一方法
 */
- (void)blockButton1:(void(^)(UIButton *button))button;

/**
 *  @brief 块二方法
 */
- (void)blockButton2:(void(^)())obj;

/**
 *  @brief 代理一回调
 */
- (void)callbackDelegate1;

@end

@interface RootViewSingleton : NSObject

///分享按钮
@property (nonatomic, strong) UIButton *sharedButton;

///单例
+ (instancetype)sharedInstance;

@end
