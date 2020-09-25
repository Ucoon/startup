# somo_video_app_flutter



### commit 提交规范
* $git cz

* 用于说明 commit 的类别，只允许使用下面标识。

  - feat：新功能（feature）

  - fix：修补bug




### 代码规范
* 文件命名规范
	- 文件命名使用下划线命名法，如：hello_world
	- 请使用英文进行命名，不允许使用拼音。命名要求具有可读性，尽量避免使用缩写与数字
	- 未完待续

* 代码编码规范
	- 文件编码统一使用 UTF-8 编码；
	- 前端编码采用首字母小写驼峰法. Widget Class 必须采用首字母大写驼峰法.

### 文件目录结构(以LIb文件说明)

- lib
	- main.dart 入口文件
	- api 服务端交换接口，分业务
	- config    配置文件，如sp
	- generated 国际化
  - l10n      国际化
	- model 存放模型, 不应该加入逻辑层
	- router 路由
	- pages 展示界面
  - styles 组件通用样式
  - util  公共工具
	- widget 组件，分通用，业务，基础
  - res 存放颜色值、字体大小等资源文件

 ### HTTP的简单使用方式

  - 前提：api.dart 增加要请求的url
  - 用法: 以登录为例，调用如下var response = await httpUtil.post<Map>(Api.DO_LOGIN, data: {
      'account': username,
      'password': digest.toString(),
      'dt': dt,
      'os': os,
      'osver': osver,
      'model': model,
      'version': version,
      'device': device,
    });
  - Json数据自动生成实体类方式推荐
    1. 使用网页自动生成： https://app.quicktype.io/
    2. 使用 json_serializable（官方推荐：https://github.com/google/json_serializable.dart/tree/master/example）

  ### Router的简单使用方式

  - 在路由配置信息增加对应组件,路由配置表对应在app/router.dart routerMapping全局变量，在该映射表增加样例 
    举例如下：
    'test': StructRouter(TestPageIndex(), -1, null, true)
  - 代码调用：Router().open(context, 'somo://test?param=1001');

  ### Provider MVVM的简单使用方式
  * 创建以下
   - Model （model目录下分业务创建）        继承ChangeNotifier，在更新数据的方法中调用notifyListeners
   - ViewModel（view_model目录下分业务创建）继承ViewStateModel，调用model触发监听
   - View （pages目录下分业务创建）         容器组件中包含ProviderWidget注册监听


  ### SharedPreferences的简单使用方式 
  - StorageManager.sharedPreferences.setString(key, value)
  - StorageManager.sharedPreferences.setBool(key, value)
  - StorageManager.sharedPreferences.setDouble(key, value)
  - StorageManager.sharedPreferences.setInt(key, value)
  - StorageManager.sharedPreferences.setStringList(key, value)  
  - StorageManager.sharedPreferences.remove(key); //删除指定键
  - StorageManager.sharedPreferences.clear();//清空键值对
    查和增（改）是一样的，执行getXXX()


  ###数据获取
  单独订阅model中的某个参数(样例为订阅somoCode),
  列表中也将每个widget写为Selector,并selector返回list[i]即可
  参考https://juejin.im/post/6844903864852807694#heading-13的Selector中,selector: (context, provider) => provider.goodsList[index],
  - dart
  Selector<MeetingModel, String>(
    selector: (context, provider) {
        return provider.somoCode;
    },
    builder: (context, value, child) {
        return Text("somoCode = $value");
    },
  ),
  selector不能直接对比对象(地址相同),所以可以使用tuple辅助处理
  -dart
      Selector<MeetingModel, Tuple4<String, int, int, int>>(
        selector: (context, provider) {
          var user = provider.shareUser;
          return Tuple4(user.somoUid, user.TextureId, user.videoWidth, user.videoHeight);
        },
        builder: (context, tuple, child) {
          double ratio = tuple.item3 / tuple.item4;
          return Center(
            child: AspectRatio(
              aspectRatio: ratio,
              child: TextureWidget(tuple.item2),
            ),
          );
        },
      );
  ------------listView-------------
  以下写法,如果对象没有变更,则不能拿到更新
  - dart
      ListView.builder(
          itemCount: provider.total,
          itemBuilder: (context, index) {
          
            return Selector<GoodsListProvider, Goods>(
              selector: (context, provider) => provider.goodsList[index],
              builder: (context, data, child) {
                print(('No.${index + 1} rebuild'));
              },
            );
          },
        );
  获取全局Model
  _meetingModel = Provider.of(context, listen: false);

  ####本地图片资源显示
  flutter中,图片路径默认1x,若要使用2.0x,3.0x(对应安卓xxhdpi)须要将对应图片放至3.0x目录下
  否则系统不能读取图片真实大小,再必须指定缩放,大小 
  若文件夹下无1x资源,会导致flutter找不到图片,所以需要在pubspec.yaml中申明完整路径
  以下未导入图片步骤:
  1.将图片放至assets/images/3.0x/下 (对应xxhpi和ios3x图片)
  2.在pubspec.yaml中完整声明图片路径(实际)
  flutter:
    assets:
      - assets/images/contact_icon_my_tenant_icon.png
      - assets/images/contact_icon_tenant_add_user_icon.png
  3.在代码中通过方法获取icon
  ImageHelper.getIconPng("contact_icon_my_tenant_icon");
