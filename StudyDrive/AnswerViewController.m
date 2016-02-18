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
#import "SaveDataManager.h"

@interface AnswerViewController ()<SheetViewDelegate, scrolldelegate, UIAlertViewDelegate>
{
    AnswerView *_answerView;
    SelectModelView *_selectModelView;
    SeetView *_sheetView;
    int _seconds;
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
        [self creatTimeDown];
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
                if (_mtype==[model.mtype intValue]) {
                    [_arrayQuestions addObject:model];
                }
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
        NSArray *arrall = [MyDataManager getData:Answer];
        NSArray *rights = [SaveDataManager getAnswerRightQuestion];
        NSArray *wrongs = [SaveDataManager getAnswerWrongQuestion];
        NSMutableArray *arraynoanswer = [NSMutableArray arrayWithArray:arrall];//没做的题
        NSMutableArray *arraywrong = [[NSMutableArray alloc] init];//做错的题
        NSMutableArray *arrayright = [[NSMutableArray alloc] init];//做对的题
        for (NSNumber *num in wrongs) {
            [arraynoanswer removeObject:[arrall objectAtIndex:[num intValue]-1]];
            [arraywrong addObject:[arrall objectAtIndex:[num intValue]-1]];
        }
        for (NSNumber *num in rights) {
            [arraynoanswer removeObject:[arrall objectAtIndex:[num intValue]-1]];
            [arrayright addObject:[arrall objectAtIndex:[num intValue]-1]];
        }
        //优先从未做题选,然后从错题选,再从对题选
        for (int i=0; i<100; i++) {
            int index = arc4random()%arraynoanswer.count;
            [_arrayQuestions addObject:arraynoanswer[index]];
            [arraynoanswer removeObject:arraynoanswer[index]];
            if (arraynoanswer.count==0) {
                //未做题已选完
                break;
            }
        }
        if (_arrayQuestions.count<100) {
            //不够100题,再从错题中选
            int leftnum = 100-_arrayQuestions.count;
            for (int i=0; i<leftnum; i++) {
                int index = arc4random()%arraywrong.count;
                [_arrayQuestions addObject:arraywrong[index]];
                [arraywrong removeObject:arraywrong[index]];
                if (arraywrong.count==0) {
                    //错题已选完
                    break;
                }
            }
        }
        if (_arrayQuestions.count<100) {
            //还不够100题,再从对题中选
            int leftnum = 100 - _arrayQuestions.count;
            for (int i=0; i<leftnum; i++) {
                int index = arc4random()%arrayright.count;
                [_arrayQuestions addObject:arrayright[index]];
                [arrayright removeObject:arrayright[index]];
                if (arrayright.count==0) {
                    //错题已选完
                    break;
                }
            }
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
    } else if (_type==6) {
        //做错题
        NSArray *arrAll = [MyDataManager getData:Answer];
        NSArray *arrWrongs = [SaveDataManager getAnswerWrongQuestion];
        _arrayQuestions = [[NSMutableArray alloc] init];
        for (AnswerModel *model in arrAll) {
            for (NSNumber *num in arrWrongs) {
                if ([model.mid intValue]==[num intValue]) {
                    [_arrayQuestions addObject:model];
                }
            }
        }
        if (_arrayQuestions.count==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有错题" message:@"你还没有做错的题目" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            alert.tag = 103;
            alert.delegate = self;
            [alert show];
            return;
        }
        _answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 -80) andDataArray:_arrayQuestions];
    } else if (_type==7) {
        //做收藏的题
        NSArray *arrAll = [MyDataManager getData:Answer];
        NSArray *arrCollects = [SaveDataManager getcollectQuestion];
        _arrayQuestions = [[NSMutableArray alloc] init];
        for (AnswerModel *model in arrAll) {
            for (NSNumber *num in arrCollects) {
                if ([model.mid intValue]==[num intValue]) {
                    [_arrayQuestions addObject:model];
                }
            }
        }
        if (_arrayQuestions.count==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有收藏题" message:@"你还没有收藏过题目" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            alert.tag = 104;
            alert.delegate = self;
            [alert show];
            return;
        }
        _answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 -80) andDataArray:_arrayQuestions];
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

- (void)creatTimeDown {
    _seconds = 3600;
    self.title = [NSString stringWithFormat:@"%02d:%02d", _seconds/60, _seconds%60];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown:) userInfo:nil repeats:YES];
}

