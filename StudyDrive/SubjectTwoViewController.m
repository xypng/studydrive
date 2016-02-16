//
//  SubjectTwoViewController.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/15.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "SubjectTwoViewController.h"
#import "SubjectTwoTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SubjectTwoViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@end

@implementation SubjectTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"SubjectTwoTableViewCell";
    SubjectTwoTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil] lastObject];
    }
    cell.imageTitle.image = [UIImage imageNamed:[NSString stringWithFormat:@"subject.png"]];
    cell.labelTitle.text = [NSString stringWithFormat:@"视频:%ld", indexPath.row+1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shipin" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
    mpvc.moviePlayer.shouldAutoplay = YES;
    [self.navigationController pushViewController:mpvc animated:YES];
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
