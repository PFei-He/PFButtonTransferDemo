//
//  RootVC.m
//  PFButtonTransferDemo
//
//  Created by PFei_He on 14-7-30.
//  Copyright (c) 2014年 PFei_He. All rights reserved.
//

#import "RootVC.h"

@interface RootVC ()
{
    RootView *rootView;     //根视图

    NSUInteger imageNum;    //图片数量

    UIImage *image[8];      //创建图片数组
}

@end

extern const UIButton *externButton;

@implementation RootVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Initialization Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    //创建根视图
    rootView = [[RootView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.view = rootView;

    //获取背景图片
    [self background];

    //块一
    [rootView blockButton1:^(UIButton *button) {
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }];

    //块二
    [rootView blockButton2:^{
        [self click];
    }];

    //代理
    rootView.delegate = self;
    //代理一回调
    [rootView callbackDelegate1];

    //单例
    [[RootViewSingleton sharedInstance].sharedButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

    //属性一
    [rootView.propertyButton1 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

    //属性二
    [rootView.propertyButton2 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

    //KVO（键key-值value-观察/监听observing）
    //添加KVO监听
    [rootView addObserver:self forKeyPath:@"KVONumber" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];

    //通知
    //添加通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(click) name:@"notification" object:nil];

    //外部变量
    [externButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

//隐藏状态栏（iOS 7）
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

//背景图片
- (void)background
{
    NSArray *imageArr = @[@"blue", @"cycn", @"green", @"magenta", @"orange", @"purple", @"red", @"yellow"];
    for (int i = 0; i < imageArr.count; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"%@", imageArr[i]];/*[NSString stringWithFormat:imageArr[i], nil];*/
        //获取图片数组
        image[i] = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"images.bundle/%@", imageStr] ofType:@"png"]];
    }
}

#pragma mark - Event Methods

//按钮点击事件
- (void)click
{
    if (imageNum == 7) {
        imageNum = -1;
    }imageNum++;

    self.view.backgroundColor = [UIColor colorWithPatternImage:image[imageNum]];
}

#pragma mark - RootViewDelegate Methods

//代理一方法（必须实现）
- (void)RootViewDelegateRequired1:(UIButton *)button
{
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}
/*
//代理一方法（可选实现）
- (void)RootViewDelegateOptional1:(UIButton *)button
{
 [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}
 */

//代理二方法（必须实现）
- (void)RootViewDelegateRequired2
{
    [self click];
}
/*
//代理二方法（可选实现）
- (void)RootViewDelegateOptional2
{
    [self click];
}
*/
#pragma mark - KVO Methods

//KVO监听的方法，当监听的值发生改变时，该方法就会被调用（系统方法）
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //判断发生改变的是否为KVONumber
    if ([keyPath isEqualToString:@"KVONumber"]) {
        [self click];
    }
}

#pragma mark - Memory Management Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    //移除通知的监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    //移除KVO的监听
    [rootView removeObserver:self forKeyPath:@"KVONumber"];
}

@end
