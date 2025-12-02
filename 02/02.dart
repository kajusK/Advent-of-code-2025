import 'dart:io';

int part1(List<List<int>> input)
{
    var sum = 0;

    for (var range in input) {
        for (var x = range[0]; x <= range[1]; x++) {
            final str = x.toString();
            int mid = str.length ~/ 2;
            if (str.substring(0, mid) == str.substring(mid)) {
                sum += x;
            }
        }
    }
    return sum;
}

bool isPart2Invalid(String str)
{
    for (int i = 1; i <= str.length ~/ 2; i++) {
        var pattern = str.substring(0, i);
        var matches = true;

        for (int j = i; j < str.length; j += i) {
            var end = (j + i).clamp(0, str.length);
            if (pattern != str.substring(j, end)) {
                matches = false;
                break;
            }
        }
        if (matches) {
            return true;
        }
    }
    return false;
}

int part2(List<List<int>> input)
{
    var sum = 0;

    for (var range in input) {
        for (var x = range[0]; x <= range[1]; x++) {
            final str = x.toString();
            if (isPart2Invalid(str)) {
                sum += x;
            }
        }
    }
    return sum;
}


void main() async {
    final file = File('input.txt');
    final input = await file.readAsString();
    final ranges = input.split(',').map((p) =>
        p.split('-').map((v) => int.parse(v)).toList()
    ).toList();

    print('Part 1: ${part1(ranges)}');
    print('Part 2: ${part2(ranges)}');
}

