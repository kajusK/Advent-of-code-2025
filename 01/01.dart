import 'dart:io';

int part1(List<int> rotations, int dial) {
    var res = 0;

    for (var r in rotations) {
        dial = (dial + r) % 100;
        if (dial == 0) {
            res++;
        }
    }
    return res;
}

int part2(List<int> rotations, int dial) {
    var res = 0;

    for (var r in rotations) {
        var next = dial + r;
        res += (next ~/ 100).abs();
        if (next == 0 || (next < 0 && dial > 0) || (next > 0 && dial < 0)) {
            res++;
        }
        dial = next % 100;
    }
    return res;
}



void main() async {
    final file = File('input.txt');
    final lines = await file.readAsLines();
    final RegExp regExp = RegExp(r"([A-Za-z]+)(\d+)");

    final rotations = lines.map((line) {
        final match = regExp.firstMatch(line)!;
        final count = int.parse(match.group(2)!);
        if (match.group(1)! == 'L') {
            return -count;
        }
        return count;
    }).toList();

    const initial = 50;
    print('Part 1: ${part1(rotations, initial)}');
    print('Part 2: ${part2(rotations, initial)}');
}

