//
//  Tools.m
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSArray *)getAnswerWithString:(NSString *)str {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *answers = [str componentsSeparatedByString:@"<BR>"];
    [array addObject:answers[0]];
    if (answers.count>=5) {
        for (int i = 0; i < 4; i++) {
            [array addObject:[answers[i+1] substringFromIndex:2]];
        }
    }
    return array;
}

+ (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font withSize:(CGSize)size {
    CGSize s = [str sizeWithFont:font constrainedToSize:size];
    return s;
}

@end
