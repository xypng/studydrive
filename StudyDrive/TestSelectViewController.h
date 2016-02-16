//
//  TestSelectViewController.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/11.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestSelectViewController : UIViewController
@property(nonatomic,copy)NSString * myTitle;
@property(nonatomic,copy)NSArray * myArray;
//1章节练习,2专项练习
@property(nonatomic,assign) int type;
@end
