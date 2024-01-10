## Enable CloudKit

- Got to Project settings > Targets > General > Signing & Capabilites > Background Modes (+ Capability if hasn’t). 
- Enable “Remove notifications”. 
- Enable “CloudKit” services. 
- Add container with id of “iCloud.xxx”.

Note: After the container created, need to wait some time util it could be used.

Some limits:

- The primary things to be aware of are that unique constraints are not supported.
- Relationships must be optional ( even if you default them to empty arrays).
- All values must have a default or be nil.
- @Query doesn't update itself when installed on a view and it gets a push from the web -  [but there's a neat trick to get around it.](https://alexanderlogan.co.uk/blog/wwdc23/08-cloudkit-swift-data)

Note: If user disables iCloud permission, the app will store the data locally, can't fetch from CloudKit, don't crash. If user enables again, it will upload the local data to CloudKit. This is test result.

## Default Storage Location

- On iOS, this directory is in the app's own storage location (app UUID -> Library -> Application Support) 
- On the Mac, it's a shared location in the user's Library: `~/Library/Application Support/default.store`, which is a sqlite db.


## Problem and Walkaround

### Can't manually trigger sync.

Could manually fetch recent changed data, and merge to local data.

### Can't enable undo if set model container via `.modelContainer(sharedModelContainer)`
  
Use `.modelContainer(sharedModelContainer)` to debug. Use `.modelContainer(for: Todo.self, isUndoEnabled: true)` for release.

### Can't pause or stop sync via CloudKit once it's enabled.

### Can't manually deal with conflict and merge.

As everything is automatically, seems can't 'manually deal with conflict and merge. Maybe could deep into CloudKit itself to do it.

## Other Tips

View CloudKit via [web dashboard](https://icloud.developer.apple.com/). This is helpful for debug. e.g., change data on iPhone, but not synced to macOS, could verify whether the data already uploaded to cloud.

The mininum requirement for SwiftData is as following.
- iOS 17.0+
- iPadOS 17.0+
- macOS 14.0+
- Mac Catalyst 17.0+
- tvOS 17.0+
- watchOS 10.0+
- visionOS 1.0+

But need to know, the earlier OS version may contains issue. E.g., iOS 17.0 has issue with SwiftData but fixed in iOS 17.1.

Whend upgrade/change model, could use `migrationPlan`.

## Unknown

- Not sure `.externalStorage` could be sync via CloudKit or not, what else need to do beside CloudKit sync itself.
- Didn't find a way to sort by `modificationDate`. Could only manually maintain the modificationDate of the model, which is annoying.
