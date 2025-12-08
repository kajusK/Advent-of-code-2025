import 'dart:io';
import 'dart:math';

typedef BoxPos = ({int x, int y, int z});
typedef Distance = ({double dist, BoxPos a, BoxPos b});

double getDistance(BoxPos a, BoxPos b) {
    return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2) + pow(a.z - b.z, 2));
}

void makeConnection(Distance distance, List<Set<BoxPos>> circuits) {
    for (var circuit in circuits) {
        bool hasA = circuit.contains(distance.a);
        bool hasB = circuit.contains(distance.b);

        if (hasA && !hasB) {
            circuit.add(distance.b);
            break;
        } else if (hasB && !hasA) {
            circuit.add(distance.a);
            break;
        }
    }
    // I'm lazy implementation of merging connected circuits
    for (int i = circuits.length - 1; i >= 0; i--) {
        for (int j = i - 1; j >= 0; j--) {
            bool intersects = circuits[i].any((x) => circuits[j].contains(x));
            if (intersects) {
                circuits[j].addAll(circuits[i]);
                circuits.removeAt(i);
                break;
            }
        }
    }
}


void main() async {
    final file = File('input.txt');
    final lines = await file.readAsLines();
    final boxes = lines.map((line) {
        final items = line.split(',').map((x) => int.parse(x)).toList();
        return (x: items[0], y: items[1], z: items[2]);
    }).toList();

    List<Distance> distances = []; 
    
    for (var i = 0; i < boxes.length; i++) {
        for (var j = i + 1; j < boxes.length; j++) {
            distances.add((
                dist: getDistance(boxes[i], boxes[j]),
                a: boxes[i],
                b: boxes[j],
            ));
        }
    }
    distances.sort((a, b) => a.dist.compareTo(b.dist));

    List<Set<BoxPos>> circuits = [];
    for (var box in boxes) {
        circuits.add({box});
    }

    var pos = 0;
    while (pos < 1000) {
        makeConnection(distances[pos++], circuits);
    }

    // part 1
    circuits.sort((a, b) => b.length.compareTo(a.length));
    print('Part 1 ${circuits[0].length * circuits[1].length * circuits[2].length}');

    // part 2
    while (circuits.length > 1) {
        makeConnection(distances[pos++], circuits);
    }

    var a = distances[pos - 1].a;
    var b = distances[pos - 1].b;
    print('Part 2: ${a.x * b.x}');
}

