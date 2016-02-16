//
//  TestModel.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/17.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject<NSCoding, NSCopying>
@property(nonatomic,copy) NSDate *testTime;
@property(nonatomic,assign) NSNumber *testScore;
@end
