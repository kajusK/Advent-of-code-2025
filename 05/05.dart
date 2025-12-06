import 'dart:io';
import 'dart:math';

bool isFresh(List<List<int>> ranges, int ingredient) {
    for (var range in ranges) {
        if (ingredient >= range[0] && ingredient <= range[1]) {
            return true;
        }
    }
    return false;
}

int part1(List<List<int>> ranges, List<int> ingredients) {
    var fresh = 0;

    for (var ingredient in ingredients) {
        if (isFresh(ranges, ingredient)) {
            fresh++;
        }
    }
    return fresh;
}

int part2(List<List<int>> ranges) {
    bool changed = false;
    do {
        changed = false;
        var i = 0;
        while (i < ranges.length) { 
            for (var j = ranges.length - 1; j > i; j--) {
                var li = ranges[i][0];
                var ri = ranges[i][1];
                var lj = ranges[j][0];
                var rj = ranges[j][1];

                if (max(li , lj) <= min(ri, rj)) {
                    ranges[i][0] = min(li, lj);
                    ranges[i][1] = max(rj, ri);
                    ranges.removeAt(j);
                    changed = true;
                }
            }
            i++;
        }
    } while (changed);
    
    return ranges.fold(0, (sum, x) => sum + (x[1] - x[0] + 1));
}

void main() async {
    final file = File('input.txt');
    final content = await file.readAsString();
    final input = content.split('\n\n');
    var ranges = input[0].split('\n').map((l) => l.split('-').map((x) => int.parse(x)).toList()).toList();
    var ingredients = input[1].split('\n').map((x) => int.parse(x)).toList();

    print('Part 1: ${part1(ranges, ingredients)}');
    print('Part 2: ${part2(ranges)}');
}

