import 'package:flutter/material.dart';

import '../../../logic/nav_bar.dart';
import '../../constant.dart';
import '../components/custom_text.dart';
import '../components/outline_button.dart';

class WallpaperSetPage extends StatefulWidget {
  const WallpaperSetPage({super.key});

  @override
  State<WallpaperSetPage> createState() => _WallpaperSetPageState();
}

class _WallpaperSetPageState extends State<WallpaperSetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.white,
      body: Column(
        children: [
          const SizedBox(height: 40),
          // < のアイコン表示
          Align(
            alignment: const Alignment(-0.9, 0),
            child: IconButton(
              iconSize: 22,
              icon: const ImageIcon(
                AssetImage('assets/icon/close_icon.png'),
                color: Constant.gray,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const NavBar())),
                );
              },
            ),
          ),

          const CustomText(text: '壁紙変更', fontSize: 22, Color: Constant.gray),
          const SizedBox(height: 20),

          Container(
            width: 380,
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Constant.gray, width: 2)),
            ),
          ),
          
          Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(),
                child: InkWell(
                  onTap: ()  {
                    // TODO: 壁紙変更処理
                  },
                  child: SizedBox(
                    height: 150,
                    width: 350,
                    child: Image.asset('assets/wallpaper/yellow/dots.png'),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: ()  {
                    // TODO: 壁紙変更処理
                  },
                  child: SizedBox(
                    height: 150,
                    width: 350,
                    child: Image.asset('assets/wallpaper/yellow/plaid.png'),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: ()  {
                    // TODO: 壁紙変更処理
                  },
                  child: SizedBox(
                    height: 150,
                    width: 350,
                    child: Image.asset('assets/wallpaper/yellow/stripe.png'),
                  ),
                ),
              ),
              
              const SizedBox(height: 20,),
              const OutlineButton(
                title: '保存',
                width: 170,
                height: 50,
                fontsize: 20,
                shape: 15,
                nextPage: NavBar(),
              ),
            ],
          ),
          
          
        ],
      ),
    );
  }
}