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


