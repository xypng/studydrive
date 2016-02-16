//
//  SaveDataManager.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/16.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "SaveDataManager.h"
#import "TestModel.h"

#define WRONGQUESTION @"wrongquestion"
#define RIGHTQUESTION @"rightquestion"
#define COLLECTQUESTION @"collectquestion"
#define TESTSCORES @"testscores"

@implementation SaveDataManager

+ (NSArray *)getAnswerWrongQuestion {
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:WRONGQUESTION];
    if (arr!=nil) {
        return arr;
    } else {
        return @[];
    }
}

+ (NSArray *)getAnswerRightQuestion {
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:RIGHTQUESTION];
    if (arr!=nil) {
        return arr;
    } else {
        return @[];
    }
}

+ (void)addAnswerWrongQuestion:(int)mid {
    NSArray *arrWrongs = [[NSUserDefaults standardUserDefaults] objectForKey:WRONGQUESTION];
    NSArray *arrRights = [[NSUserDefaults standardUserDefaults] objectForKey:RIGHTQUESTION];
    NSMutableArray *muArrWrongs = [[NSMutableArray alloc] initWithArray:arrWrongs];
    NSMutableArray *muArrRights = [[NSMutableArray alloc] initWithArray:arrRights];
    for (int i=0; i<arrRights.count; i++) {
        if ([arrRights[i] intValue]==mid) {
            [muArrRights removeObjectAtIndex:i];
            NSLog(@"rights:%@", muArrRights);
            [muArrWrongs addObject:[NSNumber numberWithInt:mid]];
            NSLog(@"wrongs:%@", muArrWrongs);
            [[NSUserDefaults standardUserDefaults] setObject:muArrRights forKey:RIGHTQUESTION];
            [[NSUserDefaults standardUserDefaults] setObject:muArrWrongs forKey:WRONGQUESTION];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
    }
    for (int i=0; i<arrWrongs.count; i++) {
        if ([arrWrongs[i] intValue]==mid) {
            return;
        }
    }
    [muArrWrongs addObject:[NSNumber numberWithInt:mid]];
    NSLog(@"wrongs:%@", muArrWrongs);
    [[NSUserDefaults standardUserDefaults] setObject:muArrWrongs forKey:WRONGQUESTION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)addAnswerRightQuestion:(int)mid {
    NSArray *arrWrongs = [[NSUserDefaults standardUserDefaults] objectForKey:WRONGQUESTION];
    NSArray *arrRights = [[NSUserDefaults standardUserDefaults] objectForKey:RIGHTQUESTION];
    NSMutableArray *muArrWrongs = [[NSMutableArray alloc] initWithArray:arrWrongs];
    NSMutableArray *muArrRights = [[NSMutableArray alloc] initWithArray:arrRights];
    for (int i=0; i<arrWrongs.count; i++) {
        if ([arrWrongs[i] intValue]==mid) {
            [muArrWrongs removeObjectAtIndex:i];
            NSLog(@"wrongs:%@", muArrWrongs);
            [muArrRights addObject:[NSNumber numberWithInt:mid]];
            NSLog(@"right:%@", muArrRights);
            [[NSUserDefaults standardUserDefaults] setObject:muArrWrongs forKey:WRONGQUESTION];
            [[NSUserDefaults standardUserDefaults] setObject:muArrRights forKey:RIGHTQUESTION];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:muArrWrongs forKey:WRONGQUESTION];
    [[NSUserDefaults standardUserDefaults] synchronize];
    for (int i=0; i<arrRights.count; i++) {
        if ([arrRights[i] intValue]==mid) {
            return;
        }
    }
    [muArrRights addObject:[NSNumber numberWithInt:mid]];
    NSLog(@"rights:%@", muArrRights);
    [[NSUserDefaults standardUserDefaults] setObject:muArrRights forKey:RIGHTQUESTION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSArray *)getcollectQuestion {
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTQUESTION];
    if (arr!=nil) {
        return arr;
    } else {
        return @[];
    }
}

+ (void)addcollectQuestion:(int)mid {
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTQUESTION];
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithArray:arr];
    for (int i=0; i<arr.count; i++) {
        if ([arr[i] intValue]==mid) {
            return;
        }
    }
    [muArr addObject:[NSNumber numberWithInt:mid]];
    NSLog(@"collects:%@", muArr);
    [[NSUserDefaults standardUserDefaults] setObject:muArr forKey:COLLECTQUESTION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removecollectQuestion:(int)mid {
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTQUESTION];
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithArray:arr];
    for (int i=0; i<arr.count; i++) {
        if ([arr[i] intValue]==mid) {
            [muArr removeObjectAtIndex:i];
            break;
        }
    }
    NSLog(@"collects:%@", muArr);
    [[NSUserDefaults standardUserDefaults] setObject:muArr forKey:COLLECTQUESTION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)addTestScore:(TestModel *)testModel{
    NSData *data1 = [[NSUserDefaults standardUserDefaults] objectForKey:TESTSCORES];
    NSArray * arr = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithArray:arr];
    [muArr addObject:testModel];
    NSData * data2 = [NSKeyedArchiver archivedDataWithRootObject:muArr];
    [[NSUserDefaults standardUserDefaults] setObject:data2 forKey:TESTSCORES];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)getTestScores{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:TESTSCORES];
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (array == nil) {
        return @[];
    } else {
        return array;
    }
}

@end
