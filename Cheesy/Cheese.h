//
//  Cheese.h
//  Cheesy
//
//  Created by Andy Vitus on 4/16/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Cheese : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) NSString *cheeseName;
@property (retain) NSString *cheeseCategory;
@property (retain) NSString *milkType;

@end
