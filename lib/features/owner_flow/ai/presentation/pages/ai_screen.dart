// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rifq/features/owner_flow/ai/domain/entity/ai_message_entity.dart';
// import 'package:rifq/features/owner_flow/ai/presentation/cubit/ai_cubit.dart';
// import 'package:rifq/features/owner_flow/nav/presentation/cubit/nav_cubit.dart';

// class AiScreen extends StatelessWidget {
//   const AiScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = TextEditingController();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(CupertinoIcons.back, color: Colors.white),
//           onPressed: () {
//             // context.read<NavCubit>().clearAiActive();
//             Navigator.pop(context);
//           },
//         ),

//         title: const Text('AI Assistant'),
//         backgroundColor: const Color(0xFF2CC3B5),
//       ),

//       body: Column(
//         children: [
//           ///!-------- Messages --------
//           Expanded(
//             child: BlocBuilder<AiCubit, List<AiMessageEntity>>(
//               builder: (context, messages) {
//                 if (messages.isEmpty) {
//                   return const Center(
//                     child: Text('Ask me anything about your pet 🐾'),
//                   );
//                 }

//                 return ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final msg = messages[index];

//                     return Align(
//                       alignment: msg.isUser
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: msg.isUser
//                               ? const Color(0xFF2CC3B5)
//                               : Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (msg.imagePath != null)
//                               Padding(
//                                 padding: const EdgeInsets.only(bottom: 6),
//                                 child: Image.file(
//                                   File(msg.imagePath!),
//                                   height: 120,
//                                 ),
//                               ),
//                             Text(
//                               msg.text,
//                               style: TextStyle(
//                                 color: msg.isUser ? Colors.white : Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),

//           /// -------- Input --------
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: controller,
//                     decoration: const InputDecoration(
//                       hintText: 'Ask me anything...',
//                       filled: true,
//                       fillColor: Color(0xFFF4F4F4),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(30)),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 CircleAvatar(
//                   backgroundColor: const Color(0xFF2CC3B5),
//                   child: IconButton(
//                     icon: const Icon(Icons.send, color: Colors.white),
//                     onPressed: () {
//                       final text = controller.text.trim();
//                       if (text.isEmpty) return;

//                       context.read<AiCubit>().sendText(text);
//                       controller.clear();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/owner_flow/ai/domain/usecases/ai_message_usecase.dart';
import 'package:rifq/features/owner_flow/ai/presentation/bloc/ai_chat_bloc.dart';
import 'package:rifq/features/owner_flow/ai/presentation/widgets/chat_widget.dart';
class ChatScreen extends StatelessWidget {
  final AIConfigUsecase _useCase;
  const ChatScreen({super.key, required AIConfigUsecase useCase}): _useCase = useCase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AiChatBloc>(
      create: (context) => AiChatBloc(_useCase)..add(AIStarted()),
      child: Scaffold(
        appBar: AppBar(title: Text("AI Chatbot"),
        ),

        body: BlocBuilder<AiChatBloc, AiChatState>(
          builder: (context, state) {
          if(state is AILoading) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is AILoaded) {
            return ChatHeader(provider: state.provider, welcomeMessage: state.welcomeMessage,);
          }
          else if (state is AIError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        })
      ),
    );
  }
}