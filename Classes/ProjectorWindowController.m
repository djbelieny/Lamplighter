#import "ProjectorWindowController.h"

#import "ApplicationDelegate.h"
#import "ProjectorController.h"
#import "SlideView.h"

@implementation ProjectorWindowController

@synthesize pdfView;

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  debugLog(@"[ProjectorWindowController] awakeFromNib");
  [self setupWindow];
}

- (void) setupWindow {
  [self.window setMovableByWindowBackground:YES];
  NSSize size = [[NSApp projectorController] sizeOfProjectorScreen];
  [self.window setContentSize:NSMakeSize(250, 250 / (size.width / size.height))];
}

/********************
 * INSTANCE METHODS *
 ********************/

- (BOOL) isWindowVisible {
  return [self.window isVisible];
}

- (void) updateSlide {
  SlideView *slideView = [[SlideView alloc] initWithSlide:[[NSApp projectorSlideController] selection] andPreviewMode:NO];
  [self.window setContentView:slideView];
}

@end