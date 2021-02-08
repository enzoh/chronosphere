import Int "mo:base/Int";

module Base {

  /**
   * A type to represent a year.
   */
  public type Year = {
    #Year : Int;
  };

  /**
   * Show a year.
   */
  public func showYear(year : Year) : Text {
    let #Year n = year;
    Int.toText(n)
  };

  /**
   * A type to represent a month.
   */
  public type Month = {
    #January;
    #February;
    #March;
    #April;
    #May;
    #June;
    #July;
    #August;
    #September;
    #October;
    #November;
    #December;
  };

  /**
   * Show a month.
   */
  public func showMonth(month : Month) : Text {
    switch (month) {
      case (#January) "January";
      case (#February) "February";
      case (#March) "March";
      case (#April) "April";
      case (#May) "May";
      case (#June) "June";
      case (#July) "July";
      case (#August) "August";
      case (#September) "September";
      case (#October) "October";
      case (#November) "November";
      case (#December) "December";
    }
  };

  /**
   * Show a month using its abbreviation.
   */
  public func showMonthShort(month : Month) : Text {
    switch (month) {
      case (#January) "Jan";
      case (#February) "Feb";
      case (#March) "Mar";
      case (#April) "Apr";
      case (#May) "May";
      case (#June) "Jun";
      case (#July) "Jul";
      case (#August) "Aug";
      case (#September) "Sep";
      case (#October) "Oct";
      case (#November) "Nov";
      case (#December) "Dec";
    }
  };

  /**
   * A type to represent a day.
   */
  public type Day = {
    #Day : Int;
  };

  /**
   * Show a day.
   */
  public func showDay(day : Day) : Text {
    let #Day n = day;
    Int.toText(n)
  };

  /**
   * A type to represent a day of the week.
   */
  public type DayOfWeek = {
    #Sunday;
    #Monday;
    #Tuesday;
    #Wednesday;
    #Thursday;
    #Friday;
    #Saturday;
  };

  /**
   * Show a day of the week.
   */
  public func showDayOfWeek(wday : DayOfWeek) : Text {
    switch (wday) {
      case (#Sunday) "Sunday";
      case (#Monday) "Monday";
      case (#Tuesday) "Tuesday";
      case (#Wednesday) "Wednesday";
      case (#Thursday) "Thursday";
      case (#Friday) "Friday";
      case (#Saturday) "Saturday";
    }
  };

  /**
   * Show a day of the week using its abbreviation.
   */
  public func showDayOfWeekShort(wday : DayOfWeek) : Text {
    switch (wday) {
      case (#Sunday) "Sun";
      case (#Monday) "Mon";
      case (#Tuesday) "Tue";
      case (#Wednesday) "Wed";
      case (#Thursday) "Thu";
      case (#Friday) "Fri";
      case (#Saturday) "Sat";
    }
  };

  /**
   * A type to represent a hour.
   */
  public type Hour = {
    #Hour : Int;
  };

  /**
   * Show a hour.
   */
  public func showHour(hour : Hour) : Text {
    let #Hour n = hour;
    Int.toText(n)
  };

  /**
   * A type to represent a minute.
   */
  public type Minute = {
    #Minute : Int;
  };

  /**
   * Show a minute.
   */
  public func showMinute(min : Minute) : Text {
    let #Minute n = min;
    Int.toText(n)
  };

  /**
   * A type to represent a second.
   */
  public type Second = {
    #Second : Int;
  };

  /**
   * Show a second.
   */
  public func showSecond(sec : Second) : Text {
    let #Second n = sec;
    Int.toText(n)
  };

  /**
   * A type to represent a nanosecond.
   */
  public type Nanos = {
    #Nanos : Int;
  };

  /**
   * Show a nanosecond.
   */
  public func showNanos(nanos : Nanos) : Text {
    let #Nanos n = nanos;
    Int.toText(n)
  };

  /**
   * A type to represent the parts of a date.
   */
  public type DateParts = {
    year : Year;
    month : Month;
    day : Day;
    wday : DayOfWeek;
  };

  /**
   * Show the parts of a date.
   */
  public func showDateParts(parts : DateParts) : Text {
    var accum = "";
    accum #= showDayOfWeekShort(parts.wday);
    accum #= " ";
    accum #= showMonthShort(parts.month);
    accum #= " ";
    accum #= showWithPad(2, showDay(parts.day));
    accum #= " ";
    accum #= showWithPad(4, showYear(parts.year));
    accum
  };

  /**
   * A type to represent the parts of a date and time.
   */
  public type DateTimeParts = {
    year : Year;
    month : Month;
    day : Day;
    wday : DayOfWeek;
    hour : Hour;
    min : Minute;
    sec : Float;
  };

  /**
   * Apply a zero pad prefix up to the given length.
   */
  private func showWithPad(n : Nat, text : Text) : Text {
    var accum = text;
    var i = accum.size();
    while (i < n) {
      accum := "0" # accum;
      i += 1;
    };
    accum
  };
};
