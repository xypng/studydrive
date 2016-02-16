//
//  SeetView.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/14.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SheetViewDelegate
- (void)sheetViewClick:(int)index;
- (void)cleanAnswerData;
@end

@interface SeetView : UIView
{
    @public
    UIView *_backView;
}
@property(nonatomic,weak)id<SheetViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame andsuperFrame:(UIView *)superView andCount:(NSUInteger)count;
@end
