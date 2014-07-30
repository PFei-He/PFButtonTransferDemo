//
//  RootView.m
//  PFButtonTransferDemo
//
//  Created by PFei_He on 14-7-30.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "RootView.h"

@implementation RootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        //块
        buttonBlock = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonBlock.frame = CGRectMake(110, 100, 100, 30);
        [buttonBlock setTitle:@"Block" forState:UIControlStateNormal];
        [self addSubview:buttonBlock];

        //代理
        buttonDelegate = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonDelegate.frame = CGRectMake(110, 130, 100, 30);
        [buttonDelegate setTitle:@"Delegate" forState:UIControlStateNormal];
        [self addSubview:buttonDelegate];

        //单例
        UIButton *buttonSingloten = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSingloten.frame = CGRectMake(110, 160, 100, 30);
        [buttonSingloten setTitle:@"Singloten" forState:UIControlStateNormal];
        [self addSubview:buttonSingloten];
        [RootViewSingleton sharedInstance].sharedButton = buttonSingloten;

        //属性
        self.buttonProperty = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonProperty.frame = CGRectMake(110, 190, 100, 30);
        [self.buttonProperty setTitle:@"Property" forState:UIControlStateNormal];
        [self addSubview:self.buttonProperty];

        /*
         * p.s. 关于NSUserDefaults
         * 根据NSUserDefaults的设计原理（实质为单例），只能用于传递NSString，NSArray，NSDictionary，NSData等类型，不能用于传递UIButton
         */

        //KVO（键key-值value-观察/监听observing）
        UIButton *buttonKVO = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonKVO.frame = CGRectMake(110, 220, 100, 30);
        [buttonKVO setTitle:@"KVO" forState:UIControlStateNormal];
        [buttonKVO addTarget:self action:@selector(buttonKVOClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonKVO];

        /*
         * p.s. 关于通知
         * 通知可实时的对目标值的更改进行捕获，其原理为KVO设计模式（键key-值value-观察/监听observing）。根据这一设计原理，其自身存在一个必须先有监听再有值更改的顺序问题。基于这个情况，使用时必须先在获取值的地方注册监听者再对其发出通知方能实现通知的功能。
         */
        UIButton *buttonNotification = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonNotification.frame = CGRectMake(110, 250, 100, 30);
        [buttonNotification setTitle:@"Notification" forState:UIControlStateNormal];
        [buttonNotification addTarget:self action:@selector(buttonNotificationClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonNotification];

        /*
         * p.s. 关于外部变量
         * const NSString *string VS NSString *const string
         *
         * 1. const NSString *string
         *    指针可变，值不可变
         *    可用不同的指针去取值，但值本身不能被修改
         *
         * 2. NSString *const string
         *    值可变，指针不可变
         *    值本身可以被随意修改，但只能用声明的指针去取值
         */
        buttonExtern = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonExtern.frame = CGRectMake(110, 280, 100, 30);
        [buttonExtern setTitle:@"Extern" forState:UIControlStateNormal];
        [self addSubview:buttonExtern];
    }
    return self;
}

#pragma mark - Event Methods

//KVO按钮点击事件
- (void)buttonKVOClick
{
    if (self.KVONumber == 7) {
        self.KVONumber = -1;
    }self.KVONumber++;
}

//通知按钮点击事件
- (void)buttonNotificationClick
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:nil userInfo:nil];
}

#pragma mark - Callback Block

//块回调
- (void)buttonBlock:(void(^)(UIButton *button))button
{
    if (button) button(buttonBlock);
}

#pragma mark - Callback Delegate

//代理回调
- (void)callbackDelegate
{
    //监听代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(RootViewDelegateRequired:)]) {
        [self.delegate RootViewDelegateRequired:buttonDelegate];
//        [self.delegate performSelector:@selector(RootViewDelegateRequired:) withObject:self.buttonDelegate];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(RootViewDelegateOptional:)]) {
        [self.delegate RootViewDelegateOptional:buttonDelegate];
//        [self.delegate performSelector:@selector(RootViewDelegateOptional:) withObject:self.buttonDelegate];
    }
}

@end

@implementation RootViewSingleton

//单例
+ (instancetype)sharedInstance
{
    static RootViewSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
