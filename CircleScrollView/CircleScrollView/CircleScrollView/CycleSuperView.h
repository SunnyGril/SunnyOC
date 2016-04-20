//
//  CycleSuperView.h
//  ShengShiHuiHai
//
//  Created by tiansha on 16/4/8.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleSuperView : UIView

@property (nonatomic, strong)UIImageView   *cycleImageView;
@property (nonatomic, strong)UILabel        *cycleLabel;

-(void)setCycleImage:(NSString *)imageName;
-(void)setCycleTitle:(NSString *)title;
@end
