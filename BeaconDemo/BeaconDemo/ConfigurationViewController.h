#import <UIKit/UIKit.h>

@interface ConfigurationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;


- (IBAction)regenerateUUIDAction:(id)sender;

@end
