//
//  JackPickerView.h
//  JackPickerView
//
//  Created by Jack on 2017/6/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
//PickerView类型
typedef NS_ENUM(NSInteger, JackPickerViewStyle) {
    JackPickerViewStyleNormal,
    JackPickerViewStyleDouble,
    JackPickerViewStyleDate,
    JackPickerViewStyleTime,
    JackPickerViewStyleDateAndTime
};
@protocol JackPickerViewDelegate <NSObject>
-(void)jackPickerViewReturnDictionary:(NSDictionary *)getDic orDate:(NSDate *)date;
@end

@interface JackPickerView : UIView



@property(nonatomic,weak)id<JackPickerViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame pickerViewArray:(NSArray *)pickerViewArrar pickerViewDictronary:(NSDictionary *)pickerViewDictionary jackPickerViewStyle:(JackPickerViewStyle)style;
-(void)showPickerViewInView:(UIView *)view;
@property(nonatomic,readonly)JackPickerViewStyle style;
@end
