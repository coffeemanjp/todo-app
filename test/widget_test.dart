import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';

void main() {
  testWidgets('TodoListPage smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // アプリが正しく起動することを確認
    expect(find.text('ToDoリスト'), findsOneWidget);
    expect(find.text('タイトル'), findsOneWidget);
    expect(find.text('説明'), findsOneWidget);
    expect(find.text('追加'), findsOneWidget);
    expect(find.text('ToDoがありません'), findsOneWidget);

    // 新しいToDoを追加
    await tester.enterText(find.byType(TextField).first, 'テストToDo');
    await tester.enterText(find.byType(TextField).last, 'テスト説明');
    await tester.tap(find.text('追加'));
    await tester.pump();

    // ToDoが追加されたことを確認
    expect(find.text('テストToDo'), findsOneWidget);
    expect(find.text('テスト説明'), findsOneWidget);
  });
} 