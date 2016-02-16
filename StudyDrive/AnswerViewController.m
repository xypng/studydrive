//
//  AnswerViewController.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SeetView.h"

@interface AnswerViewController ()<SheetViewDelegate, scrolldelegate, UIAlertViewDelegate>
{
    AnswerView *_answerView;
    SelectModelView *_selectModelView;
    SeetView *_sheetView;
}
@end

@implementation AnswerViewController
{
    NSMutableArray *_arrayQuestions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSelectModelView];
    [self creatAnswerView];
    if (_type!=4&&_type!=5) {
        [self creatToolBarView];
    }else {
        [self creatToolBarViewNoViewAnswer];
    }
    [self creatSheetView];
}

- (void)creatAnswerView {
    _arrayQuestions = [[NSMutableArray alloc] init];
    if (_type==0) {
        //章节练习
        NSArray *arr = [MyDataManager getData:Answer];
        for (int i=0; i<arr.count; i++) {
            AnswerModel *model = arr[i];
            if ([model.pid isEqualToString:_number]) {
                [_arrayQuestions addObject:model];
            }
        }
        _answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 -80) andDataArray:_arrayQuestions];
    } else if (_type==1) {
        //顺序练习
        NSArray *arr = [MyDataManager getData:Answer];
        _arrayQuestions = [NSMutableArray arrayWithArray:arr];
        _answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 -80) andDataArray:arr];
    } else if (_type==2){
        //随机练习
        NSArray *arr = [MyDataManager getData:Answer];
        NSMutableArray *arraytemp = [NSMutableArray arrayWithArray:arr];
        for (int i=0; i<arr.count; i++) {
            int index = arc4random()%arraytemp.count;
            [_arrayQuestions addObject:arraytemp[index]];
            [arraytemp removeObject:arraytemp[index]];
        }
        _answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 -80) andDataArray:_arrayQuestions];
    } else if (_type==3) {
        //专项练习
        NSArray *arr = [MyDataManager getData:Answer];
        for (int i=0; i<arr.count; i++) {
            AnswerModel *model = arr[i];
            if ([model.sid isEqualToString:_number]) {
                [_arrayQuestions addObject:model];
            }
        }
        _answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 -80) andDataArray:_arrayQuestions];
    } else if (_type==4){
        //全真模拟考试
        NSArray *arr = [MyDataManager getData:Answer];
        NSMutableArray *arraytemp = [NSMutableArray arrayWithArray:arr];
        for (int i=0; i<100; i++) {
            int index = arc4random()%arraytemp.count;
            [_arrayQuestions addObject:arraytemp[index]];
            [arraytemp removeObject:arraytemp[index]];
        }
        _answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 -80) andDataArray:_arrayQuestions];
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] init];
        item1.title = @"返回";
        item1.tag = 301;
        [item1 setTarget:self];
        [item1 setAction:@selector(clickBarButton:)];
        self.navigationItem.leftBarButtonItem = item1;
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] init];
        item2.title = @"交卷";
        item2.tag = 302;
        [item2 setTarget:self];
        [item2 setAction:@selector(clickBarButton:)];
        self.navigationItem.rightBarButtonItem = item2;
    } else if (_type==5){
        //优先未做题考试
        NSArray *arr = [MyDataManager getData:Answer];
        NSMutableArray *arraytemp = [NSMutableArray arrayWithArray:arr];
        for (int i=0; i<100; i++) {
            int index = arc4random()%arraytemp.count;
            [_arrayQuestions addObject:arraytemp[index]];
            [arraytemp removeObject:arraytemp[index]];
        }
        _answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 -80) andDataArray:_arrayQuestions];
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] init];
        item1.title = @"返回";
        item1.tag = 301;
        [item1 setTarget:self];
        [item1 setAction:@selector(clickBarButton:)];
        self.navigationItem.leftBarButtonItem = item1;
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] init];
        item2.title = @"交卷";
        item2.tag = 302;
        [item2 setTarget:self];
        [item2 setAction:@selector(clickBarButton:)];
        self.navigationItem.rightBarButtonItem = item2;
    }
    _answerView.delegate = self;
    [self.view addSubview:_answerView];
}

