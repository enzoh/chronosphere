import Int32 "mo:base/Int32";
import Nat64 "mo:base/Nat64";
import Prim "mo:prim";

import Base "Base";

module Date {

  type Year = Base.Year;
  type Month = Base.Month;
  type Day = Base.Day;
  type DateParts = Base.DateParts;

  /**
   * The type of a date.
   */
  public type Date = {
    #Date : Int32;
  };

  /**
   * Show a date.
   */
  public func show(date : Date) : Text {
    Base.showDateParts(unpack(date))
  };

  /**
   * Create a date.
   */
  public func create(year : Year, month : Month, day : Day) : ? Date {
    let days = epochToDate(year, month, day);
    if (0 <= days and days <= 2932896) {
      let base = Int32.fromInt(days);
      ? #Date base
    } else {
      null
    }
  };

  /**
   * Get the current date from the subnet manager.
   */
  public func now() : Date {
    let base = Int32.fromInt(Nat64.toNat(Prim.time()) / 86400000000000);
    #Date base
  };

  /**
   * Pack a date from parts.
   */
  public func pack(parts : DateParts) : ? Date {
    create(parts.year, parts.month, parts.day)
  };

  /**
   * Unpack a date to parts.
   */
  public func unpack(#Date base : Date) : DateParts {
    var year = 1970;
    var days = Int32.toInt(base);
    var leap = false;
    var size = 365;
    while (days >= size) {
      year += 1;
      days -= size;
      leap := isLeapYear(#Year year);
      size := if leap 366 else 365;
    };
    let (month, day) = if (leap) {
      if (days > 181) {
        if (days > 273) {
          if (days > 334) {
            (#December, days - 334)
          } else if (days > 304) {
            (#November, days - 304)
          } else {
            (#October, days - 273)
          }
        } else if (days > 243) {
          (#September, days - 243)
        } else if (days > 212) {
          (#August, days - 212)
        } else {
          (#July, days - 181)
        }
      } else if (days > 90) {
        if (days > 151) {
          (#June, days - 151)
        } else if (days > 120) {
          (#May, days - 120)
        } else {
          (#April, days - 90)
        }
      } else if (days > 59) {
        (#March, days - 59)
      } else if (days > 30) {
        (#February, days - 30)
      } else {
        (#January, days + 1)
      }
    } else if (days > 180) {
      if (days > 272) {
        if (days > 333) {
          (#December, days - 333)
        } else if (days > 303) {
          (#November, days - 303)
        } else {
          (#October, days - 272)
        }
      } else if (days > 242) {
        (#September, days - 242)
      } else if (days > 211) {
        (#August, days - 211)
      } else {
        (#July, days - 180)
      }
    } else if (days > 89) {
      if (days > 151) {
        (#June, days - 150)
      } else if (days > 119) {
        (#May, days - 119)
      } else {
        (#April, days - 89)
      }
    } else if (days > 58) {
      (#March, days - 58)
    } else if (days > 30) {
      (#February, days - 30)
    } else {
      (#January, days + 1)
    };
    let wday = switch (1 + (Int32.toInt(base) + 4) % 7) {
      case 1 #Sunday;
      case 2 #Monday;
      case 3 #Tuesday;
      case 4 #Wednesday;
      case 5 #Thursday;
      case 6 #Friday;
      case _ #Saturday;
    };
    {
      year = #Year year;
      month = month;
      day = #Day day;
      wday = wday;
    }
  };

  /**
   * Check if the given year is a leap year.
   */
  private func isLeapYear(year : Year) : Bool {
    let #Year y = year;
    y % 400 == 0 or y % 100 != 0 and y % 4 == 0
  };

  /**
   * Calculate the number of days that have elapsed between Unix epoch and the
   * given date without performing any bounds check.
   */
  private func epochToDate(year : Year, month : Month, day : Day) : Int {
    let leap = isLeapYear(year);
    epochToYear(year) + yearToMonth(leap, month) + monthToDay(day) - 1
  };

  /**
   * Calculate the number of days that have elapsed between Unix epoch and the
   * given year without performing any bounds check.
   */
  private func epochToYear(year : Year) : Int {
    let #Year y = year;
    365 * (y - 1970) + (y - 1969) / 4 - (y - 1901) / 100 + (y - 1601) / 400
  };

  /**
   * Calculate the number of days that have elapsed between January 1st and the
   * given month.
   */
  private func yearToMonth(leap : Bool, month : Month) : Int {
    if (leap) {
      switch (month) {
        case (#January) 0;
        case (#February) 31;
        case (#March) 60;
        case (#April) 91;
        case (#May) 121;
        case (#June) 152;
        case (#July) 182;
        case (#August) 213;
        case (#September) 244;
        case (#October) 274;
        case (#November) 305;
        case (#December) 335;
      }
    } else {
      switch (month) {
        case (#January) 0;
        case (#February) 31;
        case (#March) 59;
        case (#April) 90;
        case (#May) 120;
        case (#June) 151;
        case (#July) 181;
        case (#August) 212;
        case (#September) 243;
        case (#October) 273;
        case (#November) 304;
        case (#December) 334;
      }
    }
  };

  /**
   * Calculate the number of days that have elapsed between the 1st of the
   * month and the given day.
   */
  private func monthToDay(day : Day) : Int {
    let #Day d = day;
    d
  };
};
