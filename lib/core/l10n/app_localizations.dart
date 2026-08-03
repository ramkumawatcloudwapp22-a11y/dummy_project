/// UI chrome strings for English / Hindi.
/// Content catalogs (faults, parts, etc.) use [L10nText] on models.
class AppLocalizations {
  final bool isHindi;

  const AppLocalizations(this.isHindi);

  String _t(String en, String hi) => isHindi ? hi : en;

  // Brand
  String get appName => 'Tech Yodha';
  String get appNameUpper => 'TECH YODHA';
  String get brandTagline =>
      _t('Technical Training & Knowledge Platform', 'तकनीकी प्रशिक्षण और ज्ञान मंच');
  String get servingNation =>
      _t('Serving the Nation with Knowledge', 'ज्ञान के साथ राष्ट्र की सेवा');
  String get loading => _t('Loading...', 'लोड हो रहा है...');
  String get indianArmy => 'INDIAN ARMY';
  String get indianArmyTechYodha =>
      _t('INDIAN ARMY  •  TECH YODHA', 'भारतीय सेना  •  टेक योद्धा');
  String get version => 'Version 1.0.0';
  String get secureReliable =>
      _t('Secure. Reliable. Always Ready.', 'सुरक्षित। विश्वसनीय। सदैव तैयार।');

  // Nav
  String get home => _t('Home', 'होम');
  String get training => _t('Training', 'प्रशिक्षण');
  String get drone => _t('Drone', 'ड्रोन');
  String get downloads => _t('Downloads', 'डाउनलोड');
  String get profile => _t('Profile', 'प्रोफ़ाइल');

  // Language
  String get language => _t('Language', 'भाषा');
  String get languageSubtitle =>
      _t('App language — English / हिंदी', 'ऐप भाषा — English / हिंदी');
  String get english => 'English';
  String get hindi => 'हिंदी';

  // Auth — Login
  String get welcomeBack => _t('Welcome Back, Soldier!', 'वापसी पर स्वागत है, सैनिक!');
  String get loginContinue =>
      _t('Login to continue to your account', 'अपने खाते में जारी रखने के लिए लॉगिन करें');
  String get emailAddress => _t('Email Address', 'ईमेल पता');
  String get enterEmail => _t('Enter your email address', 'अपना ईमेल पता दर्ज करें');
  String get armyNumber => _t('Army Number', 'आर्मी नंबर');
  String get enterArmyNumber =>
      _t('Enter your army number', 'अपना आर्मी नंबर दर्ज करें');
  String get password => _t('Password', 'पासवर्ड');
  String get enterPassword => _t('Enter your password', 'अपना पासवर्ड दर्ज करें');
  String get forgotPassword => _t('Forgot Password?', 'पासवर्ड भूल गए?');
  String get login => _t('LOGIN', 'लॉगिन');
  String get dontHaveAccount =>
      _t("Don't have an account? ", 'खाता नहीं है? ');
  String get createAccount => _t('Create Account', 'खाता बनाएँ');
  String get pleaseEnterEmail =>
      _t('Please enter your email address', 'कृपया अपना ईमेल पता दर्ज करें');
  String get pleaseEnterArmyNumber =>
      _t('Please enter your army number', 'कृपया अपना आर्मी नंबर दर्ज करें');
  String get passwordMin8 =>
      _t('Password must be at least 8 characters', 'पासवर्ड कम से कम 8 अक्षर का होना चाहिए');

