import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app_admin/core/theming/color_managers.dart';
import 'package:pizza_app_admin/feature/home_screen/blocs/bloc/get_pizza_bloc.dart';
import 'package:pizza_app_admin/feature/home_screen/ui/widgets/pizza_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // 🔥 طباعة البيانات من Firestore للتأكد من الاتصال
    FirebaseFirestore.instance.collection('pizzas').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        print("🔥 Pizza from Firestore: ${doc.data()}");
      }
    }).catchError((error) {
      print("❌ Error while fetching pizzas: $error");
    });

    // ✅ إرسال حدث لجلب البيانات عبر BLoC
    context.read<GetPizzaBloc>().add(GetPizzas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetPizzaBloc, GetPizzaState>(
        builder: (context, state) {
          if (state is GetPizzaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetPizzaSuccess) {
            if (state.pizzas.isEmpty) {
              return const Center(child: Text('لا توجد بيتزا حالياً'));
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                // تحديد عدد الأعمدة بناءً على عرض الشاشة
                int crossAxisCount;
                double childAspectRatio;

                if (constraints.maxWidth > 1200) {
                  // شاشات كبيرة جداً
                  crossAxisCount = 4;
                  childAspectRatio = 1.2;
                } else if (constraints.maxWidth > 800) {
                  // شاشات متوسطة
                  crossAxisCount = 3;
                  childAspectRatio = 1.3;
                } else if (constraints.maxWidth > 600) {
                  // شاشات صغيرة
                  crossAxisCount = 2;
                  childAspectRatio = 1.4;
                } else {
                  // شاشات صغيرة جداً (هواتف)
                  crossAxisCount = 1;
                  childAspectRatio = 1.5;
                }

                return Container(
                  color: ColorManagers.onErrorColor,
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.pizzas.length,
                    itemBuilder: (context, index) {
                      return PizzaCard(pizza: state.pizzas[index]);
                    },
                  ),
                );
              },
            );
          }

          if (state is GetPizzaError) {
            return Center(child: Text('خطأ: ${state.message}'));
          }

          return const Center(child: Text('جاري التحميل...'));
        },
      ),
    );
  }
}
