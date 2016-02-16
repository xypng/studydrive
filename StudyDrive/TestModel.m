//
//  TestModel.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/17.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "TestModel.h"

#define TESTSCORES @"testscores"
#define TESTTIME @"testtime"

@implementation TestModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.testScore forKey:TESTSCORES];
    [aCoder encodeObject:self.testTime forKey:TESTTIME];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.testScore = [aDecoder decodeObjectForKey:TESTSCORES];
        self.testTime = [aDecoder decodeObjectForKey:TESTTIME];
    }
    return self;
}
#pragma mark NSCoping
- (id)copyWithZone:(NSZone *)zone {
    TestModel *copy = [[[self class] allocWithZone:zone] init];
    copy.testTime = [self.testTime copyWithZone:zone];
    copy.testScore = self.testScore;
    return copy;
}
@end
