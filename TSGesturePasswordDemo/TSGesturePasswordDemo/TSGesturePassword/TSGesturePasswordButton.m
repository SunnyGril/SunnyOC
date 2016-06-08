//
//  TSGesturePasswordButton.m
//  TSGesturePasswordDemo
//
//  Created by tiansha on 16/6/8.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import "TSGesturePasswordButton.h"

@implementation TSGesturePasswordButton

/** 使用文件创建会调用 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initLockButton];
    }
    return self;
}

/** 使用代码创建会调用 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initLockButton];
    }
    return self;
}

/** 初始化 */
- (void) initLockButton {
    // 取消交互事件（点击）
    self.userInteractionEnabled = NO;
    self.backgroundColor=[UIColor redColor];
    // 设置普通状态图片
    //    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
    
    // 设置选中状态图片
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 可触碰范围
    /**
     *  button 外7像素的位置都默认是点触了改按钮，自动连接
     *
     *  @param self.frame
     *
     *  @return 
     */
    CGFloat touchWidth = CGRectGetWidth(self.frame)/2;
    CGFloat touchHeight = CGRectGetHeight(self.frame)/2;
    CGFloat touchX = self.center.x - touchWidth-7;
    CGFloat touchY = self.center.y - touchHeight-7;
    self.touchFrame = CGRectMake(touchX, touchY, CGRectGetWidth(self.frame)+14, CGRectGetHeight(self.frame)+14);
}


@end
