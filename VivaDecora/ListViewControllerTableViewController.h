//
//  ListViewControllerTableViewController.h
//  VivaDecora
//
//  Created by Joel de Almeida Souza on 03/03/17.
//  Copyright © 2017 Joel de Almeida Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceConnect.h"

@interface ListViewControllerTableViewController : UITableViewController <WebServiceDataSource>{
    
    NSArray *lista;
    NSString *url;
    NSCache *cache;
    UIView * activityView;
    UIActivityIndicatorView *activityIndicator;
    WebServiceConnect *webService;
}

@end
