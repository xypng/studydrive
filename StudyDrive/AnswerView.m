//
//  AnswerView.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "AnswerView.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tools.h"

#define SIZE self.frame.size
#define QUESTIONSIZE 16 //问题字体大小

@interface AnswerView()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@end

@implementation AnswerView
{
    UITableView * _leftTableView;
    UITableView * _mainTableView;
    UITableView * _rightTableView;
    NSArray * _dataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        _currentPage = 0;
        _dataArray = [NSArray arrayWithArray:array];
        _answeredArrar = [[NSMutableArray alloc] init];
        for (int i=0; i<_dataArray.count; i++) {
            [_answeredArrar addObject:@0];
        }
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        _leftTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _rightTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        if (_dataArray.count > 1) {
            _scrollView.contentSize = CGSizeMake(SIZE.width*2, 0);
        }
        [self creatView];
    }
    return self;
}

- (void)creatView {
    _leftTableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _mainTableView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    _rightTableView.frame = CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_mainTableView];
    [_scrollView addSubview:_rightTableView];
    [self addSubview:_scrollView];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    int page = point.x/SIZE.width;
    if (page < _dataArray.count-1 && page>0) {
        _scrollView.contentSize = CGSizeMake(point.x + SIZE.width*2, 0);
        _mainTableView.frame = CGRectMake(point.x, 0, SIZE.width, SIZE.height);
        _leftTableView.frame = CGRectMake(point.x-SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTableView.frame = CGRectMake(point.x+SIZE.width, 0, SIZE.width, SIZE.height);
    }
    //垂直方向上拉动也会触发这个事件,而且会导致page为0
    if (page==0&& (_scrollView.contentSize.width/SIZE.width)>3 ) {
        return;
    }
    _currentPage = page;
    [self reloadData];
}