- (void)clickBarButton:(UIBarButtonItem *)item {
    switch (item.tag) {
        case 301:
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"返回" message:@"时间还很多,真的离开吗?" delegate:self cancelButtonTitle:@"不,谢谢!" otherButtonTitles:@"是,我要离开.", nil];
            av.tag = 101;
            [av show];
        }
            break;
        case 302:
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"交卷" message:@"你要交卷吗?" delegate:self cancelButtonTitle:@"不,谢谢!" otherButtonTitles:@"是,我要交卷.", nil];
            av.tag = 102;
            [av show];
        }
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        return;
    }
    switch (alertView.tag) {
        case 101:
            //返回
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            
            break;
        case 102:
            //交卷
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)creatSheetView {
    _sheetView = [[SeetView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-80) andsuperFrame:self.view andCount:_arrayQuestions.count];
    _sheetView.delegate = self;
    [self.view addSubview:_sheetView];
}

- (void)creatSelectModelView {
    _selectModelView = [[SelectModelView alloc] initWithFrame:self.view.frame andTouch:^{
        
    }];
    _selectModelView.alpha = 0;
    [self.view addSubview:_selectModelView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)modelChange{
    [UIView animateWithDuration:0.3 animations:^{
        _selectModelView.alpha = 1;
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.3 animations:^{
        _selectModelView.alpha = 0;
    }];
}

- (void)creatToolBarView {
    NSArray *arr = @[@"111", @"查看答案", @"收藏本题"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64 -80, self.view.frame.size.width, 80)];
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.frame.size.width/3*i + self.view.frame.size.width/3/2 -20, 5, 40, 40);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d", 16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2", 16+i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(toolBarClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 301+i;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(btn.center.x-30, 50, 60, 20)];
        if (i==0) {
            lab.text = [NSString stringWithFormat:@"%d/%d", 1, _arrayQuestions.count];
            lab.tag = 501;
        } else {
            lab.text = arr[i];
        }
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        [view addSubview:btn];
        [view addSubview:lab];
    }
    [self.view addSubview:view];
}

- (void)creatToolBarViewNoViewAnswer {
    NSArray *arr = @[@"111", @"收藏本题"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64 -80, self.view.frame.size.width, 80)];
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.frame.size.width/2*i + self.view.frame.size.width/2/2 -20, 5, 40, 40);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d", 16+i*2]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2", 16+i*2]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(toolBarClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 301+i*2;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(btn.center.x-30, 50, 60, 20)];
        if (i==0) {
            lab.text = [NSString stringWithFormat:@"%d/%d", 1, _arrayQuestions.count];
            lab.tag = 501;
        } else {
            lab.text = arr[i];
        }
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        [view addSubview:btn];
        [view addSubview:lab];
    }
    [self.view addSubview:view];
}

- (void)toolBarClick:(UIButton *)button {
    switch (button.tag) {
        case 301://选题
        {
            [UIView animateWithDuration:0.3 animations:^{
                _sheetView.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
                _sheetView->_backView.alpha = 0.8;
            }];
        }
            break;
            case 302://查看答案
        {
            [_answerView selectRightAnswer];
        }
            break;
        case 303://收藏本题
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - sheetView delegate
- (void)sheetViewClick:(int)index {
    UIScrollView *scrollView = _answerView->_scrollView;
    scrollView.contentOffset = CGPointMake(scrollView.frame.size.width*index, 0);
    [scrollView.delegate scrollViewDidEndDecelerating:scrollView];
    UILabel *lab = (UILabel *)[self.view viewWithTag:501];
    lab.text = [NSString stringWithFormat:@"%d/%d", index+1, _arrayQuestions.count];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(int)index {
    UILabel *lab = (UILabel *)[self.view viewWithTag:501];
    lab.text = [NSString stringWithFormat:@"%d/%d", index+1, _arrayQuestions.count];
    
    for (int i=0; i<_arrayQuestions.count; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i+101];
        button.backgroundColor = [UIColor colorWithRed:200/225.0 green:200/225.0 blue:220/225.0 alpha:1];
    }
    UIButton *button = (UIButton *)[_sheetView viewWithTag:index+101];
    button.backgroundColor = [UIColor orangeColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
