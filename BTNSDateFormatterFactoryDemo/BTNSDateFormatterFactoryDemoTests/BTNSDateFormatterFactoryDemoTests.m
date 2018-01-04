//
//  BTNSDateFormatterFactoryDemoTests.m
//  BTNSDateFormatterFactoryDemoTests
//
//  Created by Brooks on 2018/1/3.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BTNSDateFormatterFactory/BTNSDateFormatterFactory.h>

#define ITERATIONS (1024*10)
static double then, now;

@interface BTNSDateFormatterFactoryDemoTests : XCTestCase
@property (nonatomic, strong) NSString *dateAsString;
@property (nonatomic, strong) NSCache *cache;
@end

@implementation BTNSDateFormatterFactoryDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self convertDateToStringUsingNewDateFormatter];
    [self convertDateToStringUsingBTNSDateFormatterFactoryFormatter];
    [self convertDateToStringUsingCLocaltime];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma test for cache
- (void)testBTNSDateFormatterFactoryCacheLimit {
    /**
     //    BTNSDateFormatterStyleNone,//yyyy-MM-dd HH:mm:ss
     //    BTNSDateFormatterStyle1,//yyyy-MM-dd'T'HH:mm:ss'Z'
     //    BTNSDateFormatterStyle2,//yyyy-MM-dd HH:mm:ss.SSS
     //    BTNSDateFormatterStyle3,//yyyy-MM-dd
     //    BTNSDateFormatterStyle4,//yyyy-MM
     //    BTNSDateFormatterStyle5,//yyyy年MM月
     //    BTNSDateFormatterStyle6,//yyyy.MM.dd
     
     */
    NSDateFormatter *dateFormatterFactoryFormatter1 = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd"];
    NSLog(@"cache = %@", [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"]);
    
    NSDateFormatter *dateFormatterFactoryFormatter2 = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"cache = %@", [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"]);
    
    
    NSDateFormatter *dateFormatterFactoryFormatter3 = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSLog(@"cache = %@", [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"]);
    
    
    NSDateFormatter *dateFormatterFactoryFormatter4 = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSLog(@"cache = %@", [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"]);
    
    
    NSDateFormatter *dateFormatterFactoryFormatter5 = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM"];
    NSLog(@"cache = %@", [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"]);
    
    
    NSDateFormatter *dateFormatterFactoryFormatter6 = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy年MM月dd日"];
    NSLog(@"cache = %@", [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"]);
    
    
    NSDateFormatter *dateFormatterFactoryFormatter7 = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy.MM.dd"];
    NSLog(@"cache = %@", [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"]);
    
    printf("\n\n\n\n");
    
}

#pragma test for MemoryWarning

- (void)testBTNSDateFormatterFactoryWhenMemoryWarning {
    
    self.cache = [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"];
    NSLog(@"df1 = %@", [self.cache objectForKey:[NSString stringWithFormat:@"yyyy-MM-dd|%@", [NSLocale currentLocale].localeIdentifier]]);
    NSLog(@"df2 = %@", [self.cache objectForKey:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss|%@", [NSLocale currentLocale].localeIdentifier]]);
    
    [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd"];
    [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.cache = [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"];
    NSLog(@"cached df1 = %@", [self.cache objectForKey:[NSString stringWithFormat:@"yyyy-MM-dd|%@", [NSLocale currentLocale].localeIdentifier]]);
    NSLog(@"cached df2 = %@", [self.cache objectForKey:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss|%@", [NSLocale currentLocale].localeIdentifier]]);
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
    self.cache = [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"];
    NSLog(@"after UIApplicationDidReceiveMemoryWarningNotification\n df1 = %@", [self.cache objectForKey:[NSString stringWithFormat:@"yyyy-MM-dd|%@", [NSLocale currentLocale].localeIdentifier]]);
    NSLog(@"after UIApplicationDidReceiveMemoryWarningNotification\n df2 = %@", [self.cache objectForKey:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss|%@", [NSLocale currentLocale].localeIdentifier]]);
    
    
    [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd"];
    [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.cache = [[BTNSDateFormatterFactory sharedFactory] valueForKey:@"loadedDataFormatters"];
    NSLog(@"cached df1 = %@", [self.cache objectForKey:[NSString stringWithFormat:@"yyyy-MM-dd|%@", [NSLocale currentLocale].localeIdentifier]]);
    NSLog(@"cached df2 = %@", [self.cache objectForKey:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss|%@", [NSLocale currentLocale].localeIdentifier]]);
}

#pragma test for costs time
- (void)convertDateToStringUsingNewDateFormatter
{
    then = CFAbsoluteTimeGetCurrent();
    for (NSUInteger i = 0; i < ITERATIONS; i++) {
        NSDateFormatter *newDateForMatter = [[NSDateFormatter alloc] init];
        [newDateForMatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [newDateForMatter setDateFormat:@"yyyy-MM-dd"];
        self.dateAsString = [newDateForMatter stringFromDate:[NSDate date]];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"Convert date to string using NSDateFormatter costs time: %f seconds!\n", now - then);
}

- (void)convertDateToStringUsingBTNSDateFormatterFactoryFormatter
{
    then = CFAbsoluteTimeGetCurrent();
    for (NSUInteger i = 0; i < ITERATIONS; i++) {
        NSDateFormatter *dateFormatterFactoryFormatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd" andLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        self.dateAsString = [dateFormatterFactoryFormatter stringFromDate:[NSDate date]];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"Convert date to string using BTNSDateFormatterFactory Formatter costs time: %f seconds!\n", now - then);
}

- (void)convertDateToStringUsingCLocaltime
{
    then = CFAbsoluteTimeGetCurrent();
    for (NSUInteger i = 0; i < ITERATIONS; i++) {
        time_t timeInterval = [NSDate date].timeIntervalSince1970;
        struct tm *cTime = localtime(&timeInterval);
        self.dateAsString = [NSString stringWithFormat:@"%d-%02d-%02d", cTime->tm_year + 1900, cTime->tm_mon + 1, cTime->tm_mday];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"Convert date to string using C localtime costs time: %f seconds!\n", now - then);
}

@end

