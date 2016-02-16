//
//  MyTestScoresViewController.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/17.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "MyTestScoresViewController.h"
#import "TestScoreTableViewCell.h"
#import "TestModel.h"

@interface MyTestScoresViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableViewTestScores;
}
@end

@implementation MyTestScoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    // Do any additional setup after loading the view.
}

- (void)creatTableView {
    _tableViewTestScores = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableViewTestScores.dataSource = self;
    _tableViewTestScores.delegate = self;
    [self.view addSubview:_tableViewTestScores];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrTestScores.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"TestScoreTableViewCell";
    TestScoreTableViewCell *cell = [_tableViewTestScores dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row%2!=0) {
        cell.backgroundColor=[UIColor colorWithRed:204/255 green:1 blue:1 alpha:0.5];
    }
    TestModel *model = (TestModel *)_arrTestScores[indexPath.row];
    cell.labelScore.text = [NSString stringWithFormat:@"分数:%d", [model.testScore intValue]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM月dd日 HH点mm分"];
    NSString *time = [df stringFromDate:model.testTime];
    cell.labelTime.text = time;
    return cell;
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
