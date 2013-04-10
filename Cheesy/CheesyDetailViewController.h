//
//  CheesyDetailViewController.h
//  Cheesy
//
//  Created by Andy Vitus on 4/3/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheeseTasting;

@interface CheesyDetailViewController : UITableViewController

@property (strong, nonatomic) CheeseTasting *tasting;
@property (weak, nonatomic) IBOutlet UILabel *cheeseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cheeseStoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *qualityRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *pricePerPoundLabel;

@end
        