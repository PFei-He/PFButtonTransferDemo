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
    NSUInteger imageNum;

    UIImage *image[8];
}

@end

extern const UIButton *buttonExtern;

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

    RootView *rootView = [[RootView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.view = rootView;

    //获取背景图片
    [self background];

    //块
    [rootView buttonBlock:^(UIButton *button) {
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }];

    //代理
    rootView.delegate = self;
    [rootView callbackDelegate];

    //单例
    [[RootViewSingleton sharedInstance].sharedButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

    //属性
    [rootView.buttonProperty addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

    //KVO（键key-值value-观察/监听observing）
    [rootView addObserver:self forKeyPath:@"KVONumber" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];

    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(click) name:@"notification" object:nil];

    //外部变量
    [buttonExtern addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
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

//代理方法（必须实现）
- (void)RootViewDelegateRequired:(UIButton *)button
{
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}
/*
//代理方法（可选实现）
- (void)RootViewDelegateOptional:(UIButton *)button
{
 [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}
 */
#pragma mark - KVO Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
