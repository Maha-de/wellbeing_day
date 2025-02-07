import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FqaTab extends StatelessWidget {
  const FqaTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SelectableText.rich(
            TextSpan(
              style: TextStyle(fontSize: 18.sp, color: Colors.black, height: 1.5.h),
              children: [
                TextSpan(
                  text: 'ماهي طريقة حجز جلسة ؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text:
                      '• تحميل تطبيق Wellbeing Day, وإنشاء حساب خاص بك ثم الدخول علي صفحه الصحه وأختيار الاضطراب ثم الانتقال إلي صفحه انواع الإضرابات ثم إلي صفحه الاخصائيين ليتم أختيار الأخصائي المناسب ومن ثم حجز جلسه بعد ذلك تواصل بكل خصوصيه مع المختص في صفحه المواعيدعبرالشات أو الإتصال الصوتي أو الفيديو\n\n',
                ),
                TextSpan(
                  text:
                      'لماذا تحتاج إلى التحدث مع أخصائي عبر الإنترنت (أونلاين) ؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text:
                      '• واحد من كل 8 أشخاص في العالم يعاني من أحد الأضطرابات النفسيه او السلوكيه ,إلا أن النسبه ضئيله منهم تسعي للحصول علي المساعده او العلاج توفر لك الاستشاره عن بعد إمكانيه تنسيق مواعيدك مع الاخصائي بما يناسب مع جدولك اليومي ,سهوله التواصل مع الاخصائي من راحه منزلك ,خصوصيه تامه\n\n',
                ),
                TextSpan(
                  text: 'كم جلسه ستحتاج للعلاج؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text:
                      '• يختلف عدد جلسات العلاج باختلاف الحاله والتشخيص لكن بشكل عام يحتاج المريض بمعدل 5-10 جلسات, كما إن هناك عده عوامل تساهم في التحسين بشكل أسرع مثل رغبه العميل وإرادته للتحسن والإلتزام بتوجيهات المعالج وأداء التمارين المطلوبه والإلتزام في الجلسات وتسلسل العلاج\n\n',
                ),
                TextSpan(
                  text: ' كيف يتم التعامل معلوماتك؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text:
                      ''' • يتم التعامل مع كافه معلوماتك بسريه وبخصوصيه عاليه ,سواء كانت المعلومات المرسله علي وسائل التواصل الإجتماعي ,او معلومات التسجيل ,أو المعلومات التي تشاركها مع الأخصائي أثناء وقبل وبعد الجلسات                     ''',
                ),
                TextSpan(
                  text:
                      '\n • هناك 3 حالات يتم كسر السريه فيها وتبليغ السلطات المختصه وهي كاللأتي :في حال وجود نيه حقيقيه في تنفيذ الانتحار.في حال وجود تهديد حقيقي علي حياه شخص اّخر خصوصا الأطفال وكبار السن المعتدين عليه . \n',
                ),
                TextSpan(
                  text: '\nما الذي يمكن ان اتوقعه من الاستشارة؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                    text:
                        ' •  علاقة مهنية و فعالة بين الأخصائي النفسي و بينك. قد نجد صعوبة في النظر خارج نطاق أنفسنا و حدودنا الخاصة في الحياة إلا أن الاستشارة توفر لنا سبلا لتحسين حياتنا اليومية من وجهة نظر غير متحيزة و مهنية و من غير اطلاق أي أحكام علينا أثناء ذلك.\n'),
                TextSpan(
                  text: '\nما العمل اذا تأخر احد الطرفين عن موعد الجلسة؟\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                    text:
                        ' • يتم انهاء الجلسات بعد 15 دقيقة من عدم تواجد أحد الأطراف. إذا كان التأخير من طرف العميل.\nبإمكانكم التواصل مع الأخصائي. إذا كان التأخير من طرف الأخصائي خلال المهلة الزمنية ، سيتمكن أيضًا من الاتصال بكم حال تواجده، او يمكنك الغاء الجلسة واستعادة المال')
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
