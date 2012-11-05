//
//  NSArray-Extension.h
//  LongestPalendrome
//
//  Created by Navin Goel on 11/04/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

// category extension for NSArray
@interface NSArray(Extension)

// returns count of subsets whose highest
// value is the addition of rest of the values
// in the subset
//
- (NSInteger) countOfSubsets;

@end
