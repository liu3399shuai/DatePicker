//
//  DatePickerViewController.h
//  liu
//
//  Created by liu on 16/4/19.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController

@property (nonatomic, strong) NSIndexPath           *selectIndex;

@property (nonatomic, strong) NSString              *selectDate;

@property (nonatomic, assign) double                selectIntervel;

-(void)selectClick:(void(^)(void))select;

@end
