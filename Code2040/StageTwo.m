//
//  Stage_2VC.m
//  CODE2040_Challenge
//
//  Created by PrinceSegs on 01/12/2014.
//  Copyright (c) 2014 SOG APPS. All rights reserved.
//

#import "StageTwo.h"

@interface StageTwo ()

@end

@implementation StageTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getHayStack];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getHayStack{
    
    
    
    NSError* errorJson = nil;
    NSDictionary* jsonDict = @{@"token" : @"XfoztF5I1v"};
    NSData* postData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:&errorJson];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)postData.length];
    
    
    NSURL *url = [NSURL URLWithString:@"http://challenge.code2040.org/api/haystack"];
    
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
    
    NSMutableArray *haystack = [dict objectForKey:@"haystack"];
    
    NSString *needle = [dict objectForKey:@"needle"];
    
    if ([haystack containsObject:needle]) {
        
        
        NSString *index = [NSString stringWithFormat:@"%lu",(unsigned long)[haystack indexOfObject:needle]];
        
        
            [self submit:index];
        
        
        
    }
  
    
}

-(void)submit: (NSString *)index{
    
    
    NSError* errorJson = nil;
    NSDictionary* jsonDict = @{@"token" : @"XfoztF5I1v", @"needle":index};
    NSData* postData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:&errorJson];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)postData.length];
    
    
    NSURL *url = [NSURL URLWithString:@"http://challenge.code2040.org/api/validateneedle"];
    
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