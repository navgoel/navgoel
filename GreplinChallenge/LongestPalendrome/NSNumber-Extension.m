//
//  NSNumber-Extension.m
//  LongestPalendrome
//
//  Created by Navin Goel on 11/04/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "NSNumber-Extension.h"

@implementation NSNumber(Extension)

// returns true/false if number is prime or not
//
- (BOOL) isPrime
{
    NSAssert(self, @"number is nil");

    BOOL l_bIsPrime = YES;
    CGFloat l_fFloatValue = [self doubleValue];
    NSInteger l_iDivisor = 2;

    // range is square root of value
    //
    NSInteger l_iRange = (NSInteger)sqrt(l_fFloatValue);
    
    // iterate 1 by 1.
    while (l_iDivisor <= l_iRange)
    {
        if (fmod(l_fFloatValue, l_iDivisor) == 0)
        {
            l_bIsPrime = NO;
            break;
        }
        l_iDivisor++;
    }
    
    return l_bIsPrime;
}

// returns a prime fibonacci number greater than self
//
- (NSNumber*) primeFibonacciNumberGreaterThanSelf
{
    NSAssert(self, @"number is nil");

    CGFloat l_fSelfValue = [self floatValue];
    CGFloat l_fFibonaciNumber = 0;
    CGFloat l_fFirstNumber = 0;
    CGFloat l_fSecondNumber = 1;
    NSNumber* l_fibonacciNumber;

    
    while (YES)
    {
        l_fFibonaciNumber = l_fFirstNumber + l_fSecondNumber;
        l_fFirstNumber = l_fSecondNumber;
        l_fSecondNumber = l_fFibonaciNumber;
        
        if (l_fFibonaciNumber > l_fSelfValue)
        {
            l_fibonacciNumber = [NSNumber numberWithFloat:l_fFibonaciNumber];
            if ([l_fibonacciNumber isPrime])
            {
                break;                
            }
        }
    }
    
    return l_fibonacciNumber;
}

// returns an array of prime divisors of a given number
//
- (NSArray*) primeDivisorsOfSelf
{
    NSAssert(self, @"number is nil");
    
    CGFloat l_fFloatValue = [self floatValue];
    NSMutableArray* l_arrOfFactors = [[NSMutableArray alloc] initWithCapacity:5];
    
    NSInteger l_iDivisor = 2;
    
    // check till the half of number
    //
    NSInteger l_iRange = (NSInteger)(l_fFloatValue/2) + 1;
    while (l_iDivisor <= l_iRange)
    {
        if (fmod(l_fFloatValue, l_iDivisor) == 0)
        {
            NSNumber* l_divisorNumber = [NSNumber numberWithFloat:l_iDivisor];
            
            if ([l_divisorNumber isPrime])
            {
                [l_arrOfFactors addObject:l_divisorNumber];
            }
        }
        l_iDivisor++;
    }

    return [l_arrOfFactors autorelease];
}




@end
