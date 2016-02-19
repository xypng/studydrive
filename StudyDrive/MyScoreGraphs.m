//
//  MyScoreGraphs.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/17.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "MyScoreGraphs.h"

@implementation MyScoreGraphs

- (instancetype)initWithFrame:(CGRect)frame andDatas:(NSArray *)datas andTitles:(NSArray *)titles andColors:(NSArray *)colors {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _colors = colors;
        _titles = titles;
        _datas = datas;
        if (datas.count!=titles.count) {
            return self;
        }
        if (datas.count!=titles.count) {
            return self;
        }
        for (int i=0; i<_titles.count; i++) {
            UIColor *color = colors[i];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10+12*i, 40, 5)];
            view.backgroundColor = color;
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(52, 3+12*i, 100, 20)];
            lable.text = [NSString stringWithFormat:@"%@:%.0f", _titles[i], [_datas[i] floatValue]];
            lable.font = [UIFont systemFontOfSize:10];
            [self addSubview:lable];
            [self addSubview:view];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSMutableArray *_dataArray = [[NSMutableArray alloc] init];
    if (_datas.count!=_titles.count) {
        return;
    }
    if (_datas.count!=_titles.count) {
        return;
    }
    float sum = 0;
    for (NSNumber *data in _datas) {
        sum += [data floatValue];
    }
    for (NSNumber *data in _datas) {
        [_dataArray addObject:[NSNumber numberWithFloat:[data floatValue]/sum]];
    }
    if (_dataArray.count==0) {
        return;
    }
    for(UIView *mylabelview in [self subviews])
    {
        if ([mylabelview isKindOfClass:[UILabel class]]) {
            [mylabelview removeFromSuperview];
        }
    }
    for (int i=0; i<_titles.count; i++) {
        UIColor *color = _colors[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10+12*i, 40, 5)];
        view.backgroundColor = color;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(52, 3+12*i, 100, 20)];
        lable.text = [NSString stringWithFormat:@"%@:%.0f", _titles[i], [_datas[i] floatValue]];
        lable.font = [UIFont systemFontOfSize:10];
        lable.tag = 101 + i;
        [self addSubview:lable];
        [self addSubview:view];
    }
    float offset = 0.0;
    for (int i=0; i<_dataArray.count; i++) {
        struct CGContext *context = UIGraphicsGetCurrentContext();
        NSNumber *data = _dataArray[i];
        UIColor *color = _colors[i];
        CGFloat r = (self.frame.size.width-100)/2;
        [UIView animateWithDuration:1 animations:^{
            CGContextAddArc(context, r+50, self.frame.size.height/2, r, M_PI*2*offset, M_PI*2*(offset+[data floatValue]), 0);
            CGContextAddLineToPoint(context, r+50, self.frame.size.height/2);
            CGContextSetFillColorWithColor(context, color.CGColor);
            CGContextFillPath(context);
        }];
        offset+=[data floatValue];
    }
}

@end
