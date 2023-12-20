//
// import 'package:my_enterprise_app/demo/theme/them_config.dart';
// import 'package:provider/provider.dart';
// class ProvideConfig{
//
//   ///用来初始化 Provider 以及 ThemConfigModel
//   static init({child,dispose=false}){
//     ///初始化 providers
//
//     final providers = Providers()..provide(Provider.value(ThemConfigModel()));
//     // Provider.ini
//     /// [child] 指的是要进行 状态管理的子 Widget
//     /// [providers] 状态的管理器
//     return ProviderNode(child: child, providers: providers, dispose: dispose);
//   }
//
//   // 通过Provide小部件获取状态封装
//   static connect<T>({builder, child, scope}) {
//     return Provide<T>(builder: builder, child: child, scope: scope);
//   }
//
//
//   // 通过Provide.value<T>(context)获取封装
//   static Provider value<T>(context, {scope}) {
//     return Provider.value<T>(context,scope: scope, value: null,);
//   }
// }