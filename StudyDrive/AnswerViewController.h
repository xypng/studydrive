//
//  AnswerViewController.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SaveTestScoreDelegate <NSObject>

- (void)saveTestScore:(int)score;

@end

@interface AnswerViewController : UIViewController
@property(nonatomic,copy) NSString *number;
//0章节练习,1顺序练习,2随机练习,3.专项练习,4全真摸拟考试,5优先未做题摸拟考试,6错题,7收藏的题
@property(nonatomic,assign) int type;
//1只答选择题,2只答判断题
@property(nonatomic,assign) int mtype;
@property(nonatomic,weak) id<SaveTestScoreDelegate> saveTestScoreDelegate;
@end
