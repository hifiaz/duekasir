import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:due_kasir/controller/request_controller.dart';
import 'package:due_kasir/model/request_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class RequestForm extends StatefulWidget {
  final RequestModel? request;
  const RequestForm({super.key, this.request});

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final status = ['Draf', 'Hold', 'Process', 'Finish'];
  late final EditorScrollController editorScrollController;
  EditorState? editorState;
  late Future<String> _jsonString;
  String? selectedStatus = 'Draf';

  @override
  void initState() {
    editor();
    super.initState();
  }

  void editor() async {
    if (widget.request != null) {
      final json = jsonDecode(widget.request!.note!);
      selectedStatus = widget.request?.status;
      editorState = EditorState(document: Document.fromJson(json));
    } else {
      _jsonString = rootBundle.loadString('assets/example.json');
      final json = jsonDecode(await _jsonString);
      editorState = EditorState(document: Document.fromJson(json));
    }
    editorScrollController = EditorScrollController(
      editorState: editorState!,
      shrinkWrap: false,
    );

    setState(() {});
  }

  @override
  void dispose() {
    editorScrollController.dispose();
    editorState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ShadSelectFormField<String>(
            id: 'status',
            initialValue: selectedStatus,
            onChanged: (v) {
              setState(() {
                selectedStatus = v;
              });
            },
            options: status
                .map((u) => ShadOption(value: u, child: Text(u)))
                .toList(),
            selectedOptionBuilder: (context, value) => Text(value),
            placeholder: const Text('Status'),
            validator: (v) {
              if (v == null) {
                return 'Please select an status to display';
              }
              return null;
            },
          ),
          ShadButton(
            onPressed: editorState == null
                ? null
                : () async {
                    if (widget.request != null) {
                      RequestModel request = RequestModel(
                          id: widget.request!.id,
                          title: widget.request?.title,
                          note: jsonEncode(editorState?.document.toJson()),
                          status: selectedStatus,
                          createdAt: widget.request?.createdAt);
                      await SupabaseHelper().updateRequest(request);
                    } else {
                      RequestModel request = RequestModel(
                          id: DateTime.now().millisecondsSinceEpoch,
                          note: jsonEncode(editorState?.document.toJson()),
                          status: selectedStatus,
                          createdAt: DateTime.now());
                      await SupabaseHelper().addRequest(request.toJson());
                    }
                    requestController.requests.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
            text: const Text('Simpan'),
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.save,
                size: 16,
              ),
            ),
          ),
          if (widget.request != null)
            ShadButton.destructive(
              onPressed: editorState == null
                  ? null
                  : () async {
                      await SupabaseHelper().removeRequest(widget.request!.id!);
                      requestController.requests.refresh();
                      if (context.mounted) Navigator.pop(context);
                    },
              icon: const Icon(
                Icons.delete,
                size: 16,
              ),
            ),
        ],
      ),
      body: editorState == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PlatformExtension.isDesktopOrWeb
              ? FloatingToolbar(
                  items: [
                    paragraphItem,
                    ...headingItems,
                    ...markdownFormatItems,
                    quoteItem,
                    bulletedListItem,
                    numberedListItem,
                    linkItem,
                    buildTextColorItem(),
                    buildHighlightColorItem(),
                    ...textDirectionItems,
                    ...alignmentItems,
                  ],
                  editorScrollController: editorScrollController,
                  editorState: editorState!,
                  textDirection: TextDirection.ltr,
                  child: AppFlowyEditor(
                    editorStyle: EditorStyle.desktop(
                      cursorWidth: 2.0,
                      cursorColor: Colors.blue,
                      selectionColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    ),
                    editorScrollController: editorScrollController,
                    editorState: editorState!,
                  ),
                )
              : MobileToolbarV2(
                  toolbarHeight: 48.0,
                  toolbarItems: [
                    textDecorationMobileToolbarItemV2,
                    buildTextAndBackgroundColorMobileToolbarItem(),
                    blocksMobileToolbarItem,
                    linkMobileToolbarItem,
                    dividerMobileToolbarItem,
                  ],
                  editorState: editorState!,
                  child: Column(
                    children: [
                      // build appflowy editor
                      Expanded(
                        child: MobileFloatingToolbar(
                          editorState: editorState!,
                          editorScrollController: editorScrollController,
                          toolbarBuilder: (context, anchor, closeToolbar) {
                            return AdaptiveTextSelectionToolbar.editable(
                              clipboardStatus: ClipboardStatus.pasteable,
                              onCopy: () {
                                copyCommand.execute(editorState!);
                                closeToolbar();
                              },
                              onCut: () => cutCommand.execute(editorState!),
                              onPaste: () => pasteCommand.execute(editorState!),
                              onSelectAll: () =>
                                  selectAllCommand.execute(editorState!),
                              onLiveTextInput: null,
                              onLookUp: null,
                              onSearchWeb: null,
                              onShare: null,
                              anchors: TextSelectionToolbarAnchors(
                                primaryAnchor: anchor,
                              ),
                            );
                          },
                          child: AppFlowyEditor(
                            editorStyle: const EditorStyle.mobile(
                              textScaleFactor: 1.0,
                              cursorColor: Color.fromARGB(255, 134, 46, 247),
                              dragHandleColor:
                                  Color.fromARGB(255, 134, 46, 247),
                              selectionColor: Color.fromARGB(50, 134, 46, 247),
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              magnifierSize: Size(144, 96),
                              mobileDragHandleBallSize: Size(12, 12),
                            ),
                            editorState: editorState!,
                            editorScrollController: editorScrollController,
                            showMagnifier: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
