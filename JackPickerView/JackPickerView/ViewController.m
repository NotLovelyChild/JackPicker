//
//  ViewController.m
//  JackPickerView
//
//  Created by Jack on 2017/6/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "JackPickerView.h"
@interface ViewController ()<JackPickerViewDelegate>
@property(nonatomic,strong)JackPickerView * picker;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)showNormalPicker:(id)sender {
        NSArray * pickerArr = @[@"篮球",@"足球",@"羽毛球",@"乒乓球",@"排球",@"网球",@"高尔夫球",@"冰球",@"沙滩排球",@"棒球",@"垒球",@"藤球",@"毽球",@"台球",@"鞠蹴",@"板球",@"壁球",@"沙壶",@"克郎球",@"橄榄球",@"曲棍球",@"水球",@"马球",@"保龄球",@"健身球",@"门球",@"弹球"];
    self.picker = [[JackPickerView alloc]initWithFrame:CGRectMake(50, 100, 300, 300) pickerViewArray:@[pickerArr,pickerArr] pickerViewDictronary:nil jackPickerViewStyle:JackPickerViewStyleNormal];
    self.picker.delegate = self;
    [self.picker showPickerViewInView:self.view];
}

- (IBAction)showDate:(id)sender {
    self.picker = [[JackPickerView alloc]initWithFrame:CGRectMake(50, 100, 300, 300) pickerViewArray:nil pickerViewDictronary:nil jackPickerViewStyle:JackPickerViewStyleDate];
    self.picker.delegate = self;
    [self.picker showPickerViewInView:self.view];
}
- (IBAction)showTime:(id)sender {
    self.picker = [[JackPickerView alloc]initWithFrame:CGRectMake(50, 100, 300, 300) pickerViewArray:nil pickerViewDictronary:nil jackPickerViewStyle:JackPickerViewStyleTime];
    self.picker.delegate = self;
    [self.picker showPickerViewInView:self.view];
}
- (IBAction)showDateAndTime:(id)sender {
    self.picker = [[JackPickerView alloc]initWithFrame:CGRectMake(50, 100, 300, 300) pickerViewArray:nil pickerViewDictronary:nil jackPickerViewStyle:JackPickerViewStyleDateAndTime];
    self.picker.delegate = self;
    [self.picker showPickerViewInView:self.view];
}
- (IBAction)doublePicker:(id)sender {
    NSArray * arr1 = @[@"篮球",@"足球",@"羽毛球",@"乒乓球",@"排球",@"网球"];
    NSArray * arr2 = @[@"高尔夫球",@"冰球",@"沙滩排球",@"棒球",@"垒球",@"藤球",@"毽球",@"台球",@"鞠蹴"];
    NSArray * arr3 = @[@"克郎球",@"橄榄球",@"曲棍球",@"水球",@"马球",@"保龄球",@"健身球",@"门球",@"弹球"];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:arr1 forKey:@"小球"];
    [dic setValue:arr2 forKey:@"中球"];
    [dic setValue:arr3 forKey:@"大球"];
    
    self.picker = [[JackPickerView alloc]initWithFrame:CGRectMake(50, 100, 300, 300) pickerViewArray:nil pickerViewDictronary:dic jackPickerViewStyle:JackPickerViewStyleDouble];
    self.picker.delegate = self;
    [self.picker showPickerViewInView:self.view];
}



-(void)jackPickerViewReturnDictionary:(NSDictionary *)getDic orDate:(NSDate *)date;
{
    NSLog(@"%@",getDic);
    NSDateFormatter *formatter = [[ NSDateFormatter alloc ]init];
    // 格式化日期格式
    formatter. dateFormat = @"yyyy-MM-dd-hh-mm";
    NSString *str = [formatter stringFromDate :date];
    NSLog(@"%@",str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
