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


## Default Storage Location

- On iOS, this directory is in the app's own storage location (app UUID -> Library -> Application Support) 
- On the Mac, it's a shared location in the user's Library: `~/Library/Application Support/default.store`, which is a sqlite db.


## Proble and Waldaround

### Can't manually trigger sync.

Could manually fetch recent changed data, and merge to local data.

### Can't enable undo if set model container via `.modelContainer(sharedModelContainer)`
  
Use `.modelContainer(sharedModelContainer)` to debug. Use `.modelContainer(for: Todo.self, isUndoEnabled: true)` for release.

## Other Tips

View CloudKit via [web dashboard](https://icloud.developer.apple.com/). This is helpful for debug. e.g., change data on iPhone, but not synced to macOS, could verify whether the data already uploaded to cloud.
