//
//  NSTimer+Addition.h
//  PagedScrollView
//
//  Created by 田沙 on 15/5/23.
//  Copyright (c) 2015年 tiansha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
