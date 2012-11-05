//
//  NSArray-Extension.m
//  LongestPalendrome
//
//  Created by Navin Goel on 11/04/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "NSArray-Extension.h"


// category extension for NSArray
//
@implementation NSArray(Extension)

// returns count of subsets where highest
// value is the addition of rest of the values
// in the subset
//
// since the array is sorted and unique so lets
// find all the subsets whose sum is equal to
// given value in the array.
//

static NSInteger l_iCountOfSubsets = 0;
- (NSInteger) countOfSubsets
{
    for (NSInteger iCount = 0; iCount < self.count; iCount++)
    {
        NSInteger l_iNumber = [[self objectAtIndex:iCount] integerValue];
        
        [self printSubsetWithSum:l_iNumber  currentSum:0 withIndex:0];
    }
    
    // this assert should be true for all subsets of size 1. i.e self.
    //
    NSAssert(l_iCountOfSubsets >= self.count, @"count of subsets should atleast be equal to the count");
    l_iCountOfSubsets -= self.count;    
    return l_iCountOfSubsets;
}



// find number of subsets with given sum in the array
//
- (void) printSubsetWithSum:(NSInteger) in_requiredSum
                 currentSum:(NSInteger) in_currentSum
                  withIndex:(NSInteger) in_currentIndex
{
    if (in_currentSum == in_requiredSum)
    {
        // increment the count 
        l_iCountOfSubsets++;
        
        if (in_currentIndex + 1 < self.count)
        {
            NSInteger l_iCurrentValue = [[self objectAtIndex:in_currentIndex] intValue];
            NSInteger l_iNexttValue = [[self objectAtIndex:in_currentIndex + 1] intValue];
            
            if (in_currentSum - l_iCurrentValue + l_iNexttValue <= in_requiredSum)
            {
                // recursion for the current value
                [self printSubsetWithSum:in_requiredSum currentSum:in_currentSum - l_iCurrentValue
                               withIndex:in_currentIndex+1];
            }
        
            return;
        }
    }
    else
    {
        // check the sum 
        //
        if( in_currentIndex < self.count && in_currentSum + [[self objectAtIndex:in_currentIndex] intValue] <= in_requiredSum)
        {
            // check for all the remaining value and iterate recursively
            // if the sum is less than the valye
            for( int i = in_currentIndex; i < self.count; i++ )
            {
                NSInteger l_iValue = [[self objectAtIndex:i] intValue];
                if( in_currentSum + l_iValue <= in_requiredSum )
                {
                    [self printSubsetWithSum:in_requiredSum  currentSum:in_currentSum + l_iValue withIndex:i+1];
                }
            }
        }
    }
}




@end
