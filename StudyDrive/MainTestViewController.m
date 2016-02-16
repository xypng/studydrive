//
//  MainTestViewController.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/14.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "MainTestViewController.h"
#import "AnswerViewController.h"
#import "TestModel.h"
#import "SaveDataManager.h"

@interface MainTestViewController ()<SaveTestScoreDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnRealTest;
@property (weak, nonatomic) IBOutlet UIButton *btnNoAnswerTest;
@property (weak, nonatomic) IBOutlet UILabel *labScore;
@property (weak, nonatomic) IBOutlet UILabel *labPassTest;

@end

@implementation MainTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模拟仿真考试";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 201:
        {
            AnswerViewController *avc = [[AnswerViewController alloc] init];
            avc.type = 4;
            avc.saveTestScoreDelegate = self;
            [self.navigationController pushViewController:avc animated:YES];
        }
            break;
        case 202:
        {
            AnswerViewController *avc = [[AnswerViewController alloc] init];
            avc.type = 5;
            avc.saveTestScoreDelegate = self;
            [self.navigationController pushViewController:avc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)saveTestScore:(int)score {
    self.btnNoAnswerTest.hidden = YES;
    self.btnRealTest.hidden = YES;
    self.labScore.hidden = NO;
    self.labScore.text = [NSString stringWithFormat:@"你的成绩:%d", score];
    self.labPassTest.hidden = NO;
    if (score>=90) {
        self.labPassTest.text = @"恭喜你,考试通过!";
    } else {
        self.labPassTest.text = @"这次考试没通过,请再接再厉!";
    }
    TestModel *model = [[TestModel alloc] init];
    model.testTime = [NSDate date];
    model.testScore = [NSNumber numberWithInt:score];
    [SaveDataManager addTestScore:model];
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
