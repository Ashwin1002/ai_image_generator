import 'package:ai_image_generator/constant/colors.dart';
import 'package:ai_image_generator/services/openai_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> sizes = ["Small", "Medium", "Large"];

  late List<String> values = ["256x256", "512x512", "1024x1024"];

  String? dropdownValue;

  late TextEditingController textController = TextEditingController();

  late String image = "";

  late bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'AI Image Generator',
          style: TextStyle(
              fontFamily: 'WorkSans-Bold', color: ConstantColor.whiteColors),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  backgroundColor: ConstantColor.btnColor),
              onPressed: () {},
              child: const Text("My Arts"),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: ConstantColor.whiteColors,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: textController,
                            decoration: const InputDecoration(
                              hintText: "eg. 'Rapper Monkey Dissing Tiger' ",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: ConstantColor.whiteColors,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isDense: true,
                            icon: Icon(Icons.expand_more,
                                color: ConstantColor.btnColor),
                            value: dropdownValue,
                            hint: const Text(
                              "Select Size",
                            ),
                            items: List.generate(
                              sizes.length,
                              (index) => DropdownMenuItem(
                                value: values[index],
                                child: Text(
                                  sizes[index],
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              dropdownValue = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 44,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColor.btnColor,
                          shape: const StadiumBorder()),
                      onPressed: () async {
                        if (textController.text.isNotEmpty &&
                            dropdownValue!.isNotEmpty) {
                          setState(() {
                            isLoaded = false;
                          });
                          image = await OpenAIAPI.generateImage(
                            text: textController.text.trim(),
                            size: dropdownValue!,
                          );
                          setState(() {
                            isLoaded = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "TextField and Dropdown cannot be empty"),
                            ),
                          );
                        }
                      },
                      child: const Text("Generate"),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: isLoaded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Image.network(
                            image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                    Icons.download_for_offline_outlined),
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(8.0),
                                    backgroundColor: ConstantColor.btnColor),
                                onPressed: () {},
                                label: const Text("Download"),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.share_outlined),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  backgroundColor: ConstantColor.btnColor),
                              onPressed: () {},
                              label: const Text("Share"),
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: ConstantColor.whiteColors),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/images/loading.gif",
                              fit: BoxFit.contain),
                          const Padding(
                            padding: EdgeInsets.only(top: 110.0),
                            child: Text(
                              "Please fill above fields to generate image",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Created by Ashwin Shrestha",
                style:
                    TextStyle(fontSize: 14.0, color: ConstantColor.whiteColors),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
