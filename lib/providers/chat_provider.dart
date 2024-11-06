import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:tataneu_clone/constants.dart';
import 'package:tataneu_clone/hive/chat_history.dart';
import 'package:tataneu_clone/hive/settings.dart';
import 'package:tataneu_clone/hive/user_model.dart';
import 'package:tataneu_clone/models/message.dart';


class ChatProvider extends ChangeNotifier{

  //list of messages
  List<Message> _inChatMessages = [];

  //page controller
  final PageController _pageController = PageController();

  //images file list
  List<XFile>? _imagesFileList = [];

  //index of current screen
  int _currentIndex = 0;

  //cuttent chatID
  String _currentChatID = '';

  //intialize generative model
  GenerativeModel? _model;

  //intialize text model
  GenerativeModel? _textModel;

  //intialize vision model
  GenerativeModel? _visionModel;

  //current mode
  String _modelType = 'gemini-pro';

  //loading bool
  bool _isLoading = false;

  //getters
  List<Message> get inChatMessages => _inChatMessages;

  PageController get pageController => _pageController;

  List<XFile>? get imagesFileList => _imagesFileList;

  int get currentIndex => _currentIndex;

  String get currentChatID => _currentChatID;

  GenerativeModel? get model => _model;

  GenerativeModel? get textModel => _textModel;

  GenerativeModel? get visionModel => _visionModel;

  String get modelType => _modelType;

  bool get isLoading => _isLoading;

  

  


  //init Hive Boxes
  static initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter(Constants.geminiDB);
    
    //register adapters
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(ChatHistoryAdapter());

      //open the chat history box
      await Hive.openBox<ChatHistory>(Constants.chatHistoryBox);
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());
      await Hive.openBox<UserModel>(Constants.userBox);
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SettingsAdapter());
      await Hive.openBox<UserModel>(Constants.settingsBox);
    }
    
  }
}