//
//  MyDataManager.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "MyDataManager.h"
#import "FMDatabase.h"
#import "TestSelectModel.h"
#import "AnswerModel.h"
#import "SubChapterModel.h"

@implementation MyDataManager
+ (NSArray *)getData:(DataType)type {
    static FMDatabase * dataBase;
    NSMutableArray * array = [[NSMutableArray alloc] init];
    if (dataBase == nil) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"];
        dataBase = [[FMDatabase alloc] initWithPath:path];
    }
    if ([dataBase open]) {
        NSLog(@"数据打开成功!");
    } else {
        return array;
    }
    switch (type) {
        case Chapter:
        {
            NSString * sql = @"select pid,pname,pcount FROM firstlevel";
            FMResultSet * resultSet = [dataBase executeQuery:sql];
            while ([resultSet next]) {
                TestSelectModel *data = [[TestSelectModel alloc] init];
                data.pID = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"pid"]];
                data.pName = [resultSet stringForColumn:@"pname"];
                data.pCount = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"pcount"]];
                [array addObject:data];
            }
        }
            break;
        case Answer:
        {
            NSString * sql = @"select mquestion,mdesc,mid,manswer,mimage,pid,pname,sid,sname,mtype FROM leaflevel";
            FMResultSet * resultSet = [dataBase executeQuery:sql];
            while ([resultSet next]) {
                AnswerModel *model = [[AnswerModel alloc] init];
                model.mquestion = [resultSet stringForColumn:@"mquestion"];
                model.mdesc = [resultSet stringForColumn:@"mdesc"];
                model.mid = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"mid"]];
                model.manswer = [resultSet stringForColumn:@"manswer"];
                model.mimage = [resultSet stringForColumn:@"mimage"];
                model.pid = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"pid"]];
                model.pname = [resultSet stringForColumn:@"pname"];
                model.sid = [NSString stringWithFormat:@"%.2f", [resultSet doubleForColumn:@"sid"]];
                model.sname = [resultSet stringForColumn:@"sname"];
                model.mtype = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"mtype"]];
                [array addObject:model];
            }
        }
            break;
        case subChapter:
        {
            NSString * sql = @"select serial,sid,sname,pid,scount FROM secondlevel";
            FMResultSet * resultSet = [dataBase executeQuery:sql];
            while ([resultSet next]) {
                SubChapterModel *model = [[SubChapterModel alloc] init];
                model.serial = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"serial"]];
                model.sid = [NSString stringWithFormat:@"%.2f", [resultSet doubleForColumn:@"sid"]];
                model.sname = [resultSet stringForColumn:@"sname"];
                model.pid = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"pid"]];
                model.scount = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"scount"]];
                [array addObject:model];
            }
        }
            break;
            
        default:
            break;
    }
    return array;
}
@end
