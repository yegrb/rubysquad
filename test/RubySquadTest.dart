library rubysquad_test;

import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';

main() {
  unittestConfiguration = new VMConfiguration();
  
  test("fail", () {
    expect(1 + 1, equals(2));
  });
}