//
//  Utilities.h
//  VivaDecora
//
//  Created by Joel de Almeida Souza on 03/03/17.
//  Copyright © 2017 Joel de Almeida Souza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

+(void)createActivityView:(UIView *)activityView andActivityIndicator:(UIActivityIndicatorView *)indicator andWidth:(CGFloat)width andHeight:(CGFloat)height;

+(NSString *)conversaoArrayToString:(NSArray *)array;

+(NSAttributedString *)conversaoHTMLtoString:(NSString *)htmlString;

@end
