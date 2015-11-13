//
//  Stage_2VC.m
//  CODE2040_Challenge
//
//  Created by PrinceSegs on 01/12/2014.
//  Copyright (c) 2014 SOG APPS. All rights reserved.
//

#import "StageThree.h"

@interface StageThree ()

@end

@implementation StageThree

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
    
    
    NSURL *url = [NSURL URLWithString:@"http://challenge.code2040.org/api/prefix"];
    
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
    
    


    
    
    NSDictionary *dict = [publicTimeline valueForKey:@"result"];
    
    NSMutableArray *haystack = [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"array"]];
//
    NSString *prefix = [dict objectForKey:@"prefix"];
    

    
    
    
    
    
    
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",prefix]; // if you need case sensitive search avoid '[c]' in the predicate
    
        NSArray *results = [haystack filteredArrayUsingPredicate:predicate];
    
    [haystack removeObjectsInArray:results];
    
    
    NSArray *array = [haystack copy];


    [self submit:array];
    
}

-(void)submit: (NSArray *)array{
    
    
    NSError* errorJson = nil;
    NSDictionary* jsonDict = @{@"token" : @"XfoztF5I1v", @"array":array};
    NSData* postData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:&errorJson];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)postData.length];
    
    
    NSURL *url = [NSURL URLWithString:@"http://challenge.code2040.org/api/validateprefix"];
    
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