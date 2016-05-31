//
//  ViewController.m
//  DatePicker
//
//  Created by liu on 16/5/31.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerViewController.h"

@interface ViewController ()

@property (nonatomic,strong) DatePickerViewController *datePickerVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)pushDatePicker:(id)sender
{
    [self.navigationController pushViewController:self.datePickerVC animated:YES];
}

-(DatePickerViewController *)datePickerVC
{
    if (_datePickerVC == nil) {
        _datePickerVC = [[DatePickerViewController alloc] init];
        
        [self.datePickerVC selectClick:^{
            
            NSLog(@"slelcted date %@ %lf",self.datePickerVC.selectDate,self.datePickerVC.selectIntervel);
        }];
    }
    
    return _datePickerVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
