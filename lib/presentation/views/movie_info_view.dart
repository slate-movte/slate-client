import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/widgets/item_table.dart';

class MovieInfoView extends StatefulWidget {
  const MovieInfoView({super.key});

  @override
  State<MovieInfoView> createState() => _MovieInfoViewState();
}

class _MovieInfoViewState extends State<MovieInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('해운대'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorOf.point.light,
        child: const Icon(Icons.camera_alt_outlined),
        onPressed: () {},
      ),
      body: Center(
        child: ItemTable(
          header: ItemHeader(
            backgroundColor: ColorOf.white.light,
            forceElevated: true,
            height: 230.h + 56.6.h + 16.h,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                children: [
                  Placeholder(
                    child: SizedBox(
                      height: 230.h,
                      width: double.infinity,
                    ),
                  ),
                  const Center(
                    child: SizedBox(
                      width: 100,
                      height: 20,
                      child: Placeholder(),
                    ),
                  ),
                  Container(
                    height: 35.h,
                    padding: EdgeInsets.symmetric(horizontal: SizeOf.w_lg),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '2009.07.22 개봉',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          ' | ',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          '129분',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          sections: [
            ItemSection.onlyPost(
              builder: ItemSectionBuilder()
                ..posts = [
                  const ItemTablePost(
                    title: '감독',
                    content: 'ddd',
                  ),
                  const ItemTablePost(
                    title: '출연',
                    content:
                        '설경구(최만식), 하지원(강연희), 박중훈(김휘), 엄정화(이유진), 이민기, 강대규(방제연구원), 김원영(청원경찰1 ), 김유빈(진수), 신정원(미아보호소직원), 성유경(해변아이), 박재홍(청원경찰2), 황인준(해변아빠), 나승현(롯데자이언츠), 김인호(쓰나미남), 근휘(응급실인턴), 김재경(형식선배), 장원준(본인역), 임동우(분식점손님), 김정곤(사회자), 정종원(문화부장관), 이지애(손님딸 ), 이태영(헬기조종사2 ), 최재섭(동수), 장명갑(우성), 지대한(상렬), 천보근(승현), 박영수(호텔 수리공), 염동헌(파출소장 ), 주민하(모텔 여), 강예원(김희미), 손희순(지민 할머니), 변상윤(파라솔 남)',
                  ),
                  const ItemTablePost(
                    title: '시놉시스',
                    content:
                        '2004년 역사상 유례없는 최대의 사상자를 내며 전세계에 엄청난 충격을 안겨준 인도네시아 쓰나미. 당시 인도양에 원양어선을 타고 나갔던 해운대 토박이 만식은 예기치 못한 쓰나미에 휩쓸리게 되고, 단 한 순간의 실수로 그가 믿고 의지했던 연희 아버지를 잃고 만다. 이 사고 때문에 그는 연희를 좋아하면서도 자신의 마음을 숨길 수 밖에 없다. 그러던 어느 날, 만식은 오랫동안 가슴 속에 담아두었던 자신의 마음을 전하기로 결심하고 연희를 위해 멋진 프로포즈를 준비한다. 한편 국제해양연구소의 지질학자 김휘 박사는 대마도와 해운대를 둘러싼 동해의 상황이 5년전 발생했던 인도네시아 쓰나미와 흡사하다는 엄청난 사실을 발견하게 된다. 그는 대한민국도 쓰나미에 안전하지 않다고 수차례 강조하지만 그의 경고에도 불구하고 재난 방재청은 지질학적 통계적으로 쓰나미가 한반도를 덮칠 확률은 없다고 단언한다. 그 순간에도 바다의 상황은 시시각각 변해가고, 마침내 김휘 박사의 주장대로 일본 대마도가 내려 앉으면서 초대형 쓰나미가 생성된다. 한여름 더위를 식히고 있는 수백만의 휴가철 인파와 평화로운 일상을 보내고 있는 부산 시민들, 그리고 이제 막 서로의 마음을 확인한 만식과 연희를 향해 초대형 쓰나미가 시속 800km의 빠른 속도로 밀려오는데 가장 행복한 순간 닥쳐온 엄청난 시련, 남은 시간은 단 10분! 그들은 가장 소중한 것을 지켜내야만 한다!',
                  ),
                ],
            ),
            ItemSection(
              builder: ItemSectionBuilder()..image = const ItemTableGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
