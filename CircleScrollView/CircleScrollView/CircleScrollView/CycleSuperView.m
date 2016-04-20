//
//  CycleSuperView.m
//  ShengShiHuiHai
//
//  Created by tiansha on 16/4/8.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import "CycleSuperView.h"
#import "ColorDefine.h"

@interface CycleSuperView()
{
    
}


@end

@implementation CycleSuperView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleImageView];
        [self addSubview:self.cycleLabel];
    }
    return self;
}


-(UIImageView *)cycleImageView
{
    if (_cycleImageView == nil) {
        _cycleImageView = [[UIImageView alloc]initWithFrame:self.frame];
    }
    return _cycleImageView;
}

-(UILabel *)cycleLabel
{
    if (_cycleLabel == nil) {
        _cycleLabel = [[UILabel alloc]initWithFrame:self.frame];
    }
    return _cycleLabel;
}

-(void)setCycleImage:(NSString *)imageName
{
    [_cycleImageView setImage:[UIImage imageNamed:imageName]];
}

-(void)setCycleTitle:(NSString *)title
{
    _cycleLabel.textAlignment = NSTextAlignmentLeft;
    _cycleLabel.font = [UIFont systemFontOfSize:12];
    _cycleLabel.textColor = RGBA(102, 102, 102, 1);
    _cycleLabel.text = title;
}

@end
