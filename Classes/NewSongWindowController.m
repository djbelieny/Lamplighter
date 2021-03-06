#import "NewSongWindowController.h"

#import "ApplicationDelegate.h"
#import "Song.h"
#import "MainWindowController.h"
#import "SongsArrayController.h"

@implementation NewSongWindowController

/********************
 * INSTANCE METHODS *
 ********************/

- (IBAction) newSong:sender {
  self.titleErrors = YES;
  self.contentErrors = YES;
  // Resetting TextField values from former Song creations
  [titleField setStringValue:@""];
  [contentField setStringValue:@""];
  [copyrightField setStringValue:@""];
  [self updateButtons];
  [self.window makeFirstResponder:titleField];
  [NSApp beginSheet:self.window modalForWindow:[[NSApp mainWindowController] window] modalDelegate:self didEndSelector:@selector(sheetEnded:returnCode:contextInfo:) contextInfo:NULL]; 
}

- (IBAction) cancelNewSong:sender {
  [NSApp endSheet:self.window returnCode:NSCancelButton];
}

- (IBAction) saveNewSong:sender {
  [NSApp endSheet:self.window returnCode:NSOKButton];
}

/*************
 * CALLBACKS *
 *************/

- (void) sheetEnded:(NSWindow*)sheet returnCode:(int)code contextInfo:(void*)context {
  if (code == NSOKButton) {
    Song *song = [[NSApp songsArrayController] newObject];
    // We're trusting in that the Song Entity will normalize its stuff
    [song setValue:[titleField stringValue] forKey:@"title"];
    [song setValue:[contentField stringValue] forKey:@"content"];
    [song setValue:[copyrightField stringValue] forKey:@"footnote"];
    [[NSApp songsArrayController] addObject:song];
  }
  [sheet orderOut:nil];
}

@end
