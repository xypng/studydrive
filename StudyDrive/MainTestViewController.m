//
//  MainTestViewController.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/14.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "MainTestViewController.h"
#import "AnswerViewController.h"

@interface MainTestViewController ()

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
            [self.navigationController pushViewController:avc animated:YES];
        }
            break;
        case 202:
        {
            AnswerViewController *avc = [[AnswerViewController alloc] init];
            avc.type = 5;
            [self.navigationController pushViewController:avc animated:YES];
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
