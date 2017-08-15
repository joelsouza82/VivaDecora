//
//  DetailTableViewController.h
//  VivaDecora
//
//  Created by Joel de Almeida Souza on 03/03/17.
//  Copyright © 2017 Joel de Almeida Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceConnect.h"

@interface DetailTableViewController : UITableViewController <WebServiceDataSource> {
    
    
    
    NSInteger tableviewRows;
    NSArray *detail;
    NSString *htmlString;
    NSString *site;
    UIView *activityView;
    UIActivityIndicatorView *activityIndicator;
    WebServiceConnect *webService;
    
    __weak IBOutlet UILabel *lblVenue;
    __weak IBOutlet UILabel *lblAdress;
    __weak IBOutlet UILabel *lblStats;
    __weak IBOutlet UILabel *lblRating;
    __weak IBOutlet UIActivityIndicatorView *activity;
    __weak IBOutlet UIBarButtonItem *shareButton;
    __weak IBOutlet UIButton *btnSite;
    __weak IBOutlet UIImageView *imgDetail;
}

@property (weak) NSString *venue;

@end
