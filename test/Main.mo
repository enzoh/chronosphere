import Option "mo:base/Option";

import Date "../src/Date";

actor {

  public query func epoch() : async Text {
    Date.show(Option.unwrap(Date.create(#Year 1970, #January, #Day 1)));
  };

  public query func now() : async Text {
    Date.show(Date.now());
  };

  public query func test() : async () {
    let date = Date.now();
    assert(? date == Date.pack(Date.unpack(date)));
  };
};
