//
//  WebServiceConnect.h
//  VivaDecora
//
//  Created by Joel de Almeida Souza on 03/03/17.
//  Copyright © 2017 Joel de Almeida Souza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol WebServiceDataSource <NSObject>

-(void)connect:(NSDictionary *)dictionary;
-(void)error:(NSString*)errorMessage;

@end

@interface WebServiceConnect : NSObject


-(void)getImage:(void(^)(UIImage *image))completion withURL:(NSString *)url;
-(void)connect:(NSString *) urlString;

@property (weak) id <WebServiceDataSource> dataSource;

@end
