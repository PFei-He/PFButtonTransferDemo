//
//  RootView.h
//  PFButtonTransferDemo
//
//  Created by PFei_He on 14-7-30.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import <UIKit/UIKit.h>

UIButton *buttonExtern;

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
    UIButton *buttonDelegate;
    UIButton *buttonBlock;
}

///属性按钮
@property (nonatomic, strong) UIButton *buttonProperty;

///代理
@property (nonatomic, assign) id<RootViewDelegate> delegate;

///监听值
@property (nonatomic, assign) NSUInteger KVONumber;

/**
 *  @brief 块方法
 */
- (void)buttonBlock:(void(^)(UIButton *button))button;

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
