import 'dart:async';
import 'dart:isolate';

abstract class Task<T> {
  Task();
  T execute();
}

Future<T> executeInIsolate(Task<T> task) async {
  var receivePort = new ReceivePort();
  await Isolate.spawn(execTask, receivePort.sendPort);
  var sendPort = await receivePort.first;
  var response = new ReceivePort();
  sendPort.send([task, response.sendPort]);
  return response.first;
}

void execTask(SendPort sendPort) async {
  var port = new ReceivePort();
  sendPort.send(port.sendPort);

  await for (var msg in port) {
    var task = msg[0];
    SendPort replyTo = msg[1];
    replyTo.send(task.execute());
    port.close();
  }
}
