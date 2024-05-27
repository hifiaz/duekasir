import 'package:due_kasir/controller/request_controller.dart';
import 'package:due_kasir/model/request_model.dart';
import 'package:due_kasir/pages/request/request_form.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class RequestCard extends StatefulWidget {
  final RequestModel val;
  const RequestCard({super.key, required this.val});

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  TextEditingController title = TextEditingController();
  final popoverController = ShadPopoverController();

  @override
  void initState() {
    title = TextEditingController(text: widget.val.title);
    super.initState();
  }

  @override
  void dispose() {
    popoverController.dispose();
    title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      width: 340,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.val.title ?? 'Created',
              style: ShadTheme.of(context).textTheme.h4),
          ShadPopover(
            controller: popoverController,
            popover: (context) => SizedBox(
              width: 288,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ShadInputFormField(
                          id: 'title',
                          label: const Text('Title'),
                          controller: title,
                          placeholder: const Text('Rename'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: ShadButton(
                          text: const Text('Save'),
                          onPressed: () async {
                            if (title.text.isNotEmpty) {
                              RequestModel request = RequestModel(
                                  id: widget.val.id,
                                  title: title.text,
                                  note: widget.val.note,
                                  status: widget.val.status,
                                  createdAt: widget.val.createdAt);
                              await SupabaseHelper().updateRequest(request);
                              requestController.requests.refresh();
                              popoverController.toggle();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            child: IconButton(
              onPressed: () {
                title = TextEditingController(text: widget.val.title);
                popoverController.toggle();
              },
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      description: Text(dateWithTime.format(widget.val.createdAt!)),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Document Size: ${(widget.val.note ?? '').length}'),
          ],
        ),
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Status: ${widget.val.status ?? ''}'),
          ShadButton(
            text: const Text('See Detail'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RequestForm(request: widget.val)),
              );
            },
          ),
        ],
      ),
    );
  }
}
