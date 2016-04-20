//
//  ImageButtonView.h
//  EnjoyDemo
//
//  Created by 田沙 on 15/11/20.
//  Copyright (c) 2015年 田沙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#import "CycleSuperView.h"

@interface CycleScrollImageView : UIView
{
    void (^_TapActionBlock)(NSInteger pageIndex);
    void (^_ContentViewProperty)(NSInteger pageIndex, id view);
    
}

/****
 *  viewsArr:为空时，默认样式：scrollview上铺button
 *  不为空时，样式可以自定义。
 *  viewsArr为三个，根据滑动切换位置。
 *  imageArr：每个图片的名字，也用此数组来确定scrollview page count。
 ******/
-(void)addCycleScrollImage:(NSMutableArray *)viewsArr imageArray:(NSMutableArray *)imageArr;

/**
 *
 *
 *  @param direction         滚动方向
 *  @param animationDuration 自动滚动时间，0：不滚动
 *
 *  @return 
 */
- (void) setScrollViewProperty:(CycleScrollDirection)direction duration:(NSTimeInterval)animationDuration;

/**
 当点击的时候，执行的block
 **/
-(void)tapActionBlock:(void (^)(NSInteger pageIndex))action;

/**
 滚动的view 自定义属性
 **/
-(void)contentViewProperty:(void (^)(NSInteger pageIndex, id view))action;

@end
