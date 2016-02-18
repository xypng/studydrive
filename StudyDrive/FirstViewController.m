//
//  FirstViewController.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "TestSelectViewController.h"
#import "MyDataManager.h"
#import "AnswerViewController.h"
#import "MainTestViewController.h"
#import "MyTestScoresViewController.h"
#import "SaveDataManager.h"
#import "MyScoreGraphsViewController.h"


@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataArray;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"科目一:理论考试";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = @[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真模拟考试"];
    [self creatTableView];
    [self creatView];
}

- (void)creatTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)creatView {
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-207, self.view.frame.size.height - 64 - 140, 414, 30)];
    lable.text = @"··························我的考试分析··························";
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    
    NSArray * arr = @[@"我的错题", @"我的收藏", @"我的成绩", @"练习统计"];
    
    for (int i = 0; i < 4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(self.view.frame.size.width/4*i + self.view.frame.size.width/4/2 - 30, self.view.frame.size.height - 64 - 100, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i + 12]] forState:UIControlStateNormal];
        btn.tag = 101 + i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4*i + self.view.frame.size.width/4/2 -30, self.view.frame.size.height - 64 - 40, 60, 30)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = arr[i];
        lab.font = [UIFont boldSystemFontOfSize:13];
        [self.view addSubview:lab];
    }
}

- (void)click:(UIButton *)button {
    switch (button.tag) {
        case 101:
        {
            AnswerViewController *answerViewcontroleer = [[AnswerViewController alloc] init];
            answerViewcontroleer.title = @"我的错题";
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            answerViewcontroleer.type=6;
            [self.navigationController pushViewController:answerViewcontroleer animated:YES];
        }
            break;
        case 102:
        {
            AnswerViewController *answerViewcontroleer = [[AnswerViewController alloc] init];
            answerViewcontroleer.title = @"我的收藏";
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            answerViewcontroleer.type=7;
            [self.navigationController pushViewController:answerViewcontroleer animated:YES];
        }
            break;
        case 103:
        {
            MyTestScoresViewController *con = [[MyTestScoresViewController alloc] init];
            con.title = @"我的成绩";
            NSArray *arr = [SaveDataManager getTestScores];
            if (arr.count==0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有成绩" message:@"你还没有成绩" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            con.arrTestScores = arr;
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 104:
        {
            MyScoreGraphsViewController *con = [[MyScoreGraphsViewController alloc] init];
            con.title = @"练习统计";
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"FirstTableViewCell";
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] lastObject];
    }
    cell.myImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", indexPath.row +7]];
    cell.myLable.text = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            TestSelectViewController * con = [[TestSelectViewController alloc] init];
            con.myArray = [MyDataManager getData:Chapter];
            con.myTitle = @"章节";
            con.type = 1;
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            
            break;
        case 1:
        {
            AnswerViewController *answerViewcontroleer = [[AnswerViewController alloc] init];
            answerViewcontroleer.title = @"顺序练习";
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            answerViewcontroleer.type=1;
            [self.navigationController pushViewController:answerViewcontroleer animated:YES];
        }
            break;
        case 2:
        {
            AnswerViewController *answerViewcontroleer = [[AnswerViewController alloc] init];
            answerViewcontroleer.title = @"随机练习";
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            answerViewcontroleer.type=2;
            [self.navigationController pushViewController:answerViewcontroleer animated:YES];
        }
            
            break;
        case 3:
        {
            TestSelectViewController * con = [[TestSelectViewController alloc] init];
            con.myArray = [MyDataManager getData:subChapter];
            con.myTitle = @"专项";
            con.type = 2;
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 4:
        {
            MainTestViewController * con = [[MainTestViewController alloc] init];
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
