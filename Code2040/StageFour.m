//
//  Stage_2VC.m
//  CODE2040_Challenge
//
//  Created by PrinceSegs on 01/12/2014.
//  Copyright (c) 2014 SOG APPS. All rights reserved.
//

#import "StageFour.h"

@interface StageFour ()

@end

@implementation StageFour

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getData{
    
    
    
    NSError* errorJson = nil;
    NSDictionary* jsonDict = @{@"token" : @"XfoztF5I1v"};
    NSData* postData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:&errorJson];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)postData.length];
    
    
    NSURL *url = [NSURL URLWithString:@"http://challenge.code2040.org/api/time"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    
    
    
    NSError *jsonParsingError = nil;
    NSArray *publicTimeline = [NSJSONSerialization JSONObjectWithData:requestHandler
                                                              options:0 error:nil];
    
    
    
    
    
//    NSLog(@"%@",publicTimeline);
    
    
//    
    NSDictionary *dict = [publicTimeline valueForKey:@"result"];
    
    
    NSDate *date = [dict objectForKey:@"datestamp"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    // Always use this locale when parsing fixed format date strings
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    NSDate *newDate = [formatter dateFromString:[dict objectForKey:@"datestamp"]];
    
    NSTimeInterval interval = [[dict objectForKey:@"interval"] doubleValue];

    
//    NSDate *newDate = [date dateByAddingTimeInterval:30];
    
    NSDate *currentDate = newDate;
    NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:interval];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    
    NSString *iso8601String = [dateFormatter stringFromDate:datePlusOneMinute];

    
//
//    NSMutableArray *haystack = [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"array"]];
//    //
//    NSString *prefix = [dict objectForKey:@"prefix"];
//    
    
    
    
//    NSLog(@"%@",iso8601String);
    
    [self submit:iso8601String];
    
    
    
    
}

-(void)submit: (NSString *)date{
    
    
    NSError* errorJson = nil;
    NSDictionary* jsonDict = @{@"token" : @"XfoztF5I1v", @"datestamp":date};
    NSData* postData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:&errorJson];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)postData.length];
    
    
    NSURL *url = [NSURL URLWithString:@"http://challenge.code2040.org/api/validatetime"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    
    
    
    NSError *jsonParsingError = nil;
    NSArray *publicTimeline = [NSJSONSerialization JSONObjectWithData:requestHandler
                                                              options:0 error:nil];
    
    NSLog(@"%@",publicTimeline);
}



@end