  // Auth — Signup
  String get joinTechYodha => _t('Join Tech Yodha', 'टेक योद्धा से जुड़ें');
  String get createAccountSubtitle => _t(
        'Create your account to access technical training & knowledge platform',
        'तकनीकी प्रशिक्षण और ज्ञान मंच के लिए अपना खाता बनाएँ',
      );
  String get selectCategory => _t('Select Your Category', 'अपनी श्रेणी चुनें');
  String get agniveer => 'Agniveer';
  String get agniveerDesc =>
      _t('For Agniveer Personnel', 'अग्निवीर कर्मी के लिए');
  String get jco => 'JCO';
  String get jcoDesc =>
      _t('For Junior Commissioned Officers', 'जूनियर कमीशंड ऑफिसरों के लिए');
  String get officers => _t('Officers', 'अधिकारी');
  String get officersDesc =>
      _t('For Commissioned Officers', 'कमीशंड ऑफिसरों के लिए');
  String get enterArmyNumberHint =>
      _t('Enter your Army Number', 'अपना आर्मी नंबर दर्ज करें');
  String get armyNumberHintNote => _t(
        'Enter your valid Army Number as per your category.',
        'अपनी श्रेणी के अनुसार वैध आर्मी नंबर दर्ज करें।',
      );
  String get fullName => _t('Full Name', 'पूरा नाम');
  String get enterFullName => _t('Enter your full name', 'अपना पूरा नाम दर्ज करें');
  String get dateOfBirth => _t('Date of Birth', 'जन्म तिथि');
  String get dobHint => 'DD/MM/YYYY';
  String get mobileNumber => _t('Mobile Number', 'मोबाइल नंबर');
  String get enterMobile =>
      _t('Enter your mobile number', 'अपना मोबाइल नंबर दर्ज करें');
  String get emailId => _t('Email ID', 'ईमेल आईडी');
  String get enterEmailId => _t('Enter your email ID', 'अपनी ईमेल आईडी दर्ज करें');
  String get createStrongPassword =>
      _t('Create a strong password', 'एक मजबूत पासवर्ड बनाएँ');
  String get iAgreeTo => _t('I agree to the ', 'मैं सहमत हूँ ');
  String get termsConditions => _t('Terms & Conditions', 'नियम और शर्तें');
  String get and => _t(' and ', ' और ');
  String get privacyPolicy => _t('Privacy Policy', 'गोपनीयता नीति');
  String get signUp => _t('SIGN UP', 'साइन अप');
  String get accountCreated =>
      _t('Account created — please login', 'खाता बन गया — कृपया लॉगिन करें');
  String get alreadyHaveAccount =>
      _t('Already have an account? ', 'पहले से खाता है? ');
  String get loginLink => _t('Login', 'लॉगिन');
  String get armyNumberFormat => _t('Army Number Format', 'आर्मी नंबर प्रारूप');
  String get pleaseEnterArmyNumberSignup =>
      _t('Please enter your Army Number', 'कृपया अपना आर्मी नंबर दर्ज करें');
  String get pleaseEnterFullName =>
      _t('Please enter your full name', 'कृपया अपना पूरा नाम दर्ज करें');
  String get pleaseSelectDob =>
      _t('Please select your date of birth', 'कृपया अपनी जन्म तिथि चुनें');
  String get pleaseEnterValidMobile =>
      _t('Please enter a valid mobile number', 'कृपया वैध मोबाइल नंबर दर्ज करें');
  String get pleaseEnterValidEmail =>
      _t('Please enter a valid email ID', 'कृपया वैध ईमेल आईडी दर्ज करें');
  String get passwordMin8Long => _t(
        'Password must be at least 8 characters long',
        'पासवर्ड कम से कम 8 अक्षर लंबा होना चाहिए',
      );
  String get pleaseAgreeTerms =>
      _t('Please agree to Terms & Conditions', 'कृपया नियम और शर्तों से सहमत हों');

  // Dashboard
  String get goodMorning => _t('Good Morning,', 'सुप्रभात,');
  String get goodAfternoon => _t('Good Afternoon,', 'नमस्कार,');
  String get goodEvening => _t('Good Evening,', 'शुभ संध्या,');
  String get searchHint =>
      _t('Search manuals, systems, faults, parts...', 'मैनुअल, सिस्टम, फॉल्ट, पार्ट खोजें...');
  String get technicalSections => _t('Technical Sections', 'तकनीकी अनुभाग');
  String get viewAll => _t('View All', 'सभी देखें');
  String get recentActivities => _t('Recent Activities', 'हाल की गतिविधियाँ');
  String get storageUsage => _t('Storage Usage', 'स्टोरेज उपयोग');
  String get percentUsed => _t('% Used', '% उपयोग');
  String get manageStorage => _t('Manage Storage', 'स्टोरेज प्रबंधित करें');
  String get used => _t('Used', 'उपयोग');
  String get available => _t('Available', 'उपलब्ध');
  String get totalStorage => _t('Total Storage', 'कुल स्टोरेज');
  String comingSoon(String label) =>
      _t('$label — coming soon', '$label — जल्द आ रहा है');

