//
//  JSNetworkRequestHandler.m
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "JSNetworkRequestHandler.h"
#import "JSNetworkRequest.h"
#import "JSModelRepository.h"

// category extension
@interface JSNetworkRequestHandler()
{
    // not so great set to keep log of images being fetched
    // so that the same images are not refetched
    //
    NSMutableSet* m_setOfImageRequestsBeingFetched;
}
@property (nonatomic, retain) NSMutableSet* imageRequestsBeingFetched;
@end

// singleton class for handling all the network requests
//
@implementation JSNetworkRequestHandler

@synthesize imageRequestsBeingFetched = m_setOfImageRequestsBeingFetched;

#pragma mark Singleton Class Related

static JSNetworkRequestHandler* s_sharedNetworkRequestHandler = nil;

+ (JSNetworkRequestHandler*) sharedNetworkRequestHandler
{
    @synchronized(self)
    {
        if (!s_sharedNetworkRequestHandler)
        {
            // do not assign here
            //
            [[self alloc] init];
        }
    }
    
    return s_sharedNetworkRequestHandler;
}

// allocWithZone
+ (id) allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (!s_sharedNetworkRequestHandler)
        {
            s_sharedNetworkRequestHandler = [super allocWithZone:zone];
        }
    }
    
    return s_sharedNetworkRequestHandler;
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
        m_setOfImageRequestsBeingFetched = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void) dealloc
{
    [m_setOfImageRequestsBeingFetched release];
    [super dealloc];
}


#pragma mark PublicMethods
// public methods for network request
//
- (void) loadDataForNetworkRequest:(JSNetworkRequestType)in_requestType fromURLString:(NSString*)in_strURL
{
    NSAssert(in_strURL.length, @"request url is empty");
    
    // check if we are already in the process of fetching
    //
    if (JSNRT_LoadObjectImage == in_requestType
        || JSNRT_LoadUserAvatar == in_requestType)
    {
        if ([self.imageRequestsBeingFetched containsObject:HashString(in_strURL)])
        {
            return;
        }
        else
        {
            // add to the fetching set so that we do not send the same request again when the image is being fetched
            [self.imageRequestsBeingFetched addObject:HashString(in_strURL)];
        }
    }
    
    // request object
    //
    JSNetworkRequestObject* l_networkRequestObject = [[JSNetworkRequestObject alloc] initWithRequestType:in_requestType
                                                                                         whereRequestURL:in_strURL];
    
    // request
    //
    JSNetworkRequest* l_networkRequest = [[JSNetworkRequest alloc] initWithNetworkObject:l_networkRequestObject
                                                                      andNetworkDelegate:self];
    [l_networkRequest load];
    
    // release memory
    [l_networkRequest release];
    [l_networkRequestObject release];
}


#pragma mark JSNetworkRequestDelegate

// delegate called after successfull response from server/url
//
- (void) didFinishLoadingSuccessfullyNetworkObject:(JSNetworkRequestObject*)theNetworkObject withResponse:(NSData*)theResponseData
{
#if defined(DEBUG) || defined(_DEBUG)
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    
    // this has to be in the main thread
    //
    NSAssert([NSThread isMainThread], @"this shold be in main thread");

    
    NSAssert(theNetworkObject, @"network object is nil");
    NSAssert(theResponseData, @"response data is nil");
    
    JSModelRepository* l_modelRepository = [JSModelRepository sharedModelRepository];
    
    switch (theNetworkObject.networkRequestType)
    {
        case JSNRT_LoadObjectsList:
        {
            NSArray* l_arrOfObjects = [NSJSONSerialization JSONObjectWithData:theResponseData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:nil];
            
            [l_modelRepository addObjectsFromArray:l_arrOfObjects];
            break;
        }
        case JSNRT_LoadObjectImage:
        {
            UIImage* l_objectImage = [UIImage imageWithData:theResponseData];
            if (l_objectImage)
            {
                [l_modelRepository addOrUpdateImage:l_objectImage withKey:HashString(theNetworkObject.requestURL)];
            }
            
            // remove from the fethching set
            [self.imageRequestsBeingFetched removeObject:HashString(theNetworkObject.requestURL)];
            
            break;
        }
        case JSNRT_LoadUserAvatar:
        {
            UIImage* l_avatarImage = [UIImage imageWithData:theResponseData];
            if (l_avatarImage)
            {
                [l_modelRepository addOrUpdateAvatarImage:l_avatarImage withKey:HashString(theNetworkObject.requestURL)];
            }
            
            // remove from the fethching set
            [self.imageRequestsBeingFetched removeObject:HashString(theNetworkObject.requestURL)];
            
            break;
        }
        default:
        {
            NSAssert(NO, @"unknown request ?");
            break;
        }
    }
    
}

// in case of failure
- (void) didFailedLoadingNetworkObject:(JSNetworkRequestObject*)theNetworkObject withError:(NSError *)theError
{
#if defined(DEBUG) || defined(_DEBUG)
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
}



@end
