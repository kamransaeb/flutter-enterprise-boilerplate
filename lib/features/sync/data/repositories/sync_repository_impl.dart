// // lib/features/sync/data/repositories/sync_repository_impl.dart
// import 'package:flutter_enterprise_boilerplate/infrastructure/cache/cache_manager.dart';

// @Injectable(as: SyncRepository)
// class SyncRepositoryImpl implements SyncRepository {
//   final CacheManager _cacheManager;
//   final NetworkInfo networkInfo;
  
//   SyncRepositoryImpl(this._cacheManager, this.networkInfo);
  
//   @override
//   Future<Either<Failure, Unit>> syncOfflineData() async {
//     if (await networkInfo.isConnected) {
//       // Get pending sync items from cache
//       final pendingItems = await _getPendingSyncItems();
      
//       // Upload to server
//       for (final item in pendingItems) {
//         await _uploadToServer(item);
//         await _cacheManager.removeCachedFile(item.id);
//       }
//     }
    
//     return const Right(unit);
//   }
  
//   Future<List<SyncItem>> _getPendingSyncItems() async {
//     final urls = await _cacheManager.getCachedUrls();
//     final pendingItems = <SyncItem>[];
    
//     for (final url in urls.getOrElse(() => [])) {
//       if (url.startsWith('sync_')) {
//         final data = await _cacheManager.getDataFromCache(url);
//         data.fold(
//           (failure) => null,
//           (cachedData) {
//             pendingItems.add(SyncItem.fromJson(json.decode(cachedData)));
//           },
//         );
//       }
//     }
    
//     return pendingItems;
//   }
// }