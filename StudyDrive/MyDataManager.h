//
//  MyDataManager.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    Chapter,//章节练习
    Answer,//答题数据
    subChapter//专项练习
} DataType;

@interface MyDataManager : NSObject
+ (NSArray *)getData:(DataType)type;
@end
