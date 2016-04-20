//
//  CycleScrollImageView.m
//  EnjoyDemo
//
//  Created by 田沙 on 15/11/20.
//  Copyright (c) 2015年 田沙. All rights reserved.
//

#import "CycleScrollImageView.h"
#import "CycleScrollView.h"
#import "FrameDefine.h"
#import "ColorDefine.h"

@interface CycleScrollImageView()
{
    NSMutableArray  *viewArray;
    CycleScrollView     *s_header_scrollView;
    NSMutableArray  *imageArray;
}
@end

@implementation CycleScrollImageView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        viewArray = [NSMutableArray array];
        imageArray = [NSMutableArray array];
    }
    return self;
}

-(void)addCycleScrollImage:(NSMutableArray *)viewsArr imageArray:(NSMutableArray *)imageArr
{
    if (viewsArr == nil)
    {
        for (int i = 0; i<3; i++) {
            CycleSuperView *cycleView = [[CycleSuperView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.frame))];
            [viewArray addObject:cycleView];
        }
    }else{
        viewArray = viewsArr;
    }
    imageArray = imageArr;
}

- (void) setScrollViewProperty:(CycleScrollDirection)direction duration:(NSTimeInterval)animationDuration
{
    @try {
        if (s_header_scrollView == nil)
        {
            s_header_scrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height) animationDuration:animationDuration];
            [s_header_scrollView setCycleScrollDirection:direction];
            [self addSubview:s_header_scrollView];
        }
        
        __block NSMutableArray *array = viewArray;
        s_header_scrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return array[pageIndex];
        };
        
        __block CycleScrollImageView *cycleScrollContentView = self;
        s_header_scrollView.contentViewProperty = ^void(NSInteger pageIndex, id view)
        {
            if (cycleScrollContentView->_ContentViewProperty) {
                 cycleScrollContentView->_ContentViewProperty(pageIndex,view);
            }
           
        };
        
        int count = (int)[imageArray count];
        s_header_scrollView.totalPagesCount = ^NSInteger(void){
            return count;
        };
        
        __block CycleScrollImageView *cycleScrollImageView = self;
        [s_header_scrollView setTapActionBlock:^(NSInteger pageIndex) {
            if (cycleScrollContentView->_TapActionBlock)
            {
                cycleScrollImageView-> _TapActionBlock(pageIndex);
            }
        }];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
    

}

-(void)tapActionBlock:(void (^)(NSInteger))action
{
    _TapActionBlock = action;
}

-(void)contentViewProperty:(void (^)(NSInteger pageIndex, id view))action
{
    _ContentViewProperty = action;
}
@end
