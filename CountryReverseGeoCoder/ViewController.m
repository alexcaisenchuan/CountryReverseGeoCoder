//
//  ViewController.m
//  CountryReverseGeoCoder
//
//  Created by caisenchuan on 14/10/27.
//  Copyright (c) 2014年 caisenchuan. All rights reserved.
//

#import "ViewController.h"
#import "CountryReverseGeoCoder.h"

@interface ViewController ()
{
    CountryReverseGeoCoder *op;
    UILabel *c_label;
    UIButton *c_button;
    UITextField *c_lat;
    UITextField *c_lon;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadView
{
    self.navigationController.navigationBarHidden = NO;
    
    UIView *crapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    crapView.backgroundColor = [UIColor whiteColor];
    
    float y = 35;
    c_label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, 300, 20)];
    c_label.text = @"Loading data...";
    [crapView addSubview:c_label];
    
    y += 35;
    c_lat = [[UITextField alloc] initWithFrame:CGRectMake(10, y, 300, 30)];
    c_lat.clearButtonMode = UITextFieldViewModeWhileEditing;
    c_lat.placeholder = @"Latitude";
    [crapView addSubview:c_lat];
    
    y += 35;
    c_lon = [[UITextField alloc] initWithFrame:CGRectMake(10, y, 300, 30)];
    c_lon.clearButtonMode = UITextFieldViewModeWhileEditing;
    c_lon.placeholder = @"Longitude";
    [crapView addSubview:c_lon];
    
    y += 35;
    c_button = [[UIButton alloc] initWithFrame:CGRectMake(10, y, 300, 40)];
    c_button.backgroundColor = [UIColor grayColor];
    [c_button setTitle:@"Read Country Code" forState:UIControlStateNormal];
    [c_button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [crapView addSubview:c_button];
    
    self.view = crapView;
    
    //Because CountryReverseGeoCoder init will take lots of time, we put it in background thread
    //This is a problem need to be solved
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (op == nil) {
            op = [CountryReverseGeoCoder alloc];
            op = [op init];
            NSString *code = [op getCountryCodeByLatitude:39.903416 andLongitude:116.331053];
            NSLog(@"get code : %@", code);
            dispatch_async(dispatch_get_main_queue(), ^{
                [c_label setText:@"Loading finish"];
            });
        } else {
            NSLog(@"op exist!");
        }
    });
}

-(void)onClick
{
    double lat = [c_lat.text doubleValue];
    double lon = [c_lon.text doubleValue];
    if (op) {
        NSString *code = [op getCountryCodeByLatitude:lat andLongitude:lon];
        NSLog(@"get code : %@", code);
        [c_label setText:code];
    } else {
        //...
    }
}

@end
