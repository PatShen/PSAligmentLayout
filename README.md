# PSAligmentLayout

## Usage

```objc

PSAligmentLayout* layout = [[PSAligmentLayout alloc] init];

// If not set this property or set it to `YES`, it will create a word wrap collection.
[layout setAutoWordWrap:NO];

CGRect frame = CGRectMake(0, 0, 320, 300);
UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];

...

```