import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InstructionTab extends StatelessWidget {
  const InstructionTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8),
          SelectableText.rich(
            TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black, height: 2),
              children: [
                TextSpan(
                  text: "${"importantInstructions".tr()}\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                TextSpan(
                  text: "${"client_registration".tr()}\n",
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: "${"therapeutic_relationship".tr()}\n",
                ),
                TextSpan(
                  text: "${"payment_method".tr()}\n",
                ),
                TextSpan(
                  text: "${"send_receipt".tr()}\n",
                ),
                TextSpan(
                  text: "${"responsibility_for_payment".tr()}\n",
                ),
//                 TextSpan(text: '''
// •	يسجل العميل (المستفيد) معلوماته الشخصية لانشاء حساب خاص قبل الاشتراك في اي استشارة فردية او جماعية او اي تدريب مهارات.
// •	يطلب منه اثناء العلاقة العلاجية المحافظة على احترام الاطار العلاجي الذي يفسرله لاحقا مثل دفع الاشتراكات بوقتها، حضوره قبل دقائق من بدء الجلسة اونلاين، عدم الطلب ان ينقل علاجه خارج التطبيق، وجوده في مكان خاص وحده بدون ضجيج ولا اتصالات، ان يعرف دوره ودور الاخصائي ونوع العلاج المستفيد منه وحدوده، ان يحافظ على الصراحة واحترام الوقت واصول التواصل
// •	ان يتم الدفع مسبقا اما بالتحويل لحساب الادمن عبر البنك او WISH ,OMT, Westerunion ,others
// •	ان يرسل نسخة للوصل الى الادمن
// •	ان يتكفل بدفع كلفة التحويل اضافة لكلفة الجلسات بالدولار

// '''),
                TextSpan(
                  text: "recommendationsForSpecialists".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                TextSpan(
                  text: "recommendation".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextSpan(
                  text: "${"specialist_account_creation".tr()}\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextSpan(
                  text: "${"professional_requirements".tr()}\n",
                ),
                TextSpan(
                  text: "${"ethical_conduct".tr()}\n",
                ),
                TextSpan(
                  text: "${"professional_ethics".tr()}\n",
                ),
                TextSpan(
                  text: "${"respect_laws".tr()}\n",
                ),
                TextSpan(
                  text: "${"correct_framework".tr()}\n",
                ),
                TextSpan(
                  text: "${"punctuality".tr()}\n",
                ),
                TextSpan(
                  text: "${"some_notes".tr()}\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                TextSpan(
                  text: "${"platform_usage_restriction".tr()}\n",
                ),
                TextSpan(
                  text: "${"emergency_cases".tr()}\n",
                ),
                TextSpan(
                  text: "${"disclaimer".tr()}\n",
                ),
                TextSpan(
                  text: "${"company_responsibility".tr()}\n",
                ),
//                 TextSpan(
//                   text: '''

// •	في انشاء الاخصائي لحسابه، تكون معلوماته الشخصية وملفاته المطلوبة متاحة فقط للادمن، اما المعلومات الوظيفية والتخصص وغيرها تدرج في حسابه الذي سيظهر للعملاء.
// •	يطلب من الاخصائي للتأكد من تمتعه بالمواصفات المهنية ان يرسل ملفات معينة
// •	يطلب من الاخصائي ان يحترم مناقبية المهنة فلا ينقل الجلسات اونلاين خارج التطبيق او في عيادته
// •	عليه ان يحترم اصول المهنة من حيادية وعلمية احترام حقوق وخصوصيات العملاء
// •	وان يحافظ على اخلاقيات المهنة ، وعلى احترام القوانين العامة
// •	وان يحافظ على اطار صحيح للجلسات اونلاين
// •	يطلب من الاخصائي ان يحترم المواعيد ويكون حاضرا قبل بدء الجلسة
// ''',
//                 ),
//                 TextSpan(
//                   text: 'بعض الملاحظات\n',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
//                 ),
//                 TextSpan(
//                   text: '''
// •	 لا يجوز استخدام المنصة من قبل أي شخص يقل عمره عن 18 عامًا.
// •	في الحالات الطارئة يجب على المستخدم التوجه فوراً إلى الطبيب النفسي الخاص في منطقته أو الاتصال بسيارة اسعاف للحصول على المساعدة.
// •	تُعفى الادارة على وجه التحديد من أي مسؤولية أو التزام قد ينشأ عن أي سوء فهم أو معلومات خاطئة او اي اضرار قد تنشأ عن الاتصالات بين الاخصائي وأي مستخدم
// •	يقتصر دور الشركة على توفير التقنيات التي تمكّن من تقديم خدمات الشركة إلى المستخدم من خلال الاخصائيين، ويتحمل الاخصائي المسؤولية الحصرية عن الخدمات المقدّمة
// ''',
//                 ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
