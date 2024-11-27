function compareItems(responseItems, expectedValues) {
    for (var i = 0; i < responseItems.length; i++) {
      var actual = responseItems[i].Name;
      var expected = expectedValues[i];
      karate.match(actual, expected);  // This will assert that they match
    }
  }
  