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
 *  @brief 代理方法（必须）
 */
- (void)RootViewDelegateRequired:(UIButton *)button;

@optional
/**
 *  @brief 代理方法（可选）
 */
- (void)RootViewDelegateOptional:(UIButton *)button;

@end

@interface RootView : UIView
{
    UIButton *delegateButton;
    UIButton *blockButton;
}

///属性按钮
@property (nonatomic, strong) UIButton *propertyButton1;

@property (nonatomic, strong) UIButton *propertyButton2;

///代理
@property (nonatomic, assign) id<RootViewDelegate> delegate;

///监听值
@property (nonatomic, assign) NSUInteger KVONumber;

/**
 *  @brief 块方法
 */
- (void)blockButton:(void(^)(UIButton *button))button;

/**
 *  @brief 代理回调
 */
- (void)callbackDelegate;

@end

@interface RootViewSingleton : NSObject

///分享按钮
@property (nonatomic, strong) UIButton *sharedButton;

///单例
+ (instancetype)sharedInstance;

@end
