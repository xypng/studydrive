//
//  MyScoreGraphsViewController.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/17.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "MyScoreGraphsViewController.h"
#import "MyScoreGraphs.h"
#import "SaveDataManager.h"
#import "MyDataManager.h"

@interface MyScoreGraphsViewController ()
{
    MyScoreGraphs *_myScoreGraphs;
}

@end

@implementation MyScoreGraphsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *rights = [SaveDataManager getAnswerRightQuestion];
    NSArray *wrongs = [SaveDataManager getAnswerWrongQuestion];
    NSArray *all = [MyDataManager getData:Answer];
    NSNumber *nRights = [NSNumber numberWithFloat:(float)rights.count];
    NSNumber *nWrongs = [NSNumber numberWithFloat:(float)wrongs.count];
    NSNumber *nNoAnswer = [NSNumber numberWithFloat:(float)(all.count-rights.count-wrongs.count)];
    _myScoreGraphs = [[MyScoreGraphs alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-100) andDatas:@[nWrongs,nRights,nNoAnswer] andTitles:@[@"答错题",@"答对题",@"未答题"] andColors:@[[UIColor redColor],[UIColor greenColor],[UIColor grayColor]]];
    [self.view addSubview:_myScoreGraphs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
