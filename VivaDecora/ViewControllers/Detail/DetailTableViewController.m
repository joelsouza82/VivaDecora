//
//  DetailTableViewController.m
//  VivaDecora
//
//  Created by Joel de Almeida Souza on 03/03/17.
//  Copyright © 2017 Joel de Almeida Souza. All rights reserved.
//

#import "DetailTableViewController.h"
#import "Utilities.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableviewRows = 1;
    self.navigationItem.title = self.venue;
    
    activityView = [[UIView alloc]init];
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    shareButton.enabled = NO;
    
    [Utilities createActivityView:activityView andActivityIndicator: activityIndicator andWidth:self.view.frame.size.width / 2 andHeight: self.view.frame.size.height / 2];
    
    [self.view addSubview:activityView];
    [activityView setHidden:NO];
    [activityIndicator startAnimating];
    
    btnSite.layer.borderWidth = 1;
    btnSite.layer.borderColor = [UIColor colorWithRed:19 / 255.0 green:86 / 255.0 blue:122 / 255.0 alpha:1].CGColor;
    btnSite.layer.cornerRadius = 5;
    
    NSString *replace = [self.venue stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *url = [NSString stringWithFormat:@"https://aviewfrommyseat.com/avf/api/venue.php?appkey=f6bcd8e8bb853890f4fb2be8ce0418fa&venue=%@&info=true", replace];
    
    webService = [[WebServiceConnect alloc]init];
    webService.dataSource = self;
    [webService connect:url];
}



#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 191;
            break;
        default:
            return 96;
            break;
    }
}

- (IBAction)share:(id)sender {
    NSArray *shareItens = @[site];
    UIActivityViewController *shareView = [[UIActivityViewController alloc] initWithActivityItems:shareItens applicationActivities:nil];
    
    [self presentViewController:shareView animated:YES completion:nil];
}

#pragma mark - WebService datasource

-(void)connect:(NSDictionary *)dictionary {
    detail = dictionary[@"avfms"];
    
    NSArray *adressKey = @[@"address", @"city", @"state", @"country"];
    NSMutableArray *adressArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < adressKey.count; i++) {
        NSString *parcialAdress = detail[0][adressKey[i]];
        if (parcialAdress != nil) {
            [adressArray addObject:parcialAdress];
        }
    }
    
    NSString *adress = [Utilities conversaoArrayToString:adressArray];
    htmlString = detail[0][@"stats"];
    
    if (![htmlString isEqualToString:@""]) {
        lblStats.attributedText = [Utilities conversaoHTMLtoString:htmlString];
        tableviewRows += 1;
    }

    lblVenue.text = detail[0][@"name"];
    lblAdress.text = adress;
    lblRating.text = detail[0][@"average_rating"];
    NSArray *sameasContent = [detail[0][@"sameas"] componentsSeparatedByString:@", "];
    site = sameasContent[0];
    
    [lblVenue sizeToFit];
    [lblAdress sizeToFit];
    [lblStats sizeToFit];
    
    if ([site length] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            shareButton.enabled = YES;
        });
        tableviewRows += 1;
    }
    
    if ([adress length] > 0) {
        tableviewRows += 1;
    }
    
    NSString *url = [NSString stringWithFormat:@"http://aviewfrommyseat.com/photos/%@", detail[0][@"newest_image"]];
    [activity startAnimating];
    [webService getImage:^(UIImage *image) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                imgDetail.image = image;
                [activity stopAnimating];
            });
        }
    } withURL:url];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [activityView setHidden:YES];
        [activityIndicator stopAnimating];
        [self.tableView reloadData];
    });
    
    
    
    
}


- (IBAction)goToSite:(id)sender {
    NSURL *urlSite = [NSURL URLWithString:site];
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:urlSite options:@{} completionHandler:nil];
}

- (void)error:(NSString *)errorMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning:" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - table view data sources
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableviewRows;
}


@end
