//
//  SelectViewModel.h
//  StudyDrive
//
//  Created by 肖奕鹏 on 16/2/12.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    testModel,
    lookingModel
}SelectModel;
typedef void (^SelectTouch)(UIButton *btn);
@interface SelectModelView : UIView
@property(nonatomic,assign) SelectModel model;
- (instancetype)initWithFrame:(CGRect)frame andTouch:(SelectTouch)touch;
@end
