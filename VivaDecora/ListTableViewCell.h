//
//  ListTableViewCell.h
//  VivaDecora
//
//  Created by Joel de Almeida Souza on 03/03/17.
//  Copyright © 2017 Joel de Almeida Souza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *listImage;
// Labels de localicao, nome e detalhe
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblViews;

@property (weak, nonatomic) IBOutlet UIView *viewBackground;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
