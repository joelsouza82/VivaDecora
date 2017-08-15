//
//  WebServiceConnect.m
//  VivaDecora
//
//  Created by Joel de Almeida Souza on 03/03/17.
//  Copyright © 2017 Joel de Almeida Souza. All rights reserved.
//

#import "WebServiceConnect.h"

@implementation WebServiceConnect



-(void)connect:(NSString *) urlString {
    
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 5.0;
    configuration.timeoutIntervalForResource = 5.0;
    
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            [self.dataSource error:[error localizedDescription]];
            return;
        }
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            
            if (statusCode != 200) {
                NSString *error = [NSString stringWithFormat:@"dataTaskWithRequest HTTP status code: %ld", statusCode];
                [self.dataSource error:error];
                return;
            }else{
                if (data) {
                    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData: data
                                                                               options: NSJSONReadingMutableContainers
                                                                                 error: &error];
                    [self.dataSource connect:dictionary];
                }else{
                    [self.dataSource error:@"Unknown error."];
                }
            }
        }
        
    }];
    [task resume];
}

-(void)getImage:(void(^)(UIImage *image))completion withURL:(NSString *)url {
    NSURL *imageURL = [NSURL URLWithString: url];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                completion(image);
            }else{
                completion(nil);
            }
        }
    }];
    [task resume];
}

@end
