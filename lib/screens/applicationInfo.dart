import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:doctor/widgets/socialMediaButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationInfo extends StatefulWidget {
  const ApplicationInfo({super.key});

  @override
  State<ApplicationInfo> createState() => _ApplicationInfoState();
}

class _ApplicationInfoState extends State<ApplicationInfo> {
  @override
  Widget build(BuildContext context) {
    return const SocialMediaPage(); // No need for MaterialApp here
  }
}

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  int _selectedIndex = 3;
  final List<String> tabs = [
    "التعليمات",
    "تعريف التطبيق",
    "الأسئلة الشائعة",
    "الاتصال"
  ];
  late UserProfileCubit userProfileCubit;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
  }

  void openWhatsApp() async {
    String message =
        Uri.encodeComponent("هل تريد الدفع عن طريق أي وسائل أخرى؟");
    String whatsappUrl = "https://wa.me/?text=$message";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch WhatsApp";
    }
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";

    // Set the state once the user profile data is fetched
    userProfileCubit.getUserProfile(context, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 2,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 155,
                decoration: BoxDecoration(
                  color: const Color(0xff1B659F),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(45),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(tabs.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: _selectedIndex == index
                                ? Color(0xff69B7F3)
                                : Color(0xffA2A2A2),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppearedItemFromTabls(_selectedIndex)),
          ),
        ],
      ),
    );
  }

  Widget AppearedItemFromTabls(int index) {
    switch (index) {
      case 0:
        return instructionsTab();

      case 1:
        return Center(child: appDef());

      case 2:
        return faqTab();

      case 3:
        return contactTab();

      default:
        return contactTab();
    }
  }

  Widget contactTab() {
    return Column(
      children: [
        SocialMediaButton(
          label: "واتساب",
          icon: FontAwesomeIcons.whatsapp,
          color: Colors.green,
          onPressed: openWhatsApp,
        ),
        SocialMediaButton(
          label: "فيسبوك",
          icon: FontAwesomeIcons.facebook,
          color: Colors.blue,
          onPressed: openWhatsApp,
        ),
        SocialMediaButton(
          label: "إنستجرام",
          icon: FontAwesomeIcons.instagram,
          color: Colors.pink,
          onPressed: openWhatsApp,
        ),
        SocialMediaButton(
          label: "تويتر",
          icon: FontAwesomeIcons.twitter,
          color: Colors.lightBlue,
          onPressed: openWhatsApp,
        ),
        SocialMediaButton(
          label: "يوتيوب",
          icon: FontAwesomeIcons.youtube,
          color: Colors.red,
          onPressed: openWhatsApp,
        ),
      ],
    );
  }

  Widget instructionsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'تعليمات هامه',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 16, height: 2, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            ''' 'يسجل العميل (المستفيد) معلوماته الشخصية لانشاء حساب خاص قبل الاشتراك في اي استشارة فردية او جماعية او اي تدريب مهارات.
      يطلب منه اثناء العلاقة العلاجية المحافظة على احترام الاطار العلاجي الذي يفسرله لاحقا مثل دفع الاشتراكات بوقتها، حضوره قبل دقائق من بدء الجلسة اونلاين، عدم الطلب ان ينقل علاجه خارج التطبيق، وجوده في مكان خاص وحده بدون ضجيج ولا اتصالات، ان يعرف دوره ودور الاخصائي ونوع العلاج المستفيد منه وحدوده، ان يحافظ على الصراحة واحترام الوقت واصول التواصل
      ان يتم الدفع مسبقا اما بالتحويل لحساب الادمن عبر البنك او 
      WISH ,OMT, Westerunion ,others
      ان يرسل نسخة للوصل الى الادمن
      ان يتكفل بدفع كلفة التحويل اضافة لكلفة الجلسات بالدولار''',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(
            'توصيات للاخصائيين: يجب عليك كأخصائي قراءة هذه التوصيات جيدا',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 16, height: 2, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            ''' في انشاء الاخصائي لحسابه، تكون معلوماته الشخصية وملفاته المطلوبة متاحة فقط لللادمن، اما المعلومات الوظيفية والتخصص وغيرها تدرج في حسابه الذي سيظهر للعملاء.
      يطلب من الاخصائي للتأكد من تمتعه بالمواصفات المهنية ان يرسل ملفات معينة
      يطلب من الاخصائي ان يحترم مناقبية المهنة فلا ينقل الجلسات اونلاين خارج التطبيق او في عيادته
      عليه ان يحترم اصول المهنة من حيادية وعلمية احترام حقوق وخصوصيات العملاء
      وان يحافظ على اخلاقيات المهنة ، وعلى احترام القوانين العامة
      وان يحافظ على اطار صحيح للجلسات اونلاين
      يطلب من الاخصائي ان يحترم المواعيد ويكون حاضرا قبل بدء الجلسة''',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(
            'بعض الملاحظات',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 16, height: 2, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            ''' لا يجوز استخدام المنصة من قبل أي
       شخص يقل عمره عن 18 عامًا
        في الحالات الطارئة يجب على المستخدم التوجه فوراً إلى الطبيب النفسي الخاص في منطقته أو الاتصال بسيارة اسعاف للحصول على المساعدة.
        تُعفى الادارة على وجه التحديد من أي مسؤولية أو التزام قد ينشأ عن أي سوء فهم أو معلومات خاطئة او اي اضرار قد تنشأ عن الاتصالات بين الاخصائي وأي مستخدم
      يقتصر دور الشركة على توفير التقنيات التي تمكّن من تقديم خدمات الشركة إلى المستخدم من خلال الاخصائيين، ويتحمل الاخصائي المسؤولية الحصرية عن الخدمات المقدّمة''',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget appDef() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/appdef.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '''تعتبر هذه المنصة وهذا التطبيق انجاز  حقيقي حيث استفدنا باقصى. حد من التكنولوجيا لخدمة الانسان فنقلنا عمل العيادة كما هو الى التطبيق بمكوناته وشروطه. من الايجابيات التي يتميز بها التطبيق:
امكانية الحصول على الاستشارة بسرعة او البدء بالاعراض التي يعاني منها الفرد وصولا للاستشارة
او الدخول الى لائحة الاخصائيين لاختيار المناسب منهم''',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              ':الخدمات المميزة ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              'علاج فردي أو أسري\n علاج جماعي\nالاشتراك ببرامج علاجية\n-تدريب على الاسترخاء والمهارات',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget faqTab() {
    return SingleChildScrollView(
        child: Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SelectableText.rich(
            TextSpan(
              style: TextStyle(fontSize: 18, color: Colors.black, height: 1.5),
              children: [
                TextSpan(
                  text: 'ماهي طريقة حجز جلسة ؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'تحميل تطبيق Wellbeing Day, وإنشاء حساب خاص بك ثم الدخول علي صفحه الصحه وأختيار الاضطراب ثم الانتقال إلي صفحه انواع الإضرابات ثم إلي صفحه الاخصائيين ليتم أختيار الأخصائي المناسب ومن ثم حجز جلسه بعد ذلك تواصل بكل خصوصيه مع المختص في صفحه المواعيدعبرالشات أو الإتصال الصوتي أو الفيديو\n\n',
                ),
                TextSpan(
                  text:
                      'لماذا تحتاج إلى التحدث مع أخصائي عبر الإنترنت (أونلاين) ؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'واحد من كل 8 أشخاص في العالم يعاني من أحد الأضطرابات النفسيه او السلوكيه ,إلا أن النسبه ضئيله منهم تسعي للحصول علي المساعده او العلاج توفر لك الاستشاره عن بعد إمكانيه تنسيق مواعيدك مع الاخصائي بما يناسب مع جدولك اليومي ,سهوله التواصل مع الاخصائي من راحه منزلك ,خصوصيه تامه\n\n',
                ),
                TextSpan(
                  text: 'كم جلسه ستحتاج للعلاج؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'يختلف عدد جلسات العلاج باختلاف الحاله والتشخيص لكن بشكل عام يحتاج المريض بمعدل 5-10 جلسات, كما إن هناك عده عوامل تساهم في التحسين بشكل أسرع مثل رغبه العميل وإرادته للتحسن والإلتزام بتوجيهات المعالج وأداء التمارين المطلوبه والإلتزام في الجلسات وتسلسل العلاج\n\n',
                ),
                TextSpan(
                  text: ' كيف يتم التعامل معلوماتك؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '''
                      يتم التعامل مع كافه معلوماتك بسريه وبخصوصيه عاليه ,سواء كانت المعلومات المرسله علي وسائل التواصل الإجتماعي ,او معلومات التسجيل ,أو المعلومات التي تشاركها مع الأخصائي أثناء وقبل وبعد الجلسات
هناك 3 حالات يتم كسر السريه فيها وتبليغ السلطات المختصه وهي كاللأتي :في حال وجود نيه حقيقيه في تنفيذ الانتحار.في حال وجود تهديد حقيقي علي حياه شخص اّخر خصوصا الأطفال وكبار السن المعتدين عليه
                     ''',
                ),
                TextSpan(
                  text: '\nما الذي يمكن ان اتوقعه من الاستشارة؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        'علاقة مهنية و فعالة بين الأخصائي النفسي و بينك. قد نجد صعوبة في النظر خارج نطاق أنفسنا و حدودنا الخاصة في الحياة إلا أن الاستشارة توفر لنا سبلا لتحسين حياتنا اليومية من وجهة نظر غير متحيزة و مهنية و من غير اطلاق أي أحكام علينا أثناء ذلك.'),
                TextSpan(
                  text: '\nما العمل اذا تأخر احد الطرفين عن موعد الجلسة؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        'يتم انهاء الجلسات بعد 15 دقيقة من عدم تواجد أحد الأطراف. إذا كان التأخير من طرف العميل، بإمكانكم التواصل مع الأخصائي. إذا كان التأخير من طرف الأخصائي خلال المهلة الزمنية ، سيتمكن أيضًا من الاتصال بكم حال تواجده، او يمكنك الغاء الجلسة واستعادة المال')
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
