//
//  MyScoreGraphs.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/17.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScoreGraphs : UIView
@property(nonatomic,strong) NSArray *datas;
@property(nonatomic,strong) NSArray *colors;
@property(nonatomic,strong) NSArray *titles;
- (instancetype)initWithFrame:(CGRect)frame andDatas:(NSArray *)datas andTitles:(NSArray *)titles andColors:(NSArray *)color;
@end
