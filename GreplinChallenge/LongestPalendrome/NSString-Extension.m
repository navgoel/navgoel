//
//  NSString-Extension.m
//  LongestPalendrome
//
//  Created by Navin Goel on 11/04/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "NSString-Extension.h"

// category extension for NSString
@implementation NSString(Extension)

// find longest palendrome

// For every position we store an upper and lower index that
// tracks the largest palindrome centered at that position.

- (NSString*) longestPalendrome
{
    // string should not be empty.
    NSAssert(self.length, @"empty string");

    if (!self.length)
    {
        return nil;
    }

    NSUInteger l_uiLength = self.length;
    unichar l_buffer[l_uiLength + 1];
    [self getCharacters:l_buffer range:NSMakeRange(0, l_uiLength)];

    // max length
    NSInteger l_iMaxPalendromeLength = 0;
    
    // lower index
    NSInteger l_iLowerIndex = 0;
    
    // upper index
    NSInteger l_iUpperIndex = 0;

    // loop through the string
    //
    for (int i = 0; i < l_uiLength; i++)
    {
        NSInteger l_iCurrentPalendromeLength = 0;
        NSInteger l_ilower = i;
        NSInteger l_iUpper = i;
        
        
        while (l_ilower >= 0
               && l_iUpper < l_uiLength
               && l_buffer[l_ilower] == l_buffer[l_iUpper])
        {
            l_iCurrentPalendromeLength++;
            l_iUpper++;
            l_ilower--;
        }
        
        if (l_iMaxPalendromeLength < l_iCurrentPalendromeLength)
        {
            l_iMaxPalendromeLength = l_iCurrentPalendromeLength;
            l_iLowerIndex = ++l_ilower;
            l_iUpperIndex = --l_iUpper;
        }
    }
    
    // longest plaendrome string to return
    //
    return [self substringWithRange:NSMakeRange(l_iLowerIndex, (l_iUpperIndex - l_iLowerIndex) + 1)];
}

@end
