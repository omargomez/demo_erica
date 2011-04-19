#import <UIKit/UIKit.h>
#include "time.h"

@interface DragView : UIImageView
{
	CGPoint startLocation;
}
@end

@implementation DragView
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	// Retrieve the touch point
	CGPoint pt = [[touches anyObject] locationInView:self];
	startLocation = pt;
	[[self superview] bringSubviewToFront:self];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	// Move relative to the original touch point
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect frame = [self frame];
	frame.origin.x += pt.x - startLocation.x;
	frame.origin.y += pt.y - startLocation.y;
	[self setFrame:frame];
}
@end

@interface HelloController : UIViewController
@end

@implementation HelloController
#define MAXFLOWERS 16
CGPoint randomPoint() {return CGPointMake(random() % 256, random() % 396);}

- (void)loadView
{
	// Create the main view
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor blackColor];
	self.view = contentView;
    [contentView release];
	
	// Add the flowers to random points on the screen	
	for (int i = 0; i < MAXFLOWERS; i++)
	{
		CGRect dragRect = CGRectMake(0.0f, 0.0f, 64.0f, 64.0f);
		dragRect.origin = randomPoint();
		DragView *dragger = [[DragView alloc] initWithFrame:dragRect];
		NSString *whichFlower = [[NSArray arrayWithObjects:@"blueFlower.png", @"pinkFlower.png", @"orangeFlower.png", nil] objectAtIndex:(random() % 3)];
		[dragger setImage:[UIImage imageNamed:whichFlower]];
		[dragger setUserInteractionEnabled:YES];
		[self.view addSubview:dragger];
		[dragger release];
	}
}
@end

@interface SampleAppDelegate : NSObject <UIApplicationDelegate> 
@end

@implementation SampleAppDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application {	

    srandom(time(0));

	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	HelloController *hello = [[HelloController alloc] init];
	[window addSubview:hello.view];
	[window makeKeyAndVisible];
}
@end

int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"SampleAppDelegate");
	[pool release];
	return retVal;
}
