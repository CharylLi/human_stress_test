import 'package:flutter/material.dart';
import 'package:human_stress_test/providers/position_provider.dart';
import 'package:provider/provider.dart';

class RunningGamePage extends StatelessWidget {
  const RunningGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Semantics(
            label: 'You are playing running game',
            child: const Text("Running Game")),
        backgroundColor: const Color.fromRGBO(139, 219, 250, 1),
        leading: IconButton(
          icon: Semantics(
              label: 'back to home', child: const Icon(Icons.arrow_back)),
          onPressed: () {
            Provider.of<PositionProvider>(context, listen: false);
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Center(
        child: Consumer<PositionProvider>(
          builder: (context, provider, child) {
            if (provider.known == false) {
              return Semantics(
                  label: 'please enable location',
                  child: const Text('please enable location'));
            }
            if (provider.started == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Semantics(
                      label: 'click on the button and start running',
                      child:
                          const Text('Click on the button and start running!')),
                  ElevatedButton(
                    onPressed: () => provider.startPositTrack(),
                    child: Semantics(
                        label: 'start running',
                        child: const Text("Start Running")),
                  ),
                ],
              );
            }

            if (provider.started == true) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => provider.endPositTracking(),
                    child: Semantics(
                        label: 'stop running',
                        child: const Text("Stop Running")),
                  ),
                  Text(provider.stopwatch.elapsed.toString()),
                  Text('${provider.longitude.toString()} latitude'),
                  Text('${provider.latitude.toString()} longitude'),
                ],
              );
            }

            if (provider.started == false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('${provider.distance.toString()} meters in ${provider.stopwatch.elapsed.toString()} milliseconds'),
                  Semantics(
                      label:
                          'your speed is ${provider.finalTime}meters per second',
                      child: Text('${provider.finalTime}m/s')),
                  ElevatedButton(
                    onPressed: () => {provider.resetTracking()},
                    child: Semantics(
                        label: 'new game', child: const Text("new game")),
                  )
                ],
              );
            }

            return const Placeholder();
          },
        ),
      ),
    );
  }
}
