class AppStrings {
  AppStrings._();

  // ===== Common (Global)
  static const String appName = 'Taskora';

  static const String next = 'التالي';
  static const String skip = 'تخطي';
  static const String back = 'رجوع';
  static const String continueText = 'متابعة';
  static const String confirm = 'تأكيد';
  static const String save = 'حفظ';
  static const String cancel = 'إلغاء';
  static const String yes = 'نعم';
  static const String no = 'لا';
  static const String ok = 'حسناً';
  static const String done = 'تم';
  static const String add = 'إضافة';
  static const String delete = 'حذف';
  static const String edit = 'تعديل';
  static const String search = 'بحث';
  static const String agree = 'موافق';

  // ===== Onboarding / Welcome
  static const String firstStepIsEasy = 'لا تقلق... أول خطوة دايماً الأسهل!';
  static const String needDailyPlanQuestion =
      'هل تحتاج إلى خطة يومية لتنظيم مهامك وتحقيق أهدافك بكل سهولة؟';
  static const String prioritizeTasksHelp =
      'نساعدك على ترتيب مهامك حسب الأولوية!';
  static const String priorityGuide = 'دليل الأولويات';
  static const String journeyStartsNow =
      'يسعدني رؤيتك معنا, رحلتك لاهدافك تبدأ الان.';
  static const String joinAndStartNow =
      'انضم إلينا الآن وابدأ رحلتك نحو النجاح!';

  // ===== Authentication (Sign In / Sign Up / Reset)
  static const String welcomeBackTitle = 'مرحباً بعودتك!';
  static const String welcomeBackSubtitle =
      'مرحباً! لنقم بتسجيل دخولك إلى حسابك.';
  static const String signIn = 'تسجيل الدخول';
  static const String signUp = 'إنشاء حساب';
  static const String createNewAccount = 'إنشاء حساب جديد';

  static const String orSignInWith = 'تسجيل دخول عبر';
  static const String forgotPassword = 'هل نسيت كلمة المرور؟';
  static const String dontHaveAccount = 'ليس لديك حساب؟';
  static const String createAccountNow = 'انشئ حسابك الان';
  static const String alreadyHaveAccount = 'لديك حساب؟';
  static const String signInNow = 'قم بتسجيل الدخول';

  static const String changePassword = 'تغيير كلمة المرور';
  static const String resetPassword = 'إعادة تعيين كلمة المرور';
  static const String saveNewPassword = 'حفظ كلمة المرور الجديدة';

  static const String termsAndPrivacyAgreement =
      '*بالاستمرار فإنك توافق على الشروط وسياسة الخصوصية.';

  // Form labels / hints
  static const String fullNameLabel = 'الاسم الأول والأخير';
  static const String fullNameHint = 'أدخل اسمك هنا...';
  static const String phoneNumberLabel = 'رقم الجوال';
  static const String phoneNumberHint = 'أدخل رقم الجوال هنا...';
  static const String emailLabel = 'البريد الإلكتروني';
  static const String emailHint = 'أدخل بريدك الإلكتروني هنا...';
  static const String passwordLabel = 'كلمة المرور';
  static const String passwordHint = 'أدخل كلمة المرور هنا...';
  static const String newPasswordHint = 'أدخل كلمة المرور الجديدة هنا...';
  static const String confirmPasswordLabel = 'تأكيد كلمة المرور';

  // ===== OTP Verification
  static const String otpTitle = 'رمز التحقق (OTP)';
  static const String otpSentToEmail = 'تم إرسال رمز تفعيل الحساب على الإيميل';
  static const String checkEmailBelow = 'تحقق من البريد المرفق أدناه';
  static const String enterLinkedPhoneNumber =
      'قم بإدخال رقم الجوال المرتبط بالحساب!';
  static const String otpCodeHint = 'أدخل رمز التحقق هنا...';
  static const String verifyNow = 'تحقق الآن';
  static const String resendCode = 'أعد إرسال الرمز';
  static const String waiting = 'انتظار';
  static const String invalidCode = 'الرمز غير صحيح';
  static const String verificationSuccess = 'تم التحقق بنجاح!';

