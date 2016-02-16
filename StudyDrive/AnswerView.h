//
//  AnswerView.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerView : UIView
{
    @public
    UIScrollView * _scrollView;
}
@property(nonatomic,assign,readonly) int currentPage;
@property(nonatomic,strong) NSMutableArray *answeredArrar;
- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)array;
- (void)selectRightAnswer;
@end