  // Common crumbs / labels
  String get section => _t('Section', 'अनुभाग');
  String get bVeh => 'B Veh';
  String get heavyVehicle => _t('Heavy Vehicle', 'भारी वाहन');
  String get als => 'ALS';
  String get advancedLightSupport =>
      _t('Advanced Light Support', 'एडवांस्ड लाइट सपोर्ट');
  String get engineSystem => _t('Engine System', 'इंजन सिस्टम');
  String get parts => _t('Parts', 'पार्ट्स');
  String get faults => _t('Faults', 'फॉल्ट्स');
  String get workingPrinciple => _t('Working Principle', 'कार्य सिद्धांत');
  String get trainingCenter => _t('Training Center', 'प्रशिक्षण केंद्र');
  String get technicalManuals => _t('Technical Manuals', 'तकनीकी मैनुअल');
  String get filter => _t('Filter', 'फ़िल्टर');
  String get overview => _t('Overview', 'अवलोकन');
  String get keyFunctions => _t('Key Functions', 'मुख्य कार्य');
  String get technicalSpecification =>
      _t('Technical Specification', 'तकनीकी विनिर्देश');
  String get viewIn3d => _t('View in 3D', '3D में देखें');
  String get explodedView => _t('Exploded View', 'विस्फोटित दृश्य');
  String get learningResources => _t('Learning Resources', 'शिक्षण संसाधन');
  String get description => _t('Description', 'विवरण');
  String get possibleCauses => _t('Possible Causes', 'संभावित कारण');
  String get recommendedRemedies =>
      _t('Recommended Remedies', 'अनुशंसित उपाय');
  String get resources => _t('Resources', 'संसाधन');
  String get wasThisHelpful => _t('Was this helpful?', 'क्या यह सहायक रहा?');
  String get yes => _t('Yes', 'हाँ');
  String get no => _t('No', 'नहीं');
  String get reportIssue => _t('Report an Issue', 'समस्या रिपोर्ट करें');
  String get topics => _t('Topics', 'विषय');
  String get fourStrokeCycle => _t('Four-Stroke Cycle', 'चार-स्ट्रोक चक्र');
  String get keyPoints => _t('Key Points', 'मुख्य बिंदु');
  String get engineParts => _t('ENGINE PARTS', 'इंजन पार्ट्स');
  String get engineFaults => _t('ENGINE FAULTS', 'इंजन फॉल्ट्स');
  String get noPartsFound => _t('No parts found', 'कोई पार्ट नहीं मिला');
  String get noFaultsFound => _t('No faults found', 'कोई फॉल्ट नहीं मिला');
  String get searchEngineParts =>
      _t('Search engine parts...', 'इंजन पार्ट्स खोजें...');
  String get searchFaults => _t('Search faults...', 'फॉल्ट्स खोजें...');
  String get engineSystemAls =>
      _t('Engine System – ALS', 'इंजन सिस्टम – ALS');
  String resourcesCount(int n) =>
      _t('$n Resources', '$n संसाधन');

  // ALS / Engine
  String get alsSystems => _t('ALS - Systems', 'ALS - सिस्टम');
  String get selectSystem =>
      _t('Select a system to learn, explore and master', 'सीखने के लिए सिस्टम चुनें');
  String get exploreEngine =>
      _t('Explore all topics related to Engine System.', 'इंजन सिस्टम से जुड़े सभी विषय देखें।');
  String get quickResources => _t('Quick Resources', 'त्वरित संसाधन');

  // Training
  String get exploreLearning =>
      _t('Explore Learning Resources', 'शिक्षण संसाधन देखें');
  String get chooseCategory => _t(
        'Choose a category to continue your learning.',
        'सीखना जारी रखने के लिए श्रेणी चुनें।',
      );
  String get quickAccess => _t('Quick Access', 'त्वरित पहुँच');
  String get learnPracticeMaster =>
      _t('Learn, Practice & Master', 'सीखें, अभ्यास करें और निपुण बनें');
  String get welcomeTraining =>
      _t('Welcome to Training Center', 'प्रशिक्षण केंद्र में आपका स्वागत है');
  String get welcomeTrainingBody => _t(
        'Access technical manuals, SOPs, training videos and policies to strengthen your knowledge and field readiness.',
        'अपने ज्ञान और फील्ड रेडीनेस को मजबूत करने के लिए तकनीकी मैनुअल, SOP, प्रशिक्षण वीडियो और नीतियाँ देखें।',
      );

  // Manuals
  String get manualsList => _t('Manuals List', 'मैनुअल सूची');
  String manualsCount(int count) =>
      _t('$count Manuals', '$count मैनुअल');
  String get noManualsFound => _t('No manuals found', 'कोई मैनुअल नहीं मिला');
  String openingManual(String title) =>
      _t('Opening $title', '$title खोल रहे हैं');
  String get searchManuals => _t('Search manuals...', 'मैनुअल खोजें...');
  String get pdf => 'PDF';
  String pdfMeta(String size, int pages) =>
      _t('PDF  •  $size  •  $pages Pages', 'PDF  •  $size  •  $pages पृष्ठ');
  String get needHelpManual => _t(
        "Need Help? Can't find the manual you're looking for? Let us know.",
        'मदद चाहिए? जिस मैनुअल की तलाश है वह नहीं मिला? हमें बताएँ।',
      );
  String get requestManual => _t('Request Manual >', 'मैनुअल अनुरोध >');
  String get selectManual =>
      _t('Select a manual to view details', 'विवरण देखने के लिए मैनुअल चुनें');
  String get manualsHero => _t(
        'Access detailed technical manuals for all systems and components. Learn, understand and maintain with official documentation.',
        'सभी सिस्टम और घटकों के विस्तृत तकनीकी मैनुअल देखें। आधिकारिक दस्तावेज़ों से सीखें और रखरखाव करें।',
      );

