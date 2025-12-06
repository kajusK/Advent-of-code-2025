import 'dart:io';

int part1(List<(String, List<String>)> data) {
    int sum = 0;
    for (var (op, nums) in data) {
        if (op == '*') {
            sum += nums.fold(1, (res, x) => res * int.parse(x.trim()));
        } else {
            sum += nums.fold(0, (res, x) => res + int.parse(x.trim()));
        }
    }
    return sum;
}

int part2(List<(String, List<String>)> data) {
    List<(String, List<String>)> newData = [];

    for (var (op, nums) in data) {
        List<String> strings = nums.map((x) => x.split('').reversed.join()).toList();
        List<String> newNums = [];
        var i = 0;

        while (true) {
            var num = '';
            for (int j = 0; j < strings.length; j++) {
                if (i < strings[j].length) {
                    num += strings[j][i];
                }
            }
            num = num.trim();
            if (num != '') {
                newNums.add(num);
            } else {
                break;
            }
            i++;
        }
        newData.add((op, newNums));
    }
    return part1(newData);
}

void main() async {
    final file = File('input.txt');
    final lines = await file.readAsLines();
    final maxLineLen = lines.map((line) => line.length).reduce((max, x) => x > max ? x : max);
    List<(String, List<String>)> data = []; 

    var prev = 0;
    for (var x = 0; x <= maxLineLen; x++) {
        var allSpaces = !lines.map((line) => line.padRight(maxLineLen+1)[x] == ' ').any((x) => !x);
        if (allSpaces) {
            var parsed = lines.map((line) => line.padRight(maxLineLen+1).substring(prev, x)).toList();
            data.add((parsed[parsed.length - 1].trim(), parsed.sublist(0, parsed.length - 1)));
            prev = x;
        }
    }

    print('Part 1: ${part1(data)}');
    print('Part 2: ${part2(data)}');
}

