//
//  TestSelectViewController.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "TestSelectModel.h"
#import "AnswerViewController.h"
#import "SubChapterModel.h"

@interface TestSelectViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
}

@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = _myTitle;
    [self creatTableView];
}

- (void)creatTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _myArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"TestSelectTableViewCell";
    TestSelectTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 8;
    }
    if (indexPath.row%2!=0) {
        cell.backgroundColor=[UIColor colorWithRed:204/255 green:1 blue:1 alpha:0.5];
    }
    if (_type==1) {
        TestSelectModel *dataModel = _myArray[indexPath.row];
        cell.numberLabel.text = dataModel.pID;
        cell.titleLabel.text = dataModel.pName;
    } else if (_type==2) {
        SubChapterModel *dataModel = _myArray[indexPath.row];
        cell.numberLabel.text = dataModel.sid;
        cell.titleLabel.text = dataModel.sname;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerViewController *con = [[AnswerViewController alloc] init];
    if (_type==1) {
        con.number = [NSString stringWithFormat:@"%d", indexPath.row+1];
        con.type = 0;//章节练习
    } else if (_type==2) {
        TestSelectTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        con.number = cell.numberLabel.text;
        con.type = 3;//专项练习
        if (indexPath.row%2==0) {
            con.mtype = 1;
        } else {
            con.mtype = 2;
        }
    }
    [self.navigationController pushViewController:con animated:YES];
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
