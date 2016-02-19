//
//  SaveDataManager.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/16.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TestModel;
@interface SaveDataManager : NSObject
+ (NSArray *)getAnswerRightQuestion;
+ (NSArray *)getAnswerWrongQuestion;
+ (void)addAnswerWrongQuestion:(int)mid;
+ (void)addAnswerRightQuestion:(int)mid;
+ (void)clearAnswerData;

+ (NSArray *)getcollectQuestion;
+ (void)addcollectQuestion:(int)mid;
+ (void)removecollectQuestion:(int)mid;

+ (void)addTestScore:(TestModel *)testModel;
+ (NSArray *)getTestScores;
@end
