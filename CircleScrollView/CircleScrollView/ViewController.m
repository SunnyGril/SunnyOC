//
//  ViewController.m
//  CircleScrollView
//
//  Created by tiansha on 16/4/14.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import "ViewController.h"
#import "CycleScrollImageView.h"
#import "FrameDefine.h"

@interface ViewController ()
{
    CycleScrollImageView    *cycleScrollImageView;
    CycleScrollImageView            *cycleMessage;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initCycleScrollImageView];
    [self initCycleScrollMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  顶部加载循环滚动图片
 */
-(void)initCycleScrollImageView
{
    if (cycleScrollImageView ==nil)
    {
        cycleScrollImageView = [[CycleScrollImageView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 125)];
        NSMutableArray *cycleViewArray= [[NSMutableArray alloc]initWithObjects:@"1",@"1",nil];
        
        /**
         *  viewsarr：为nil 默认view形式 scrollview上一个Button 一个label
         *  不为空则自己写3个自定义的view进行添加 例如
         
         for (int i = 0; i<3; i++) {
         CycleSuperView *cycleView = [[CycleSuperView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.frame))];
         [viewArray addObject:cycleView];
         }
         
         */
        [cycleScrollImageView addCycleScrollImage:nil imageArray:cycleViewArray];
        
        /**
         *  scrollview 上view属性设置，图片大小，label字体大小子颜色 可以自定义
         */
        [cycleScrollImageView contentViewProperty:^(NSInteger pageIndex, id view) {
            [view setCycleImage:cycleViewArray[pageIndex]];
        }];
        /**
         *  每隔3秒 水平滚动一次
         */
        [cycleScrollImageView setScrollViewProperty:Horizontal duration:2];
    }
    
    [self.view addSubview:cycleScrollImageView];
    //点击图片 可执行操作
    [cycleScrollImageView tapActionBlock:^(NSInteger pageIndex) {
        
    }];
    
    
}

/**
 *  文字
 */
-(void)initCycleScrollMessage
{
    if(cycleMessage == nil)
    {
        cycleMessage = [[CycleScrollImageView alloc]initWithFrame:CGRectMake(10, 145, kScreenWidth, 30)];
        NSMutableArray *cycleViewArray= [[NSMutableArray alloc]initWithObjects:@"明星基金公司实力加盟",@"明星基金公司实力加盟",nil];
        [cycleMessage addCycleScrollImage:nil imageArray:cycleViewArray];
        [cycleMessage contentViewProperty:^(NSInteger pageIndex, id view) {
            [view setCycleTitle:cycleViewArray[pageIndex]];
        }];
        
        [cycleMessage setScrollViewProperty:Vertical duration:3];
    }
    [self.view addSubview:cycleMessage];
    
}

@end
