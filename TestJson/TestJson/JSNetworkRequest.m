//
//  JSNetworkRequest.m
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "JSNetworkRequest.h"
#import "JSNetworkRequestObject.h"

// category extension for internal variables
//
@interface JSNetworkRequest()
{
    // member variable to receive data
    //
    NSMutableData* m_receivedData;
 
    // network object associated with request
    //
    JSNetworkRequestObject* m_networkObject;
    
    // delegate to decide
    //
    id <JSNetworkRequestDelegate> m_networkDelegate;
}

@property (nonatomic, retain) NSMutableData*                    receivedData;
@property (nonatomic, retain) JSNetworkRequestObject*           networkObject;
@property (nonatomic, assign)  id <JSNetworkRequestDelegate>    networkDelegate;

@end


@implementation JSNetworkRequest
// synthesizes
@synthesize receivedData = m_receivedData;
@synthesize networkObject = m_networkObject;
@synthesize networkDelegate = m_networkDelegate;

#pragma mark NSObject
// designated initializers
- (id) initWithNetworkObject:(JSNetworkRequestObject*)theObject andNetworkDelegate:(id <JSNetworkRequestDelegate>) theNetworkDelegate
{
    self = [super init];
    NSAssert(self, @"couldn't initialize self");
    
    NSAssert(theObject, @"network request Object is empty");
    NSAssert(theNetworkDelegate, @"network delegate is empty");    
    
    if (self)
    {
        // initialization
        m_receivedData = [[NSMutableData alloc] init];
        m_networkObject = [theObject retain];
        m_networkDelegate = theNetworkDelegate;
    }
    
    return self;
}

- (void) dealloc
{
    m_networkDelegate = nil;
    [m_networkObject release];
    [m_receivedData release];
    
    [super dealloc];
}


#pragma mark Public Methods
// loads the content from the initialized url
//
- (void) load
{
    // input string should not be empty
    NSAssert(self.networkObject, @"network request is not properly initialized");
    
    NSAssert(self.networkObject.requestURL.length, @"empty request URL");

    
    // url should not be malformed, otheriwse this will be nil
    //
    NSURL* l_url = [NSURL URLWithString:self.networkObject.requestURL];
    NSAssert(l_url, @"couldn't intiialize url");
    
    NSURLRequest *l_urlRequest = [[NSURLRequest alloc] initWithURL:l_url
                                                       cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
                                                   timeoutInterval:10];
    
    NSURLConnection *l_urlConnection = [[NSURLConnection alloc] initWithRequest:l_urlRequest
                                                                       delegate:self
                                                               startImmediately:YES];
    
 	[l_urlConnection release];
    [l_urlRequest release];
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
#if defined(DEBUG) || defined(_DEBUG)
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    
    // handle error here
    //
    if ([self.networkDelegate respondsToSelector:@selector(didFailedLoadingNetworkObject:withError:)])
    {
        [self.networkDelegate didFailedLoadingNetworkObject:self.networkObject withError:error];
    }
}


#pragma mark NSURLConnectionDataDelegate

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
#if defined(DEBUG) || defined(_DEBUG)
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    
    // return the redirected request
    //
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
#if defined(DEBUG) || defined(_DEBUG)
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif

    // reset the receiving data length
    //
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
#if defined(DEBUG) || defined(_DEBUG)
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    
    NSAssert(self.receivedData, @"receivedData should be initialized");
    // append data
    //
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
#if defined(DEBUG) || defined(_DEBUG)
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    
    NSAssert(self.receivedData, @"receivedData should be initialized");    
    
    // call the delegate to parse.
    //
    if ([self.networkDelegate respondsToSelector:@selector(didFinishLoadingSuccessfullyNetworkObject:withResponse:)])
    {
        [self.networkDelegate didFinishLoadingSuccessfullyNetworkObject:self.networkObject withResponse:self.receivedData];
    }
}


#if 0
- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request;
- (void)connection:(NSURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
#endif


@end
