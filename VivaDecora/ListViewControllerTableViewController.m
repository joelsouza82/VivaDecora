//
//  ListViewControllerTableViewController.m
//  VivaDecora
//
//  Created by Joel de Almeida Souza on 03/03/17.
//  Copyright © 2017 Joel de Almeida Souza. All rights reserved.
//

#import "ListViewControllerTableViewController.h"
#import "ListTableViewCell.h"
#import "DetailTableViewController.h"
#import "Utilities.h"

@interface ListViewControllerTableViewController ()

@end

@implementation ListViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cache = [[NSCache alloc]init];
    webService = [[WebServiceConnect alloc] init];
    webService.dataSource = self;
    
    activityView = [[UIView alloc]init];
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [Utilities createActivityView:activityView andActivityIndicator: activityIndicator andWidth:self.view.frame.size.width / 2 andHeight: self.view.frame.size.height / 2];
    [self.view addSubview:activityView];
    
    [activityView setHidden:NO];
    [activityIndicator startAnimating];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    url = @"https://aviewfrommyseat.com/avf/api/featured.php?appkey=f6bcd8e8bb853890f4fb2be8ce0418fa";
    
    [webService connect:url];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [lista count];
}

#pragma mark - navigation segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        
        DetailTableViewController *detail = (DetailTableViewController *)segue.destinationViewController;
        NSDictionary *dictionaryList = lista[indexPath.row];
        detail.venue = dictionaryList[@"venue"];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dictionaryList = lista[indexPath.row];
    
    NSString *key = dictionaryList[@"image"];
    NSString *home = dictionaryList[@"home"];
    NSString *away = dictionaryList[@"away"];
    cell.tag = indexPath.row;
    
    cell.viewBackground.layer.cornerRadius = 12;
    cell.viewBackground.clipsToBounds = YES;
    cell.lblName.text = dictionaryList[@"venue"];
    cell.lblDetail.text = dictionaryList[@"note"];
    cell.lblViews.text = dictionaryList[@"views"];
    cell.lblLocation.text = [NSString stringWithFormat: @"%@, %@", home, away];
    
    if ([cache objectForKey:key] != nil) {
        cell.listImage.image = (UIImage *)[cache objectForKey:key];
    }else{
        NSString *urlString = [NSString stringWithFormat:@"http://aviewfrommyseat.com/wallpaper/%@", key];
        [webService getImage:^(UIImage *image) {
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    ListTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell) {
                        cell.listImage.image = image;
                        [cache setObject: image forKey:key];
                        [cell.activityIndicator stopAnimating];
                    }
                });
            }
        } withURL:urlString];
    }
    
    return cell;
}



#pragma mark - WebService data source

-(void)connect:(NSDictionary *)dictionary {
    lista = dictionary[@"avfms"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [activityView setHidden:YES];
        [activityIndicator stopAnimating];
        [self.tableView reloadData];
    });
    
}

-(void)error:(NSString *)errorMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning:" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [webService connect:url];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [activityView setHidden:YES];
        [activityIndicator stopAnimating];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"detailSegue" sender:indexPath];
}


@end
