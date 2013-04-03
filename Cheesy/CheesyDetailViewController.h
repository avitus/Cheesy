//
//  CheesyDetailViewController.h
//  Cheesy
//
//  Created by Andy Vitus on 4/3/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheesyDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
