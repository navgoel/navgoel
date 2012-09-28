//
//  JSModelRepository.m
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "JSModelRepository.h"
#import "JSObject.h"
#import "JSUserInfo.h"
#import "JSKeyValueConstants.h"

// category extension
//
@interface JSModelRepository()
{
    // array with JSObjects
    //
    // note: Ideally , I would have created a more concrete object
    // like an object with list of objects.
    //
    NSMutableArray* m_arrOfObjects;
    
    
    // dictionary for image caching
    // key: hash value of image url - nsstring
    // value: UIImage object
    NSMutableDictionary* m_dictOfImages;
}
@property (nonatomic, retain) NSMutableDictionary* images;
@end

@implementation JSModelRepository

@synthesize objects = m_arrOfObjects;
@synthesize images = m_dictOfImages;

#pragma mark Singleton Class Related

static JSModelRepository* s_sharedModelRepository = nil;

+ (JSModelRepository*) sharedModelRepository
{
    @synchronized(self)
    {
        if (!s_sharedModelRepository)
        {
            // do not assign here
            //
            [[self alloc] init];
        }
    }
    
    return s_sharedModelRepository;
}

// allocWithZone
+ (id) allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (!s_sharedModelRepository)
        {
            s_sharedModelRepository = [super allocWithZone:zone];
        }
    }
    
    return s_sharedModelRepository;
}

// copyWithZone
- (id) copyWithZone:(NSZone *)zone
{
    return self;
}


// retain - do nothing
- (id) retain
{
    return self;
}

// retain count: faked number
- (unsigned) retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

// release - do nothing
- (oneway void) release
{
    //do nothing
}

// autorelease - do nothing
- (id) autorelease
{
    return self;
}


#pragma mark NSObject

- (id) init
{
    self = [super init];
    NSAssert(self, @"could not initialize self");
    
    if (self)
    {
        m_arrOfObjects = [[NSMutableArray alloc] init];
        m_dictOfImages = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) dealloc
{
    [m_arrOfObjects release];
    [m_dictOfImages release];
    [super dealloc];
}

#pragma mark ----PublicMethods----


#pragma mark Object List related
//
- (void) addObjectsFromArray:(NSArray*)in_arrOfObjects
{
    // remove all objects first
    [self.objects removeAllObjects];
    
    for (NSDictionary* l_objectDictionary in in_arrOfObjects)
    {
        JSObject* l_object = [[JSObject alloc] initWithObjectDictionary:l_objectDictionary];
        [self.objects addObject:l_object];
        [l_object release];
    }
    
    
    // dispatch notification
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyListObjectsAdded object:self];
}



#pragma mark Image Cache related
//
- (void) addOrUpdateImage:(UIImage*)in_uiImage withKey:(NSString*)in_strKey
{
    NSAssert(in_uiImage, @"image is nill");
    NSAssert(in_strKey.length, @"key is nill");

    [self.images setObject:in_uiImage forKey:in_strKey];
    
    // dispatch notification
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyObjectImageAdded object:self];
}

- (void) addOrUpdateAvatarImage:(UIImage*)in_uiImage withKey:(NSString*)in_strKey
{
    NSAssert(in_uiImage, @"image is nill");
    NSAssert(in_strKey.length, @"key is nill");
    
    [self.images setObject:in_uiImage forKey:in_strKey];
    
    // dispatch notification
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyAvatarImageAdded object:self];
}



- (UIImage*) getUIImageForKey:(NSString*)in_strKey
{
    NSAssert(in_strKey.length, @"key is nill");
    return [self.images objectForKey:in_strKey];
}



@end
