//
//  ViewController.m
//  BTNSDateFormatterFactoryDemo
//
//  Created by Brooks on 2018/1/3.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "ViewController.h"
#import <BTNSDateFormatterFactory/BTNSDateFormatterFactory.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //usage
    NSDateFormatter *dateFormatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss.SSS" andLocaleIdentifier:@"zh_CN"];
    
    self.dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
