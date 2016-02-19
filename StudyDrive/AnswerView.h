//
//  AnswerView.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnswerModel;
@protocol scrolldelegate <NSObject>
- (void)scrollViewDidEndDecelerating:(int)index;
- (void)answerQuestion:(NSArray *)questionArr;
@end

@interface AnswerView : UIView
{
    @public
    UIScrollView * _scrollView;
}
@property(nonatomic,weak)id<scrolldelegate> delegate;
@property(nonatomic,assign,readonly) int currentPage;
@property(nonatomic,strong) NSMutableArray *answeredArrar;
@property(nonatomic,strong) NSMutableArray *tempAnsweredArrar;//用于在答题模式和背题模式之间切换时临时保存answeredArrar的
- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)array;
- (void)selectRightAnswer;
- (void)reloadData;
- (AnswerModel *)getFitAnswerModel;
@end
