//
//  LPAppDelegate.m
//  LongestPalendrome
//
//  Created by Navin Goel on 11/04/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "LPAppDelegate.h"
#import "NSString-Extension.h"
#import "NSNumber-Extension.h"
#import "NSArray-Extension.h"

@implementation LPAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController* l_VC = [[UIViewController alloc] init];
	UINavigationController* l_navigationController = [[[UINavigationController alloc] initWithRootViewController:l_VC] autorelease];
    [l_VC release];
    [self.window setRootViewController:l_navigationController];

    [self.window makeKeyAndVisible];
    
    
    
    // Question 1:
    //
    {
        NSString* l_strInputString = @"FourscoreandsevenyearsagoourfaathersbroughtforthonthiscontainentanewnationconceivedinzLibertyanddedicatedtothepropositionthatallmenarecreatedequalNowweareengagedinagreahtcivilwartestingwhetherthatnaptionoranynartionsoconceivedandsodedicatedcanlongendureWeareqmetonagreatbattlefiemldoftzhatwarWehavecometodedicpateaportionofthatfieldasafinalrestingplaceforthosewhoheregavetheirlivesthatthatnationmightliveItisaltogetherfangandproperthatweshoulddothisButinalargersensewecannotdedicatewecannotconsecratewecannothallowthisgroundThebravelmenlivinganddeadwhostruggledherehaveconsecrateditfaraboveourpoorponwertoaddordetractTgheworldadswfilllittlenotlenorlongrememberwhatwesayherebutitcanneverforgetwhattheydidhereItisforusthelivingrathertobededicatedheretotheulnfinishedworkwhichtheywhofoughtherehavethusfarsonoblyadvancedItisratherforustobeherededicatedtothegreattdafskremainingbeforeusthatfromthesehonoreddeadwetakeincreaseddevotiontothatcauseforwhichtheygavethelastpfullmeasureofdevotionthatweherehighlyresolvethatthesedeadshallnothavediedinvainthatthisnationunsderGodshallhaveanewbirthoffreedomandthatgovernmentofthepeoplebythepeopleforthepeopleshallnotperishfromtheearth";
        
        NSLog(@"Longest Palendrome: %@", [l_strInputString longestPalendrome]);
    }
    
    
    // Question 2:
    //
    {
        NSNumber* l_primeFibonaciNumber = [[NSNumber numberWithFloat:227000] primeFibonacciNumberGreaterThanSelf];
        NSNumber* l_primeFibonaciNumberAdded = [NSNumber numberWithFloat:([l_primeFibonaciNumber floatValue] + 1)];
        
        NSArray* l_arrOfNumbers = [l_primeFibonaciNumberAdded primeDivisorsOfSelf];
        NSInteger l_iSumOfPrimeDivisors = 0;
        for (NSNumber* l_iNumber in l_arrOfNumbers)
        {
            l_iSumOfPrimeDivisors += [l_iNumber intValue];
        }
        NSLog(@"Sum of Prime Divisors: %d", l_iSumOfPrimeDivisors);
    }
    
    
    // Question 3:
    //
    {
        NSArray* l_arrOfNumbersForSubsets = [[NSArray alloc] initWithObjects:
                                             [NSNumber numberWithInteger:3],
                                             [NSNumber numberWithInteger:4],
                                             [NSNumber numberWithInteger:9],
                                             [NSNumber numberWithInteger:14],
                                             [NSNumber numberWithInteger:15],
                                             [NSNumber numberWithInteger:19],
                                             [NSNumber numberWithInteger:28],
                                             [NSNumber numberWithInteger:37],
                                             [NSNumber numberWithInteger:47],
                                             [NSNumber numberWithInteger:50],
                                             [NSNumber numberWithInteger:54],
                                             [NSNumber numberWithInteger:56],
                                             [NSNumber numberWithInteger:59],
                                             [NSNumber numberWithInteger:61],
                                             [NSNumber numberWithInteger:70],
                                             [NSNumber numberWithInteger:73],
                                             [NSNumber numberWithInteger:78],
                                             [NSNumber numberWithInteger:81],
                                             [NSNumber numberWithInteger:92],
                                             [NSNumber numberWithInteger:95],
                                             [NSNumber numberWithInteger:97],
                                             [NSNumber numberWithInteger:99],
                                             nil];
        
        NSLog(@"Count of Subsets: %d",[l_arrOfNumbersForSubsets countOfSubsets]);
        [l_arrOfNumbersForSubsets release];
        
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