- (void)reloadData {
    [_leftTableView reloadData];
    [_rightTableView reloadData];
    [_mainTableView reloadData];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AnswerModel *model = [self getFitAnswerModel:tableView];
    if ([model.mtype intValue]==1) {
        return 4;
    }else {
        return 2;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger currentPage = [_dataArray indexOfObject:[self getFitAnswerModel:tableView]];
    if ([_answeredArrar[currentPage] intValue]==0) {
        _answeredArrar[currentPage] = [NSNumber numberWithInt:(int)(indexPath.row+1)];
        [tableView reloadData];
    }
}

- (void)selectRightAnswer{
    if ([_answeredArrar[_currentPage] intValue]!=0) {
        return;
    }else {
        UITableView *tv;
        if (_currentPage==0) {
            tv = _leftTableView;
        }else if(_currentPage>0&&_currentPage<_dataArray.count-1){
            tv = _mainTableView;
        }else{
            tv = _rightTableView;
        }
        AnswerModel *model = [self getFitAnswerModel:tv];
        NSString *rightAnswer = model.manswer;
        NSNumber *rightNumber;
        if ([model.mtype intValue]==1) {
            char c = [rightAnswer characterAtIndex:0];
            rightNumber = [NSNumber numberWithInt:c-'A'+1];
        }else{
            if ([rightAnswer isEqualToString:@"对"]) {
                rightNumber = [NSNumber numberWithInt:1];
            }else{
                rightNumber = [NSNumber numberWithInt:2];

            }
        }
        _answeredArrar[_currentPage] = rightNumber;
        [tv reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = [self getFitHeight:tableView];
    AnswerModel *model = [self getFitAnswerModel:tableView];
    //判断是否有图片
    UIImage *image;
    if (![model.mimage isEqualToString:@""]) {
        image = [UIImage imageNamed:[model.mimage substringToIndex:model.mimage.length-4]];
    }
    if (image!=nil) {
        height += 44.0;
    }
    if (height <= 80) {
        return 80;
    }
    return height;
}

- (CGFloat)getFitHeight:(UITableView *)tableView {
    AnswerModel *model = [self getFitAnswerModel:tableView];
    CGFloat height;
    if ([model.mtype intValue] == 1) {
        NSString *str = [[Tools getAnswerWithString:model.mquestion] firstObject];
        UIFont *font = [UIFont systemFontOfSize:QUESTIONSIZE];
        height = [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(self.frame.size.width-20, 400)].height + 20;
    } else {
        NSString *str = model.mquestion;
        UIFont *font = [UIFont systemFontOfSize:QUESTIONSIZE];
        height = [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(self.frame.size.width-20, 400)].height + 20;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat heighttext = [self getFitHeight:tableView];
    CGFloat heightimage = 0;
    AnswerModel *model = [self getFitAnswerModel:tableView];
    //判断是否有图片
    UIImage *image;
    UIImageView *imageView;
    if (![model.mimage isEqualToString:@""]) {
        image = [UIImage imageNamed:[model.mimage substringToIndex:model.mimage.length-4]];
    }
    if (image!=nil) {
        heightimage = 40;
        CGFloat widthimage = image.size.width*heightimage/image.size.height;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SIZE.width-widthimage)/2, heighttext, widthimage, heightimage)];
        imageView.image = image;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, heighttext+heightimage+20+4)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SIZE.width-20, heighttext-20)];
    label.text = [NSString stringWithFormat:@"%lu.%@", [_dataArray indexOfObject:model]+1, [[Tools getAnswerWithString:model.mquestion] firstObject]];
    label.font = [UIFont systemFontOfSize:QUESTIONSIZE];
    label.numberOfLines = 0;
    [view addSubview:label];
    if (image!=nil) {
        [view addSubview:imageView];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    AnswerModel *model = [self getFitAnswerModel:tableView];
    CGFloat height;
    NSString *str =  [NSString stringWithFormat:@"答案解析:%@", model.mdesc];
    UIFont *font = [UIFont systemFontOfSize:QUESTIONSIZE];
    height = [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(self.frame.size.width-20, 400)].height + 20;
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    AnswerModel *model = [self getFitAnswerModel:tableView];
    CGFloat height;
    NSString *str = [NSString stringWithFormat:@"答案解析:%@", model.mdesc];
    UIFont *font = [UIFont systemFontOfSize:QUESTIONSIZE];
    height = [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(self.frame.size.width-20, 400)].height + 20;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SIZE.width-20, height-20)];
    label.text = str;
    label.textColor = [UIColor greenColor];
    label.font = [UIFont systemFontOfSize:QUESTIONSIZE];
    label.numberOfLines = 0;
    [view addSubview:label];
    NSUInteger currentpage = [_dataArray indexOfObject:[self getFitAnswerModel:tableView]];
    if ([_answeredArrar[currentpage] intValue]==0) {
        return nil;
    }else {
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"AnswerTableViewCell";
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] lastObject];
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 10;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AnswerModel *model = [self getFitAnswerModel:tableView];
    NSUInteger currentPage = [_dataArray indexOfObject:model];
    //选择题
    if ([model.mtype intValue] == 1) {
        cell.numberLabel.text = [NSString stringWithFormat:@"%c", (char)('A'+indexPath.row)];
        cell.answerLabel.text = [[Tools getAnswerWithString:model.mquestion] objectAtIndex:indexPath.row+1];
        cell.numberImage.hidden = YES;
        cell.numberLabel.hidden = NO;
    }else {
        //判断题
        cell.numberLabel.text = (indexPath.row == 0)?@"对":@"错";
        cell.numberLabel.hidden = YES;
        cell.answerLabel.text = (indexPath.row == 0)?@"对":@"错";
        cell.numberImage.hidden = YES;
        cell.numberLabel.hidden = YES;
    }
    //已答过
    if ([_answeredArrar[currentPage] intValue]!=0) {
        //该行正确答案
        if ([model.manswer isEqualToString:cell.numberLabel.text]) {
            cell.numberLabel.hidden = YES;
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"19"];
        }
        //该行错误答案,并且选的是这行
        else if ([_answeredArrar[currentPage] intValue]==indexPath.row+1) {
            cell.numberLabel.hidden = YES;
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"20"];
        } else {
            if ([model.mtype intValue] == 1) {
                cell.numberLabel.hidden = NO;
            } else {
                cell.numberLabel.hidden = YES;
            }
            cell.numberImage.hidden = YES;
        }
    }
    return cell;
}

- (AnswerModel *)getFitAnswerModel:(UITableView *)tableView {
    AnswerModel *model;
    if (tableView==_leftTableView && _currentPage==0) {
        model = _dataArray[_currentPage];
    }else if(tableView==_leftTableView && _currentPage>0) {
        model = _dataArray[_currentPage-1];
    }else if(tableView==_mainTableView && _currentPage==0) {
        model = _dataArray[_currentPage+1];
    }else if(tableView==_mainTableView && _currentPage>0 && _currentPage<_dataArray.count-1) {
        model = _dataArray[_currentPage];
    }else if(tableView==_mainTableView && _currentPage==_dataArray.count-1) {
        model = _dataArray[_currentPage-1];
    }else if(tableView==_rightTableView && _currentPage<_dataArray.count-1) {
        model = _dataArray[_currentPage+1];
    }else if(tableView==_rightTableView && _currentPage==_dataArray.count-1) {
        model = _dataArray[_currentPage];
    }
    return model;
}

@end
