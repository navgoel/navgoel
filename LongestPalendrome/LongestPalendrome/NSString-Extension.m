//
//  NSString-Extension.m
//  LongestPalendrome
//
//  Created by Navin Goel on 10/26/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "NSString-Extension.h"

@implementation NSString(Extension)

- (NSString*) longestPalendrome
{
    NSString* l_strLongestPalendrome = nil;
    
    NSAssert(self.length, @"empty string");

    if (!self.length)
    {
        return nil;
    }
    
    NSUInteger l_uiLength = self.length;
    unichar buffer[l_uiLength + 1];
    [self getCharacters:buffer range:NSMakeRange(0, l_uiLength)];

    NSInteger l_iMaxPalendromeLength = 0;
    NSInteger l_iLowerIndex = 0;
    NSInteger l_iUpperIndex = 0;

    for (int i = 0; i < l_uiLength; i++)
    {
        NSInteger l_iCtrPalendromeLength = 0;
        NSInteger l_ilower = i;
        NSInteger l_iUpper = i;
        
        
        while (l_ilower >= 0
               && l_iUpper < l_uiLength
               && buffer[l_ilower] == buffer[l_iUpper])
        {
            l_iCtrPalendromeLength++;
            l_iUpper++;
            l_ilower--;
        }
        
        if (l_iMaxPalendromeLength < l_iCtrPalendromeLength)
        {
            l_iMaxPalendromeLength = l_iCtrPalendromeLength;
            l_iLowerIndex = ++l_ilower;
            l_iUpperIndex = --l_iUpper;
        }
    }
    
    l_strLongestPalendrome = [self substringWithRange:NSMakeRange(l_iLowerIndex, (l_iUpperIndex - l_iLowerIndex) + 1)];
    return l_strLongestPalendrome;
}

@end
