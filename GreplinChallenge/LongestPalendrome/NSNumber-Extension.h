//
//  NSNumber-Extension.h
//  LongestPalendrome
//
//  Created by Navin Goel on 11/04/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

// category extension for NSNumber
@interface NSNumber(Extension)

// returns true/false if number is prime or not
//
- (BOOL) isPrime;

// returns a prime fibonacci number greater than self
//
- (NSNumber*) primeFibonacciNumberGreaterThanSelf;

// returns an array of prime divisors of a given number
//
- (NSArray*) primeDivisorsOfSelf;


@end
