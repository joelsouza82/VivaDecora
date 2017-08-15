//
//  Utilities.m
//  VivaDecora
//
//  Created by Joel de Almeida Souza on 03/03/17.
//  Copyright © 2017 Joel de Almeida. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(void)createActivityView:(UIView *)activityView andActivityIndicator:(UIActivityIndicatorView *)indicator andWidth:(CGFloat)width andHeight:(CGFloat)height{

    [activityView setFrame:CGRectMake(width - 50, height - 60, 100, 80)];
    activityView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.41];
    activityView.layer.cornerRadius = 7;
    activityView.hidden = YES;
    
    indicator.center = CGPointMake(50, 35);
    [indicator hidesWhenStopped];
    [activityView addSubview:indicator];
    
    UILabel *lblCarregando = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 30)];
    lblCarregando.text = @"Carregando...";
    lblCarregando.font = [UIFont systemFontOfSize:12];
    lblCarregando.textColor = [UIColor whiteColor];
    [lblCarregando setTextAlignment:NSTextAlignmentCenter];
    [activityView addSubview:lblCarregando];
}


+(NSString *)conversaoArrayToString:(NSArray *)array{
    NSString *str = @"";
    for (int i = 0; i < array.count; i++) {
        if (i == 0) {
            str = array[0];
        }else{
            str = [NSString stringWithFormat:@"%@, %@", str, array[i]];
        }
    }
    
    return str;
}

+(NSAttributedString *)conversaoHTMLtoString:(NSString *)htmlString{
    UIFont *font = [UIFont systemFontOfSize:16];
    htmlString = [NSString stringWithFormat:@"<div style=\"font-family: '%@'; font-size: 16\">%@</div>", font.fontName, htmlString];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    return attrStr;
}


@end
