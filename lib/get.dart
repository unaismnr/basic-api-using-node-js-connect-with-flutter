import 'package:flutter/material.dart';
import 'package:node_crud/add_edit.dart';
import 'package:node_crud/api.dart';

class Get extends StatelessWidget {
  const Get({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddEdit(),
                  ),
                );
              },
              child: const Text('Add Data'),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
                future: Api.getData(),
                builder: (contex, snapshot) {
                  if (snapshot.data == null) {
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    const Center(
                      child: Text('No Data'),
                    );
                  } else if (snapshot.hasError) {
                    const Center(
                      child: Text('Something Error'),
                    );
                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Card(
                            elevation: 10,
                            child: ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddEdit(
                                        id: data.id,
                                        title: data.title,
                                        complete: data.completed,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              title: Text(data.title),
                              subtitle: Text(
                                data.completed ? 'Completed' : 'Not Completed',
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Api.deleteData(data.id!);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox();
                        },
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