  // Downloads
  String get downloadsSubtitle =>
      _t('Access your downloaded resources offline', 'डाउनलोड संसाधन ऑफ़लाइन देखें');
  String get allDownloads => _t('All Downloads', 'सभी डाउनलोड');
  String get manuals => _t('Manuals', 'मैनुअल');
  String get videos => _t('Videos', 'वीडियो');
  String get sops => 'SOPs';
  String get documents => _t('Documents', 'दस्तावेज़');
  String get policies => _t('Policies', 'नीतियाँ');
  String get saved => _t('Saved', 'सहेजे');
  String get gbOf => _t('GB of', 'GB में से');
  String get gbUsed => _t('GB Used', 'GB उपयोग');
  String moreItems(int n, String category) =>
      _t('+ $n more $category', '+ $n और $category');

  // Drone
  String get droneSubtitle =>
      _t('UAV training, systems & operations', 'UAV प्रशिक्षण, सिस्टम और संचालन');
  String get droneSystems => _t('Drone Systems', 'ड्रोन सिस्टम');
  String get droneSystemsDesc => _t(
        'Explore UAV platforms, flight controls, payloads and maintenance modules.',
        'UAV प्लेटफ़ॉर्म, फ्लाइट कंट्रोल, पेलोड और मेंटेनेंस मॉड्यूल देखें।',
      );
  String get quickModules => _t('Quick Modules', 'त्वरित मॉड्यूल');
  String get flightOps => _t('Flight Operations', 'उड़ान संचालन');
  String get flightOpsDesc => _t(
        'Take-off, navigation & recovery procedures',
        'टेक-ऑफ़, नेविगेशन और रिकवरी प्रक्रियाएँ',
      );
  String get groundControl => _t('Ground Control', 'ग्राउंड कंट्रोल');
  String get groundControlDesc => _t(
        'GCS setup, links and mission planning',
        'GCS सेटअप, लिंक और मिशन प्लानिंग',
      );
  String get payloadSensors => _t('Payload & Sensors', 'पेलोड और सेंसर');
  String get payloadSensorsDesc => _t(
        'EO/IR, mapping and surveillance payloads',
        'EO/IR, मैपिंग और निगरानी पेलोड',
      );
  String get maintenance => _t('Maintenance', 'रखरखाव');
  String get maintenanceDesc => _t(
        'Airframe, battery and propeller servicing',
        'एयरफ्रेम, बैटरी और प्रोपेलर सर्विसिंग',
      );

  // Profile
  String get notifications => _t('Notifications', 'सूचनाएँ');
  String get notificationsSubtitle =>
      _t('Alerts for manuals & updates', 'मैनुअल और अपडेट के अलर्ट');
  String get logout => _t('Logout', 'लॉग आउट');
  String get email => _t('Email', 'ईमेल');
  String get station => _t('Station', 'स्टेशन');
  String get rank => _t('Rank', 'रैंक');
  String get editProfile => _t('Edit Profile', 'प्रोफ़ाइल संपादित करें');
  String get editProfileSub =>
      _t('Update personal details', 'व्यक्तिगत विवरण अपडेट करें');
  String get myBookmarks => _t('My Bookmarks', 'मेरे बुकमार्क');
  String get myBookmarksSub =>
      _t('Saved parts, manuals & faults', 'सहेजे पार्ट्स, मैनुअल और फॉल्ट्स');
  String get trainingProgress => _t('Training Progress', 'प्रशिक्षण प्रगति');
  String get trainingProgressSub =>
      _t('Modules completed & scores', 'पूर्ण मॉड्यूल और स्कोर');
  String get securityPrivacy => _t('Security & Privacy', 'सुरक्षा और गोपनीयता');
  String get securityPrivacySub =>
      _t('Password and access controls', 'पासवर्ड और पहुँच नियंत्रण');
  String get helpSupport => _t('Help & Support', 'सहायता और समर्थन');
  String get helpSupportSub =>
      _t('FAQs and contact support', 'अक्सर पूछे जाने वाले प्रश्न और संपर्क');
  String get aboutTechYodha => _t('About Tech Yodha', 'टेक योद्धा के बारे में');
}
