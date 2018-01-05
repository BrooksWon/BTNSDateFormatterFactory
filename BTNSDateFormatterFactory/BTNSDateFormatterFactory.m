//
//  BTNSDateFormatterFactory.m
//  BTNSDateFormatterFactory
//
//  Created by Brooks on 2018/1/3.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "BTNSDateFormatterFactory.h"

// Define the default cache limit only if not defined by the host application code
#ifndef BTDATEFORMATTERFACTORY_CACHE_LIMIT
#define BTDATEFORMATTERFACTORY_CACHE_LIMIT 5
#endif

@implementation BTNSDateFormatterFactory


- (id)init {
    self = [super init];
    if (self) {
        loadedDataFormatters = [[NSCache alloc] init];
        loadedDataFormatters.countLimit = BTDATEFORMATTERFACTORY_CACHE_LIMIT;
        loadedDataFormatters.delegate = self;

        [[NSNotificationCenter defaultCenter] addObserver:loadedDataFormatters selector:@selector(removeAllObjects) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:loadedDataFormatters selector:@selector(removeAllObjects) name:NSCurrentLocaleDidChangeNotification  object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -
#pragma mark Static Methods

+ (BTNSDateFormatterFactory *)sharedFactory {
    static dispatch_once_t onceToken;
    static BTNSDateFormatterFactory *sharedInstance = nil;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[BTNSDateFormatterFactory alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark -
#pragma mark CacheLimit Methods

- (void)setCacheLimit:(NSUInteger)cacheLimit {
     @synchronized(self) {
         loadedDataFormatters.countLimit = cacheLimit;
     }
}

- (NSUInteger)cacheLimit {
    @synchronized(self) {
        return loadedDataFormatters.countLimit;
    }
}

#pragma mark -
#pragma mark NSDateFormatter Initialization Methods

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocale:(NSLocale *)locale {
    @synchronized(self) {
        NSString *key = [NSString stringWithFormat:@"%@|%@", format, locale.localeIdentifier];
        
        NSDateFormatter *dateFormatter = [loadedDataFormatters objectForKey:key];
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = format;
            dateFormatter.locale = locale;
            [loadedDataFormatters setObject:dateFormatter forKey:key];
        }
        
        return dateFormatter;
    }
}

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format andLocaleIdentifier:(NSString *)localeIdentifier {
    return [self dateFormatterWithFormat:format andLocale:[[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier]];
}

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format
{
    return [self dateFormatterWithFormat:format andLocale:[NSLocale currentLocale]];
}

- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle andLocale:(NSLocale *)locale {
    @synchronized(self) {
        NSString *key = [NSString stringWithFormat:@"d%lu|t%lu%@", (unsigned long)dateStyle, (unsigned long)timeStyle, locale.localeIdentifier];
        
        NSDateFormatter *dateFormatter = [loadedDataFormatters objectForKey:key];
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateStyle = dateStyle;
            dateFormatter.timeStyle = timeStyle;
            dateFormatter.locale = locale;
            [loadedDataFormatters setObject:dateFormatter forKey:key];
        }
        
        return dateFormatter;
    }
    
}

- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle andLocaleIdentifier:(NSString *)localeIdentifier {
    return [self dateFormatterWithDateStyle:dateStyle timeStyle:timeStyle andLocale:[[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier]];
}

- (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle andTimeStyle:(NSDateFormatterStyle)timeStyle {
    return [self dateFormatterWithDateStyle:dateStyle timeStyle:timeStyle andLocale:[NSLocale currentLocale]];
}

#pragma mark -
#pragma mark NSCacheDelegate Methods
-(void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"cache removed : %@",obj);
}

@end

