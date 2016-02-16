//
//  SelectViewModel.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/12.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "SelectModelView.h"

@implementation SelectModelView
{
    SelectTouch block;
}

- (instancetype)initWithFrame:(CGRect)frame andTouch:(SelectTouch)touch{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
        block = touch;
    }
    return self;
}

- (void)creatView {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    NSArray *array = @[@"答题模式", @"背题模式"];
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(self.frame.size.width/2-60, self.frame.size.height/2-194+i*140, 120, 120);
        btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 15, 70, 70)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d11q",i+1]];
        [btn addSubview:imgView];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 120, 35)];
        lab.text = [array objectAtIndex:i];
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:lab];
        [self addSubview:btn];
    }
}

@end
