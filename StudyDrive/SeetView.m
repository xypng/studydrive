//
//  SeetView.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/14.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "SeetView.h"
@interface SeetView()
{
    UIView *_superView;
    CGFloat _height;
    CGFloat _width;
    CGFloat _y;
    BOOL _isMoved;
    UIScrollView *_scrollView;
    NSUInteger _count;
}
@end
@implementation SeetView
- (instancetype)initWithFrame:(CGRect)frame andsuperFrame:(UIView *)superView andCount:(NSUInteger)count{
    self = [super initWithFrame:frame];
    if (self){
        _superView = superView;
        _count = count;
        _height = self.frame.size.height;
        _width = self.frame.size.width;
        _y = self.frame.origin.y;
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    return self;
}

- (void)creatView {
    _backView = [[UIView alloc] initWithFrame:_superView.frame];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0;
    [_superView addSubview:_backView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-80)/2, 5, 80, 6)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-80)/2, 15, 80, 6)];
    view1.backgroundColor = [UIColor lightGrayColor];
    view2.backgroundColor = [UIColor lightGrayColor];
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 4;
    view2.layer.masksToBounds = YES;
    view2.layer.cornerRadius = 4;
    [self addSubview:view1];
    [self addSubview:view2];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 40, 25)];
    label1.text = @"答对";
    UILabel *labelrightnum = [[UILabel alloc] initWithFrame:CGRectMake(51, 30, 40, 25)];
    labelrightnum.text = @"0";
    labelrightnum.textColor = [UIColor greenColor];
    labelrightnum.tag = 201;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(92, 30, 40, 25)];
    label2.text = @"答错";
    UILabel *labelwrongnum = [[UILabel alloc] initWithFrame:CGRectMake(133, 30, 40, 25)];
    labelwrongnum.text = @"0";
    labelwrongnum.textColor = [UIColor redColor];
    labelwrongnum.tag = 202;
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(174, 30, 40, 25)];
    label3.text = @"未答";
    UILabel *labelnoanswered = [[UILabel alloc] initWithFrame:CGRectMake(215, 30, 40, 25)];
    labelnoanswered.text = [NSString stringWithFormat:@"%d", _count];
    labelnoanswered.tag = 203;
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
    [self addSubview:labelnoanswered];
    [self addSubview:labelrightnum];
    [self addSubview:labelwrongnum];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height-70)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    
    for (int i=0; i<_count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(10+(_width-16)/6*(i%6), 10+(_width-16)/6*(i/6), (_width-16)/6-4, (_width-16)/6-4);
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:200/225.0 green:200/225.0 blue:220/225.0 alpha:1];
        if (i==0) {
            btn.backgroundColor = [UIColor orangeColor];
        }
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1001+i;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 8;
        [_scrollView addSubview:btn];
    }
    int tip = _count%6?1:0;
    _scrollView.contentSize = CGSizeMake(0, 10+(_width-16)/6*((_count/6)+tip+1));
}

- (void)click:(UIButton *)btn {
    for (int i=0; i<_count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+1001];
        if (btn.tag==i+1001) {
            button.backgroundColor = [UIColor orangeColor];
            [_delegate sheetViewClick:i];
        }else {
            button.backgroundColor = [UIColor colorWithRed:200/225.0 green:200/225.0 blue:220/225.0 alpha:1];
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    if (point.y < 30.0) {
        _isMoved = YES;
    }
    NSLog(@"%f,%f",self.frame.origin.y,_y-_height);
    if (_isMoved && self.frame.origin.y >= _y-_height && [self convertPoint:point toView:_superView].y>=80) {
        self.frame = CGRectMake(0, [self convertPoint:point toView:_superView].y, _width, _height);
        float offset = (_superView.frame.size.height - self.frame.origin.y)/self.frame.size.height*0.8;
        _backView.alpha = offset;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _isMoved = NO;
    if (self.frame.origin.y > _y-_height/2) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, _y, _width, _height);
            _backView.alpha = 0;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, _y-_height, _width, _height);
            _backView.alpha = 0.8;
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
