//
//  JackPickerView.m
//  JackPickerView
//
//  Created by Jack on 2017/6/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "JackPickerView.h"
// 屏幕尺寸
#define JFrameWidth [UIScreen mainScreen].bounds.size.width
#define JFrameHeight [UIScreen mainScreen].bounds.size.height



@interface JackPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,copy)UIView * backgroundView;//背景View
@property(nonatomic,copy)UIPickerView * jackPickView;//默认的选择类型
@property(nonatomic,strong)UIDatePicker * jackDatePicker;//时间选择器
@property(nonatomic,copy)NSArray * pickerViewArr;
@property(nonatomic,strong)UIButton * cancelBtn;//取消按钮
@property(nonatomic,strong)UIButton * sureBtn;//确定按钮
@property(nonatomic,strong)NSMutableDictionary * returnDic;
@property(nonatomic,strong)NSDate * date;
@property(nonatomic,strong)NSDictionary * pickerViewDic;
@property(nonatomic,strong)NSMutableArray * deArr;


@end

@implementation JackPickerView
-(instancetype)initWithFrame:(CGRect)frame pickerViewArray:(NSArray *)pickerViewArrar pickerViewDictronary:(NSDictionary *)pickerViewDictionary jackPickerViewStyle:(JackPickerViewStyle)style;
{
    //限制最小高度
    if (frame.size.height<162+30) {
        frame.size.height = 162+30;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self.backgroundView addSubview:self.jackPickView];
        [self.backgroundView addSubview:self.sureBtn];
        [self.backgroundView addSubview:self.cancelBtn];
        self.jackDatePicker.locale =  [NSLocale localeWithLocaleIdentifier : @"zh" ];
//        判断类型
        switch (style) {
            case JackPickerViewStyleNormal://默认
                self.pickerViewArr = pickerViewArrar;
                self.returnDic = [[NSMutableDictionary alloc]init];//初始化返回字典
                //设置默认选中
                for (NSInteger i = 0; i<self.pickerViewArr.count; i++) {
                    [self pickerView:self.jackPickView didSelectRow:0 inComponent:i];
                }
                break;
                case JackPickerViewStyleDate://日期类型
                self.jackDatePicker.datePickerMode = UIDatePickerModeDate;
                [self.backgroundView addSubview:self.jackDatePicker];
                break;
            case JackPickerViewStyleTime://时间类型
                self.jackDatePicker.datePickerMode = UIDatePickerModeTime;
                [self.backgroundView addSubview:self.jackDatePicker];
                break;

            case JackPickerViewStyleDateAndTime://日期和时间类型
                self.jackDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
                [self.backgroundView addSubview:self.jackDatePicker];
                break;
            case JackPickerViewStyleDouble://双表联动
                self.pickerViewDic = pickerViewDictionary;
                self.deArr = [[NSMutableArray alloc]init];
                self.returnDic = [[NSMutableDictionary alloc]init];//初始化返回字典
                [self pickerView:self.jackPickView didSelectRow:0 inComponent:0];
                break;
            default:
                break;
        }
    
    }
    
    
    return self;
}
//显示pickerview
-(void)showPickerViewInView:(UIView *)view
{

    [self addSubview:self.backgroundView];
    [view addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark -
#pragma mark - 懒加载控件
//背景View
-(UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
    }
    return _backgroundView;
}
//选择器
-(UIPickerView *)jackPickView
{
    if (_jackPickView == nil) {
        _jackPickView = [[UIPickerView alloc]init];
        _jackPickView.delegate = self;
        _jackPickView.dataSource = self;
        
    }
    return _jackPickView;
}
//确定按钮
-(UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc]init];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(clickSureButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
//取消按钮
-(UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc]init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
//时间选择器
-(UIDatePicker *)jackDatePicker
{
    if (_jackDatePicker == nil) {
        _jackDatePicker = [[UIDatePicker alloc]init];
        [_jackDatePicker addTarget:self action:@selector(dateDidChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _jackDatePicker;
}
-(NSDate *)date
{
    if (_date == nil) {
        _date = [[NSDate alloc]init];
    }
    return _date;
}
#pragma mark -选择器代理方法
#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
//返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_pickerViewDic.allKeys>0) {
        return 2;
    }else if (_pickerViewArr.count>0){
        return _pickerViewArr.count;
    }
    return 0;
}
//返回行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_pickerViewDic.allKeys>0) {
        if (component==0) {
            return self.pickerViewDic.allKeys.count;
        }
        return self.deArr.count;
        
    }else if (_pickerViewArr.count>0){
        NSArray * arr = _pickerViewArr[component];
        return arr.count;
    }
    return 0;
}
//内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if (_pickerViewDic.allKeys>0) {
            if (component==0) {
                return self.pickerViewDic.allKeys[row];
            }
            return self.deArr[row];
    }else if (_pickerViewArr.count>0){
        NSArray * arr = _pickerViewArr[component];
        return arr[row];
    }
    return nil;
}
//选中某个内容时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if (component == 0) {
        NSArray * arr = self.pickerViewDic.allKeys;
        self.deArr = [self.pickerViewDic objectForKey:arr[row]];
        [self.jackPickView reloadAllComponents];
    }
    if (_pickerViewDic.allKeys>0) {
        if (component == 0) {
            [self.returnDic setValue:self.pickerViewDic.allKeys[row] forKey:@"1"];
        }
        [self.returnDic setValue:self.deArr[row] forKey:@"2"];
    }else if (_pickerViewArr.count>0){
        NSArray * arr = _pickerViewArr[component];
        NSString * key = [NSString stringWithFormat:@"%ld",component+1];
        [self.returnDic setObject:arr[row] forKey:key];
    }

}
//日期更改时回调
-(void)dateDidChange:(UIDatePicker *)datePicker
{
    self.date = datePicker.date;
}
#pragma mark -控件布局
#pragma mark - layoutSubviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGFloat BWidth = self.backgroundView.frame.size.width;
    CGFloat BHeight = self.backgroundView.frame.size.height;
    self.jackPickView.frame=self.jackDatePicker.frame = CGRectMake(0, 0, BWidth, BHeight-30);
    self.sureBtn.frame = CGRectMake(0, BHeight-30, BWidth/2, 30);
    self.cancelBtn.frame = CGRectMake(BWidth/2, BHeight-30, BWidth/2, 30);
}
#pragma mark - 确定和取消
#pragma mark - ButtonClick
//点击确定按钮
-(void)clickSureButton:(UIButton *)btn
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    if ([self.delegate respondsToSelector:@selector(jackPickerViewReturnDictionary:orDate:)]) {
        [self.delegate jackPickerViewReturnDictionary:self.returnDic orDate:self.date];
    }
}
//点击取消按钮
-(void)clickCancelButton:(UIButton *)btn
{

    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
