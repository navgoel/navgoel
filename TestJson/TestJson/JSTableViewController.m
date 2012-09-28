//
//  JSTableViewController.m
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "JSTableViewController.h"
#import "JSModelRepository.h"
#import "JSNetworkRequestHandler.h"
#import "JSObject.h"
#import "JSUserInfo.h"
#import "JSKeyValueConstants.h"
#import "JSTableViewCell.h"

// category extension for internal variables
@interface JSTableViewController ()
{
    // table view
    //
    UITableView* m_tableView;
    
    // array for renderring
    //
    NSMutableArray* m_arrOfObjects;
    
    // whether the view subscribed to model or not
    //
    BOOL m_bSubscribedToModel;
    
    // whether the view is in foreground or background
    //
    BOOL m_bIsForeground;
}
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSMutableArray* objects;

@end

// category for private methods
@interface JSTableViewController (PrivateMethods)

// relayout subviews
//
- (void) relayoutSubViews;

// reload the data
- (void) reloadObjectListData;

// register observer
- (void) registerObservers;

// deregister observer
- (void) deRegisterObservers;

@end

@implementation JSTableViewController

@synthesize tableView = m_tableView;
@synthesize objects = m_arrOfObjects;

#pragma mark ViewLifeCycle

- (void) loadView
{
    // call super
    [super loadView];
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // title
    self.title = @"Pinboard";

    // refresh buttom incase list is not loaded
    //
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self
                                                                                           action:@selector(onRefresh)] autorelease];
    // add the subviews
    //
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSAssert(!m_bSubscribedToModel, @"should have deregistered earlier");
    [self registerObservers];
}

// Called when the view is about to made visible. Default does nothing
//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    m_bIsForeground = YES;
    
    [self relayoutSubViews];
    [self reloadObjectListData];
}

// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
//
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    m_bIsForeground = NO;
}

- (void)viewDidUnload
{
    NSAssert(m_bSubscribedToModel, @"should have registered earlier");
    [self deRegisterObservers];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self relayoutSubViews];
}



#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JSTableViewCell heightOfTableViewCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger l_iCount = 0;
    
    if ([self.objects count])
    {
        l_iCount = 1;
    }
    
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // check row index.
    assert(indexPath.row >= 0 && indexPath.row < [self.objects count]);

    JSTableViewCell* l_tableCell = nil;
    static NSString *l_strCellIdentifier = @"JSTableViewCell";

    JSModelRepository* l_modelRepository = [JSModelRepository sharedModelRepository];
    JSNetworkRequestHandler* l_networkHandler = [JSNetworkRequestHandler sharedNetworkRequestHandler];

    l_tableCell = (JSTableViewCell*)[tableView dequeueReusableCellWithIdentifier:l_strCellIdentifier];
    if (l_tableCell == nil)
    {
        l_tableCell = [[[JSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:l_strCellIdentifier] autorelease];
    }
    
    NSAssert(l_tableCell, @"tabelcell is nill");
    JSObject* l_object = [self.objects objectAtIndex:indexPath.row];

    UIImage* l_avatarImage = nil;
    UIImage* l_objectImage = nil;
    
    // avatar image
    {
        l_avatarImage = [l_modelRepository getUIImageForKey:HashString(l_object.userInfo.userAvatarImageURL)];
        if (!l_avatarImage)
        {
            [l_networkHandler loadDataForNetworkRequest:JSNRT_LoadUserAvatar fromURLString:l_object.userInfo.userAvatarImageURL];
            l_avatarImage = [UIImage imageNamed:@"nullimage.gif"];
        }
    }
    
    // object image
    {
        l_objectImage = [l_modelRepository getUIImageForKey:HashString(l_object.imageURLOfObject)];
        if (!l_objectImage)
        {
            [l_networkHandler loadDataForNetworkRequest:JSNRT_LoadObjectImage fromURLString:l_object.imageURLOfObject];
            l_objectImage = [UIImage imageNamed:@"nullimage.gif"];
        }
    }
    
    [l_tableCell setCellInfoWhereObjectImage:l_objectImage
                           objectDescription:l_object.descriptionOfObject
                        objectAttributeLabel:l_object.attributeOfObject
                             userAvatarImage:l_avatarImage
                                    userName:l_object.userInfo.userName
                                     andName:l_object.userInfo.name];
 
    return l_tableCell;
}

#pragma mark UITableViewDelegate



#pragma mark Notifications

- (void) receiveListObjectsAdded:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:kNotifyListObjectsAdded])
    {
        [self reloadObjectListData];
    }
}

- (void) receiveAvatarImageAdded:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:kNotifyAvatarImageAdded])
    {
        [self reloadObjectListData];
    }
}

- (void) receiveObjectImageAdded:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:kNotifyObjectImageAdded])
    {
        [self reloadObjectListData];
    }
}

#pragma mark NSObject

- (id) init
{
    self = [super init];
    NSAssert(self, @"couldnt initialize self");
    
    if (self)
    {
        m_arrOfObjects = [[NSMutableArray alloc] init];
        m_bSubscribedToModel = NO;
        m_bIsForeground = NO;
    }
    return self;
}

- (void) dealloc
{
    if (m_bSubscribedToModel)
    {
        [self deRegisterObservers];
    }
    [m_tableView release];
    [m_arrOfObjects release];
    
    [super dealloc];
}

@end


// category for private methods
@implementation JSTableViewController (PrivateMethods)

// relayout subviews
- (void) relayoutSubViews
{
    CGRect l_viewBounds = self.view.bounds;
    self.tableView.frame = l_viewBounds;
}

// reload the data
- (void) reloadObjectListData
{
    // clear the existing one
    [self.objects removeAllObjects];
    
    // reload from the model repository
    JSModelRepository* l_modelRepository = [JSModelRepository sharedModelRepository];
    [self.objects addObjectsFromArray:l_modelRepository.objects];
    
    // reload table data
    [self reloadTableData];
}

// reload table data
//
- (void) reloadTableData
{
    if (m_bIsForeground)
    {
        [self.tableView reloadData];
    }
}

// register observer
- (void) registerObservers
{
    NSAssert(!m_bSubscribedToModel, @"shouldn't register twice");

    NSNotificationCenter* l_notificationCenter = [NSNotificationCenter defaultCenter];
    
    
    [l_notificationCenter addObserver:self
                             selector:@selector(receiveListObjectsAdded:)
                                 name:kNotifyListObjectsAdded
                               object:[JSModelRepository sharedModelRepository]];
    
    [l_notificationCenter addObserver:self
                             selector:@selector(receiveAvatarImageAdded:)
                                 name:kNotifyAvatarImageAdded
                               object:[JSModelRepository sharedModelRepository]];

    [l_notificationCenter addObserver:self
                             selector:@selector(receiveObjectImageAdded:)
                                 name:kNotifyObjectImageAdded
                               object:[JSModelRepository sharedModelRepository]];


    m_bSubscribedToModel = YES;
}

// deregister observer
- (void) deRegisterObservers
{
    NSAssert(m_bSubscribedToModel, @"shouldn't deregister twice");
 
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    m_bSubscribedToModel = NO;
}

-(void) onRefresh
{
    JSNetworkRequestHandler* l_networkRequestHandler = [JSNetworkRequestHandler sharedNetworkRequestHandler];
    [l_networkRequestHandler loadDataForNetworkRequest:JSNRT_LoadObjectsList fromURLString:sHerokuAppFeedURL];
}

@end

