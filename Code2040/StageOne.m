//
//  StageOne.m
//  Code2040
//
//  Created by Abdi on 11/12/15.
//  Copyright © 2015 Bookdem. All rights reserved.
//

#import "StageOne.h"

@interface StageOne () <NSURLConnectionDelegate>

@end

@implementation StageOne{
    NSMutableData *_responseData;
    NSString *token;
    
    NSMutableArray *reversedString;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    token = @"XfoztF5I1v";
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://challenge.code2040.org/api/getstring"]];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    
    // This is how we set header fields
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys:token,@"token",
                             nil];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:nil];
    request.HTTPBody = jsonData;
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    
    
    NSError *jsonParsingError = nil;
    NSArray *publicTimeline = [NSJSONSerialization JSONObjectWithData:data
                                                              options:0 error:nil];
    
    
    
    //    _string.text = myString;
    
    
    
    [self submit:[self reverseString:[publicTimeline valueForKey:@"result"]]];
    NSLog(@"%@",publicTimeline);

    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSString *)reverseString:(NSString *)string
{
    
    NSUInteger count = [string length];
    
    if (count <= 1) {
        
        
        return string;
    }
    else
    {
        NSString *lastCharacter = [string substringWithRange:NSMakeRange(count - 1, 1)];
        
        NSString *remainingChars = [string substringToIndex:count - 1];
        
        NSString *output = [self reverseString:remainingChars];
        
        NSString *returnString = [lastCharacter stringByAppendingString:output];
        
        return returnString;
    }
}

-(void)submit:(NSString *)string{
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://challenge.code2040.org/api/validatestring"]];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    
    // This is how we set header fields
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys:token,@"token",string, @"string",
                             nil];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:nil];
    request.HTTPBody = jsonData;
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSLog(@"submitted");
    
    
    
    
    
}

@end
