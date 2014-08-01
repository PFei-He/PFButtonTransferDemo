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
        blockButton = [UIButton buttonWithType:UIButtonTypeSystem];
        blockButton.frame = CGRectMake(110, 100, 100, 30);
        [blockButton setTitle:@"Block" forState:UIControlStateNormal];
        [self addSubview:blockButton];

        //代理
        delegateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        delegateButton.frame = CGRectMake(110, 130, 100, 30);
        [delegateButton setTitle:@"Delegate" forState:UIControlStateNormal];
        [self addSubview:delegateButton];

        //单例
        UIButton *singlotenButton = [UIButton buttonWithType:UIButtonTypeSystem];
        singlotenButton.frame = CGRectMake(110, 160, 100, 30);
        [singlotenButton setTitle:@"Singloten" forState:UIControlStateNormal];
        [self addSubview:singlotenButton];
        [RootViewSingleton sharedInstance].sharedButton = singlotenButton;

        //属性一
        self.propertyButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
        self.propertyButton1.frame = CGRectMake(110, 190, 100, 30);
        [self.propertyButton1 setTitle:@"Property1" forState:UIControlStateNormal];
        [self addSubview:self.propertyButton1];

        /*
         * p.s. 关于NSUserDefaults
         * 根据NSUserDefaults的设计原理（实质为单例），只能用于传递NSString，NSArray，NSDictionary，NSData等类型，不能用于传递UIButton。
         */

        /*
         * p.s. 关于KVO（键key-值value-观察/监听observing）
         * 根据KVO设计模式，必须现有监听再有值变化。且在使用结束的时候，必须移除监听，否则会一直占用内存。
         */
        UIButton *kvoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        kvoButton.frame = CGRectMake(110, 250, 100, 30);
        [kvoButton setTitle:@"KVO" forState:UIControlStateNormal];
        [kvoButton addTarget:self action:@selector(kvoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:kvoButton];

        /*
         * p.s. 关于通知
         * 通知可实时的对目标值的更改进行捕获，其原理为KVO设计模式（键key-值value-观察/监听observing）。根据这一设计原理，其自身存在一个必须先有监听再有值变化的顺序问题。基于这个情况，使用时必须先在获取值的地方注册监听者再对其发出通知方能实现通知的功能。
         */
        UIButton *notificationButton = [UIButton buttonWithType:UIButtonTypeSystem];
        notificationButton.frame = CGRectMake(110, 280, 100, 30);
        [notificationButton setTitle:@"Notification" forState:UIControlStateNormal];
        [notificationButton addTarget:self action:@selector(notificationButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:notificationButton];

        /*
         * p.s. 关于外部变量
         * const NSString *string VS NSString *const string
         *
         * 1. const NSString *string
         *    指针可变，值不可变。
         *    可用不同的指针去取值，但值本身不能被修改。
         *
         * 2. NSString *const string
         *    值可变，指针不可变。
         *    值本身可以被随意修改，但只能用声明的指针去取值。
         */
        externButton = [UIButton buttonWithType:UIButtonTypeSystem];
        externButton.frame = CGRectMake(110, 310, 100, 30);
        [externButton setTitle:@"Extern" forState:UIControlStateNormal];
        [self addSubview:externButton];
    }
    return self;
}

#pragma mark - Event Methods

//KVO按钮点击事件
- (void)kvoButtonClick
{
    if (self.KVONumber == 7) {
        self.KVONumber = -1;
    }self.KVONumber++;
}

//通知按钮点击事件
- (void)notificationButtonClick
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:nil userInfo:nil];
}

#pragma mark - Property Getter

//自定义属性二的getter方法
- (UIButton *)propertyButton2
{
    if (!_propertyButton2) {
        _propertyButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
        _propertyButton2.frame = CGRectMake(110, 220, 100, 30);
        [_propertyButton2 setTitle:@"Property2" forState:UIControlStateNormal];
        [self addSubview:_propertyButton2];
    }

    return _propertyButton2;
}

#pragma mark - Callback Block

//块回调
- (void)blockButton:(void(^)(UIButton *button))button
{
    if (button) button(blockButton);
}

#pragma mark - Callback Delegate

//代理回调
- (void)callbackDelegate
{
    //监听代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(RootViewDelegateRequired:)])
//        [self.delegate performSelector:@selector(RootViewDelegateRequired:) withObject:delegateButton];
        [self.delegate RootViewDelegateRequired:delegateButton];

    if (self.delegate && [self.delegate respondsToSelector:@selector(RootViewDelegateOptional:)])
//        [self.delegate performSelector:@selector(RootViewDelegateOptional:) withObject:delegateButton];
        [self.delegate RootViewDelegateOptional:delegateButton];
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
