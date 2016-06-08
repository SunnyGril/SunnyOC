//
//  ViewController.m
//  TSGesturePasswordDemo
//
//  Created by tiansha on 16/6/8.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import "ViewController.h"
#import "TSGesturePassword/TSGesturePasswordView.h"

@interface ViewController ()<TSGesturePasswordViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TSGesturePasswordView   *lockView = [[TSGesturePasswordView alloc]initWithFrame:self.view.frame];
    lockView.delegate = self;
    [self.view addSubview:lockView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)endGestureLockView:(TSGesturePasswordView *)hvwLockView didFinishedWithPath:(NSString *)path
{
    NSLog(@"手势解锁的输出序列：%@", path);
}
@end
