//
//  LocationPickerVC.h
//  YouZhi
//
//  Created by roroge on 15/4/9.
//  Copyright (c) 2015年 com.roroge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationPickerVC : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailAddressTextView;
@property(nonatomic,copy)NSString *addressId;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phoneNumber;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *country;
@end
