//
//  ViewController.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/1.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "ViewController.h"
#import "SelectVehicleView.h"
#import "FirstViewController.h"
#import "WebViewController.h"
#import "SubjectTwoViewController.h"
#define baomingxuzhi  "http://mnks.jxedt.com/ckm4/"
#define xinshoushanglu  "http://mnks.jxedt.com/ckm4/"
@interface ViewController ()
{
    SelectVehicleView * _selectVehicleView;
    __weak IBOutlet UIButton *selectBtn;
}

@end

@implementation ViewController

- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _selectVehicleView.alpha = 1;
            }];
        }
            break;
        case 101:
        {
            FirstViewController * con = [[FirstViewController alloc] init];
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 102:
        {
            SubjectTwoViewController * con = [[SubjectTwoViewController alloc] init];
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 103:
        {
        }
            break;
        case 104:
        {
            
        }
            break;
        case 105:
        {
            WebViewController * con = [[WebViewController alloc] initWithURL:@baomingxuzhi];
            con.title = @"报名须知";
            UIBarButtonItem * item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 106:
        {
            WebViewController * con = [[WebViewController alloc] initWithURL:@xinshoushanglu];
            con.title = @"新手上路";
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectVehicleView = [[SelectVehicleView alloc] initWithFrame:self.view.frame andButton:selectBtn];
    [self.view addSubview:_selectVehicleView];
    _selectVehicleView.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
