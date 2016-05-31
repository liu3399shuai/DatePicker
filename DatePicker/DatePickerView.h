//
//  DatePickerView.h
//  liu
//
//  Created by liu on 16/4/20.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "FactoryLab.h"

@interface DatePickerView : UIView

@end

@interface DatePickerCell : UICollectionViewCell

@property (nonatomic,strong) FactoryLab         *numLab;
@property (nonatomic,strong) FactoryLab         *tipLab;

-(void)updateCellIndex:(NSIndexPath *)indexPath select:(BOOL)select;

@end

@interface DatePickerHeaderView : UICollectionReusableView

@property (nonatomic,strong) FactoryLab         *tipLab;

@end

@interface DatePickerFooterView : UICollectionReusableView

@end