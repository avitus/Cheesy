//
//  CheesyMasterViewController.m
//  Cheesy
//
//  Created by Andy Vitus on 4/3/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import <Parse/Parse.h>
#import "CheesyMasterViewController.h"
#import "CheesyLoginViewController.h"
#import "CheesyDetailViewController.h"
#import "AddTastingViewController.h"
#import "CheeseTasting.h"
#import "Cheese.h"

@implementation CheesyMasterViewController

// ----------------------------------------------------------------------------------------------------
// Initialize and customize table
// ----------------------------------------------------------------------------------------------------
    
- (id)initWithCoder:(NSCoder *)aCoder {
    
    self = [super initWithCoder:aCoder];

    if (self) {
        
        // Customize the table
        
        // The className to query on
        self.parseClassName = @"CheeseTasting";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"cheese";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
        
    }
    return self;
}

// ----------------------------------------------------------------------------------------------------
// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
// ----------------------------------------------------------------------------------------------------

- (PFQuery *)queryForTable {

    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    if ([PFUser currentUser]) { // No user logged in
        // Retrieve CheeseTastings only for current user
        [query whereKey:@"user" equalTo:[PFUser currentUser]];
    } else {
        query.limit = 7;
        [query whereKey:@"user" equalTo:@"public"]; // hack: query for fake user
    }
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"qualityRating"];
    
    return query;
}

// ----------------------------------------------------------------------------------------------------
// Load a background image for the table cell   
// ----------------------------------------------------------------------------------------------------

-(UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSInteger rowCount =[self tableView:[self tableView] numberOfRowsInSection:0];    
    NSInteger rowIndex = indexPath.row;
    UIImage *background =nil;

    // TODO: use a different image for top and bottom row.
    // See http://www.verious.com/tutorial/customize-uitable-view-and-uitable-view-cell-background-using-storyboard/
    
    if(rowIndex ==0) {
        background =[UIImage imageNamed:@"list-item.png"];
    } else if(rowIndex == rowCount -1) {
        background =[UIImage imageNamed:@"list-item.png"];
    } else {
        background =[UIImage imageNamed:@"list-item.png"];
    }
    
    return background;
}

// ----------------------------------------------------------------------------------------------------
// Customize the table cell
// ----------------------------------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"Cell";
    
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [object objectForKey:@"qualityRating"]];

    PFObject *cheese = [object objectForKey:@"cheese"];
    [cheese fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        cell.textLabel.text = [cheese objectForKey:@"cheeseName"];
    }];
    
    // cell.imageView.file = [object objectForKey:self.imageKey];
    
    // Add a background image
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CheeseTasting *tasting = [self.objects objectAtIndex:indexPath.row];
        
        // Delete the object from Parse and reload the table view
        [tasting deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self loadObjects];
            }
        }];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, and save it to Parse
    }
}

// ----------------------------------------------------------------------------------------------------
// Wake fron Nib
// ----------------------------------------------------------------------------------------------------

- (void)awakeFromNib
{
    [super awakeFromNib];
}

// ----------------------------------------------------------------------------------------------------
// View Loaded - add buttons
// ----------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add background image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather-background.png"]];
    
	// Do any additional setup after loading the view, typically from a nib.
    
}

// ----------------------------------------------------------------------------------------------------
// View Appeared - authenticate user
// ----------------------------------------------------------------------------------------------------

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[CheesyLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

// ----------------------------------------------------------------------------------------------------
// Main table view
// ----------------------------------------------------------------------------------------------------

#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}



// ----------------------------------------------------------------------------------------------------
// Handle Logins
// ----------------------------------------------------------------------------------------------------

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

// ----------------------------------------------------------------------------------------------------
// Handle Sign Ups
// ----------------------------------------------------------------------------------------------------

#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


#pragma mark - Logout button handler

// ----------------------------------------------------------------------------------------------------
// Logout Current User
// ----------------------------------------------------------------------------------------------------

- (IBAction)logOutButtonTapAction:(id)sender {
    
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    // TODO: Extract this ... repeat of code in viewDidAppear
    
    // Create the log in view controller
    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
    [logInViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Create the sign up view controller
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    [signUpViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];
}

// ----------------------------------------------------------------------------------------------------
// Prepare to Seque to Detail View
// ----------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ShowTastingDetails"]) {
        
        CheesyDetailViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CheeseTasting *tasting = [self.objects objectAtIndex:indexPath.row];
        
        detailViewController.tasting = tasting;
        // detailViewController.cheese  = tasting.cheese;
        
    }
}

// ----------------------------------------------------------------------------------------------------
// Unwind Seques from AddTasting page
// ----------------------------------------------------------------------------------------------------

- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        
        AddTastingViewController *addController = [segue sourceViewController];
        
        if (addController.cheeseTasting) {
                        
            // save data to Parse
            [ addController.cheeseTasting save ];
            [self loadObjects];
        }
                
        [self dismissViewControllerAnimated:YES completion:NULL];
        
    }
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

// ----------------------------------------------------------------------------------------------------
// Handle memory warnings
// ----------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
@end