- (void)timeDown:(NSTimer *)timer {
    _seconds--;
    self.title = [NSString stringWithFormat:@"%02d:%02d", _seconds/60, _seconds%60];
    if (_seconds==0) {
        [timer invalidate];
        timer = nil;
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"交卷" message:@"时间到了,你必须交卷了" delegate:self cancelButtonTitle:@"哦!" otherButtonTitles:nil, nil];
        av.tag = 105;
        [av show];
    }
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
        } else {
            lab.text = arr[i];
        }
        lab.tag = 501+i;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        //第一题可能已经收藏
        if (i==2 && _arrayQuestions.count>2) {
            AnswerModel *model = [_arrayQuestions objectAtIndex:0];
            NSArray *collectArr = [SaveDataManager getcollectQuestion];
            for (NSNumber *num in collectArr) {
                if ([num intValue]==[model.mid intValue]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"18-2"] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:@"18"] forState:UIControlStateHighlighted];
                    lab.text = @"取消收藏";
                    break;
                }
            }
        }
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
        } else {
            lab.text = arr[i];
        }
        lab.tag = 501+i*2;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        if (i==2) {
            //第一题可能已经收藏
            AnswerModel *model = [_arrayQuestions objectAtIndex:0];
            NSArray *collectArr = [SaveDataManager getcollectQuestion];
            for (NSNumber *num in collectArr) {
                if ([num intValue]==[model.mid intValue]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"18-2"] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:@"18"] forState:UIControlStateHighlighted];
                    lab.text = @"取消收藏";
                    break;
                }
            }
        }
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
        case 303://收藏本题or取消收藏
        {
            UILabel *lab = [self.view viewWithTag:503];
            if ([lab.text isEqualToString:@"收藏本题"]) {
                AnswerModel *model = [_answerView getFitAnswerModel];
                [SaveDataManager addcollectQuestion:[model.mid intValue]];
                [button setBackgroundImage:[UIImage imageNamed:@"18-2"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"18"] forState:UIControlStateHighlighted];
                lab.text = @"取消收藏";
            } else if ([lab.text isEqualToString:@"取消收藏"]) {
                AnswerModel *model = [_answerView getFitAnswerModel];
                [SaveDataManager removecollectQuestion:[model.mid intValue]];
                UILabel *lab = [self.view viewWithTag:503];
                [button setBackgroundImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"18-2"] forState:UIControlStateHighlighted];
                lab.text = @"收藏本题";
            }
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

- (void)cleanAnswerData {
    for (int i=0; i<_answerView.answeredArrar.count; i++) {
        _answerView.answeredArrar[i] = @0;
    }
    [_answerView reloadData];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(int)index {
    UILabel *lab = (UILabel *)[self.view viewWithTag:501];
    lab.text = [NSString stringWithFormat:@"%d/%d", index+1, _arrayQuestions.count];
    
    for (int i=0; i<_arrayQuestions.count; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i+1001];
        button.backgroundColor = [UIColor colorWithRed:200/225.0 green:200/225.0 blue:220/225.0 alpha:1];
    }
    UIButton *button = (UIButton *)[_sheetView viewWithTag:index+1001];
    button.backgroundColor = [UIColor orangeColor];
    
    AnswerModel *model = [_arrayQuestions objectAtIndex:index];
    NSArray *collectArr = [SaveDataManager getcollectQuestion];
    UIButton *btncollet = (UIButton *)[self.view viewWithTag:303];
    UILabel *labcollect = (UILabel *)[self.view viewWithTag:503];
    [btncollet setBackgroundImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
    [btncollet setBackgroundImage:[UIImage imageNamed:@"18-2"] forState:UIControlStateHighlighted];
    labcollect.text = @"收藏本题";
    for (NSNumber *num in collectArr) {
        if ([num intValue]==[model.mid intValue]) {
            [btncollet setBackgroundImage:[UIImage imageNamed:@"18-2"] forState:UIControlStateNormal];
            [btncollet setBackgroundImage:[UIImage imageNamed:@"18"] forState:UIControlStateHighlighted];
            labcollect.text = @"取消收藏";
            break;
        }
    }
}

- (void)answerQuestion:(NSArray *)questionArr {
    int right = 0;
    int wrong = 0;
    int noanswer = 0;
    AnswerModel *model;
    for (int i=0; i<questionArr.count; i++) {
        model = _arrayQuestions[i];
        int rightindex;
        if ([model.mtype intValue]==1) {
            rightindex = ([model.manswer characterAtIndex:0]-'A') + 1;
        } else {
            rightindex = [model.manswer isEqualToString:@"对"]?1:2;
        }
        if ([questionArr[i] intValue]==0) {
            noanswer++;
        } else if([questionArr[i] intValue]==rightindex) {
            right++;
        } else {
            wrong++;
        }
    }
    UILabel *labelright = (UILabel *)[_sheetView viewWithTag:201];
    UILabel *labelwrong = (UILabel *)[_sheetView viewWithTag:202];
    UILabel *labelnoanswer = (UILabel *)[_sheetView viewWithTag:203];
    labelright.text = [NSString stringWithFormat:@"%d",right];
    labelwrong.text = [NSString stringWithFormat:@"%d",wrong];
    labelnoanswer.text = [NSString stringWithFormat:@"%d",noanswer];
}

- (int)getWriteAnswerScore {
    int right = 0;
    int wrong = 0;
    int noanswer = 0;
    AnswerModel *model;
    for (int i=0; i<_answerView.answeredArrar.count; i++) {
        model = _arrayQuestions[i];
        int rightindex;
        if ([model.mtype intValue]==1) {
            rightindex = ([model.manswer characterAtIndex:0]-'A') + 1;
        } else {
            rightindex = [model.manswer isEqualToString:@"对"]?1:2;
        }
        if ([_answerView.answeredArrar[i] intValue]==0) {
            noanswer++;
        } else if([_answerView.answeredArrar[i] intValue]==rightindex) {
            right++;
        } else {
            wrong++;
        }
    }
    return right;
}

#pragma mark alertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case 101:
            //返回
        {
            if (buttonIndex==0) {
                return;
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
            
            break;
        case 102:
            //交卷
        {
            if (buttonIndex==0) {
                return;
            }
            [_saveTestScoreDelegate saveTestScore:[self getWriteAnswerScore]];
//            [self.navigationController popViewControllerAnimated:YES];
        }
        case 103:
            //没有错题
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            
            break;
        case 104:
            //没有收藏的题
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 105:
            //考试时间到
        {
            [_saveTestScoreDelegate saveTestScore:[self getWriteAnswerScore]];
//            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
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
