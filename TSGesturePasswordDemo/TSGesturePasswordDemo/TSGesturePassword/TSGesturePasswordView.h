//
//  TSGesturePasswordView.h
//  TSGesturePasswordDemo
//
//  Created by tiansha on 16/6/8.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSGesturePasswordView;
@protocol TSGesturePasswordViewDelegate <NSObject>

/** 结束手势解锁代理事件 */
@optional
- (void) endGestureLockView:(TSGesturePasswordView *) hvwLockView didFinishedWithPath:(NSString *) path;

@end

@interface TSGesturePasswordView : UIView

/** 代理 */
@property(nonatomic, weak) id<TSGesturePasswordViewDelegate> delegate;

@end
