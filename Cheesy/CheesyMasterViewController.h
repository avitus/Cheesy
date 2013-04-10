//
//  CheesyMasterViewController.h
//  Cheesy
//
//  Created by Andy Vitus on 4/3/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>

@interface CheesyMasterViewController : PFQueryTableViewController <NSFetchedResultsControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

// @property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
// @property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;

@end