  // ===== Dashboard / Home
  static const String dashboardTitle = 'لوحة التحكم';
  static const String welcomeSummary = 'مرحباً {name}، إليك ملخص أعمالك اليوم';
  static const String welcomeCompany =
      'مرحباً بك في مجموعة شركات {companyName}';
  static const String lastSixMonths = 'آخر 6 أشهر';

  static const String achievementPercent = '{percent}%\\nالإنجاز';
  static const String hoursSummary = 'الساعات\\n{done}/{total}';
  static const String hourlyRate = 'السعر بالساعة';
  static const String projectPrice = 'سعر المشروع\\n{amount}';
  static const String hoursCount = '{done}/{total} ساعة';
  static const String tasksCount = '{done}/{total} مهمة';
  static const String hoursShort = '{hours} س';
  static const String projectLabel = 'المشروع: {projectName}';
  static const String sinceDateLabel = 'منذ {dateText}';

  // ===== Projects
  static const String projectsTitle = 'المشاريع';
  static const String createProject = 'إنشاء مشروع';
  static const String projectDetails = 'تفاصيل المشروع';
  static const String projectNameLabel = 'اسم المشروع';
  static const String projectDescriptionLabel = 'وصف المشروع';
  static const String projectPriceLabel = 'سعر المشروع';
  static const String editProject = 'تعديل مشروع';
  static const String deleteProject = 'حذف مشروع';

  static const String deleteProjectConfirmTitle =
      'هل أنت متأكد من حذف المشروع؟';
  static const String deleteProjectConfirmMessage =
      'بحذفك للمشروع، سيتم حذف المشروع من صفحة المشاريع وحذف مهامه.';
  static const String projectDeletedSuccess = 'تم حذف المشروع بنجاح!';
  static const String projectUpdatedSuccess = 'تم تعديل المشروع بنجاح!';

  // ===== Tasks
  static const String tasksTitle = 'المهام';
  static const String addTask = 'إضافة مهمة';
  static const String taskDetails = 'تفاصيل المهمة';
  static const String taskNameLabel = 'اسم المهمة';
  static const String taskDescriptionLabel = 'وصف المهمة';
  static const String taskPriorityLabel = 'أولوية المهمة';
  static const String taskStatusLabel = 'حالة المهمة';
  static const String newTasksDefaultStatusNote =
      'المهام الجديدة يتم ضبطها تلقائياً إلى: قيد التنفيذ';

  static const String inProgress = 'قيد التنفيذ';
  static const String completed = 'مكتمل';
  static const String notCompleted = 'غير مكتمل';
  static const String isCompletedQuestion = 'مكتمل؟';
  static const String attachments = 'المرفقات';
  static const String taskAddedSuccess = 'تم إضافة المهمة بنجاح!';

  // ===== Settings / Profile
  static const String settingsTitle = 'الإعدادات';
  static const String memberSince = 'عضو منذ';
  static const String logout = 'تسجيل الخروج';
  static const String privacyPolicy = 'سياسة الخصوصية';
  static const String terms = 'الشروط';
  static const String support = 'الدعم';

  // ===== States / Empty / Errors
  static const String emptyStateTitle = 'ولا شي هون لسه!';
  static const String noData = 'لا يوجد بيانات';
  static const String noInternetConnection = 'لا يوجد اتصال بالإنترنت';
  static const String somethingWentWrong = 'حدث خطأ ما';
  static const String tryAgain = 'حاول مرة أخرى';

  // ===== Misc
  static const String today = 'اليوم';
  static const String tomorrow = 'غداً';
  static const String passwordSaved = 'تم إعادة تعيين حسابك بنجاح!';
  static const String accountCreatedSuccess = 'تم إنشاء حسابك بنجاح!';
}
