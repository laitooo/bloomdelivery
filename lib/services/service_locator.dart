import 'package:bloomdeliveyapp/business_logic/view_models/order/create_order_viewmodel.dart';
import 'package:bloomdeliveyapp/business_logic/view_models/user/usermenu_screen_viewmodel.dart';
import 'package:bloomdeliveyapp/services/google_map/google_map_service.dart';
import 'package:bloomdeliveyapp/services/order/order_service_strapi.dart';

import 'package:get_it/get_it.dart';

import 'package:bloomdeliveyapp/business_logic/view_models/login/login_screen_viewmodel.dart';

import 'package:bloomdeliveyapp/services/login/login_service_strapi.dart';

import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';
import 'package:bloomdeliveyapp/services/user/user_services.dart';
import 'package:bloomdeliveyapp/services/web_api/strapi_local_api.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // services
  serviceLocator.registerLazySingleton<StrapiLocalApi>(() => StrapiLocalApi());
  serviceLocator
      .registerLazySingleton<LoginServiceStrapi>(() => LoginServiceStrapi());
  serviceLocator
      .registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  /* serviceLocator
  serviceLocator.registerLazySingleton<ProfileService>(() => ProfileService()); */
  serviceLocator.registerLazySingleton<UserService>(() => UserService());
  serviceLocator
      .registerLazySingleton<OrderServiceStrapi>(() => OrderServiceStrapi());
  serviceLocator
      .registerLazySingleton<GoogleMapsServices>(() => GoogleMapsServices());

  // view models

  serviceLocator
      .registerFactory<LoginScreenViewModel>(() => LoginScreenViewModel());

  serviceLocator.registerFactory<UserMenuViewModel>(() => UserMenuViewModel());

  serviceLocator
      .registerFactory<CreateOrderViewModel>(() => CreateOrderViewModel());
}
