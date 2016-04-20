//
//  CycleScrollView.m
//  
//
//  Created by 田沙 on 15/5/23.
//  Copyright (c) 2015年 tiansha. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"
#import "CycleSuperView.h"

@interface CycleScrollView () <UIScrollViewDelegate>

//即PageControl的page索引
@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;

//存放在scrollview上的各个view
@property (nonatomic , strong) NSMutableArray *contentView;
@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@end

@implementation CycleScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.autoresizesSubviews = NO;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        
        //设置分页显示的圆点
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, frame.size.height - 30, self.frame.size.width, 20);
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self addSubview:_pageControl];
        
        self.currentPageIndex = 0;
    }
    return self;
}

#pragma mark - set
- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    _pageControl.numberOfPages = _totalPageCount;
    if (_totalPageCount > 0) {
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

-(void)setCycleScrollDirection:(CycleScrollDirection)cycleScrollDirection
{
    _cycleScrollDirection = cycleScrollDirection;
    if (cycleScrollDirection == Vertical)
    {
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame),self.bounds.size.height*3);
        self.scrollView.contentOffset = CGPointMake(0, CGRectGetHeight(self.scrollView.frame));
        _pageControl.hidden = YES;
        
    }else{
        self.scrollView.contentSize = CGSizeMake(3*CGRectGetWidth(self.scrollView.frame),self.bounds.size.height);
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        _pageControl.hidden = NO;
    }
    
}

#pragma mark -
#pragma mark - 私有函数

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *cycleView in self.contentView)
    {
        if (_cycleScrollDirection == Vertical) {
            cycleView.frame = CGRectMake(0, CGRectGetHeight(self.scrollView.frame)*counter, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        }else{
            cycleView.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame)*counter, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        }
     
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [cycleView addGestureRecognizer:tapGesture];
        
 
        counter++;
        [self.scrollView addSubview:cycleView];
    }
    
    if (_cycleScrollDirection == Vertical) {
        [_scrollView setContentOffset:CGPointMake(0, _scrollView.frame.size.height)];
    }else{
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    }
    
}

/**
 *  设置scrollView的content数据源，即contentViews
 *  根据索引去的view
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousViewIndex = [self getValidViewIndex:self.currentPageIndex - 1];
    NSInteger currentViewIndex = [self getValidViewIndex:self.currentPageIndex];
    NSInteger nextViewIndex = [self getValidViewIndex:self.currentPageIndex + 1];
    
    if (self.contentView == nil) {
        self.contentView = [@[] mutableCopy];
    }
    [self.contentView removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentView addObject:self.fetchContentViewAtIndex(previousViewIndex)];
        [self.contentView addObject:self.fetchContentViewAtIndex(currentViewIndex)];
        [self.contentView addObject:self.fetchContentViewAtIndex(nextViewIndex)];
    }
   
    [self setScrollViewContentProperty];
}


-(void)setScrollViewContentProperty
{
    NSInteger previousPageIndex = [self getValidPageControlIndex:self.currentPageIndex - 1];
    NSInteger currentPageIndex = [self getValidPageControlIndex:self.currentPageIndex];
    NSInteger nextPageIndex = [self getValidPageControlIndex:self.currentPageIndex + 1];
    
    if(self.contentViewProperty)
    {
        self.contentViewProperty(previousPageIndex,[self.contentView objectAtIndex:0]);
        self.contentViewProperty(currentPageIndex,[self.contentView objectAtIndex:1]);
        self.contentViewProperty(nextPageIndex,[self.contentView objectAtIndex:2]);
    }
}

/****
 *PageControl的索引
 ******/
- (NSInteger)getValidPageControlIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount -1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

/***
 *获取view索引,scrollview中三个view切换
 ****/
- (NSInteger)getValidViewIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return 2;
    } else if (currentPageIndex == 0) {
        return 0;
    } else {
        return currentPageIndex%3;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffset;
    if (_cycleScrollDirection == Vertical)
    {
        contentOffset = scrollView.contentOffset.y;
        if(contentOffset >= (2 * CGRectGetHeight(scrollView.frame))) {
            self.currentPageIndex = [self getValidPageControlIndex:self.currentPageIndex + 1];
            _pageControl.currentPage = self.currentPageIndex;
            [self configContentViews];
        }
    }else{
        contentOffset = scrollView.contentOffset.x;
        if(contentOffset >= (2 * CGRectGetWidth(scrollView.frame)))
        {
            self.currentPageIndex = [self getValidPageControlIndex:self.currentPageIndex + 1];
            _pageControl.currentPage = self.currentPageIndex;
            [self configContentViews];
        }
    }
    
    if(contentOffset <= 0) {
        self.currentPageIndex = [self getValidPageControlIndex:self.currentPageIndex - 1];
        _pageControl.currentPage = self.currentPageIndex;
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_cycleScrollDirection == Vertical)
    {
        [scrollView setContentOffset:CGPointMake(0, CGRectGetHeight(scrollView.frame)) animated:YES];
    }else{
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
    }
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    if (_cycleScrollDirection == Vertical)
    {
        CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y + CGRectGetHeight(self.scrollView.frame));
        [self.scrollView setContentOffset:newOffset animated:YES];
    }else{
        CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
        [self.scrollView setContentOffset:newOffset animated:YES];
    }
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
