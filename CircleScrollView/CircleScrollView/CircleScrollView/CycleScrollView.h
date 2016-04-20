//
//  CycleScrollView.h
// 
//
//  Created by 田沙 on 15/5/23.
//  Copyright (c) 2015年 tiansha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    Horizontal,
    Vertical,
    
}CycleScrollDirection;


@interface CycleScrollView : UIView
{
 
}
/**
 *  滚动方向
 */
@property (nonatomic , assign) CycleScrollDirection cycleScrollDirection;
@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 属性设置：设置切换的每个view上面的属性
 pageIndex：索引，page的页面索引
 view：scrollview上铺的view，因为是三个view不停切换，所以需要设置图片image
 **/
@property (nonatomic , copy) void (^contentViewProperty)(NSInteger pageIndex, id view);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

@end