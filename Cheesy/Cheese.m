//
//  Cheese.m
//  Cheesy
//
//  Created by Andy Vitus on 4/16/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import "Cheese.h"

// Import this header to let Cheese know that PFObject privately provides most of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>

@implementation Cheese

@dynamic cheeseName;
@dynamic cheeseCategory;
@dynamic milkType;

+ (NSString *)parseClassName {
    return @"Cheese";
}

@end
