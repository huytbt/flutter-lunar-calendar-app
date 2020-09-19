/*
 * This code references https://www.informatik.uni-leipzig.de/~duc/amlich/calrules.html
 * Copyright (c) 2006 Ho Ngoc Duc. All Rights Reserved.
 * Astronomical algorithms from the book "Astronomical Algorithms" by Jean Meeus, 1998
 *
 * Permission to use, copy, modify, and redistribute this software and its
 * documentation for personal, non-commercial use is hereby granted provided that
 * this copyright notice and appropriate documentation appears in all copies.
 */

import 'dart:math';

class LunarDate {
  LunarDate(this.day, this.month, this.year, this.leap, this.timeZone);
  int year;
  int month;
  int day;
  int leap;
  int timeZone;

  LunarDate.fromDateTime(DateTime dateTime) {
    LunarDate date = _convertSolar2Lunar(dateTime);
    this.year = date.year;
    this.month = date.month;
    this.day = date.day;
    this.leap = date.leap;
    this.timeZone = date.timeZone;
  }

  LunarDate.today() {
    LunarDate date = _convertSolar2Lunar(DateTime.now());
    this.year = date.year;
    this.month = date.month;
    this.day = date.day;
    this.leap = date.leap;
    this.timeZone = date.timeZone;
  }

  void setDay(int day) {
    this.day = day;
  }

  String toString() {
    return '$year-${_twoDigits(month)}-${_twoDigits(day)}';
  }

  DateTime toDateTime() {
    return _convertLunar2Solar(
      this.day,
      this.month,
      this.year,
      this.leap,
      this.timeZone ?? 0,
    );
  }

  LunarDate _convertSolar2Lunar(DateTime datetime) {
    int dd = datetime.day;
    int mm = datetime.month;
    int yy = datetime.year;
    int timeZone = int.parse(datetime.timeZoneName);
    int k,
        dayNumber,
        monthStart,
        a11,
        b11,
        lunarDay,
        lunarMonth,
        lunarYear,
        lunarLeap;
    dayNumber = _jdFromDate(dd, mm, yy);
    k = _floor((dayNumber - 2415021.076998695) / 29.530588853);
    monthStart = _getNewMoonDay(k + 1, timeZone);
    if (monthStart > dayNumber) {
      monthStart = _getNewMoonDay(k, timeZone);
    }
    //alert(dayNumber+" -> "+monthStart);
    a11 = _getLunarMonth11(yy, timeZone);
    b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = yy;
      a11 = _getLunarMonth11(yy - 1, timeZone);
    } else {
      lunarYear = yy + 1;
      b11 = _getLunarMonth11(yy + 1, timeZone);
    }
    lunarDay = dayNumber - monthStart + 1;
    int diff = _floor((monthStart - a11) / 29);
    lunarLeap = 0;
    lunarMonth = diff + 11;
    if (b11 - a11 > 365) {
      int leapMonthDiff = _getLeapMonthOffset(a11, timeZone);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
        if (diff == leapMonthDiff) {
          lunarLeap = 1;
        }
      }
    }
    if (lunarMonth > 12) {
      lunarMonth = lunarMonth - 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
      lunarYear -= 1;
    }
    return LunarDate(lunarDay, lunarMonth, lunarYear, lunarLeap, timeZone);
  }

  _convertLunar2Solar(lunarDay, lunarMonth, lunarYear, lunarLeap, timeZone) {
    var k, a11, b11, off, leapOff, leapMonth, monthStart;
    if (lunarMonth < 11) {
      a11 = _getLunarMonth11(lunarYear - 1, timeZone);
      b11 = _getLunarMonth11(lunarYear, timeZone);
    } else {
      a11 = _getLunarMonth11(lunarYear, timeZone);
      b11 = _getLunarMonth11(lunarYear + 1, timeZone);
    }
    k = _floor(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    off = lunarMonth - 11;
    if (off < 0) {
      off += 12;
    }
    if (b11 - a11 > 365) {
      leapOff = _getLeapMonthOffset(a11, timeZone);
      leapMonth = leapOff - 2;
      if (leapMonth < 0) {
        leapMonth += 12;
      }
      if (lunarLeap != 0 && lunarMonth != leapMonth) {
        return new DateTime(0, 0, 0);
      } else if (lunarLeap != 0 || off >= leapOff) {
        off += 1;
      }
    }
    monthStart = _getNewMoonDay(k + off, timeZone);
    return _jdToDate(monthStart + lunarDay - 1);
  }

  DateTime _jdToDate(jd) {
    var a, b, c, d, e, m, day, month, year;
    if (jd > 2299160) {
      // After 5/10/1582, Gregorian calendar
      a = jd + 32044;
      b = _floor((4 * a + 3) / 146097);
      c = a - _floor((b * 146097) / 4);
    } else {
      b = 0;
      c = jd + 32082;
    }
    d = _floor((4 * c + 3) / 1461);
    e = c - _floor((1461 * d) / 4);
    m = _floor((5 * e + 2) / 153);
    day = e - _floor((153 * m + 2) / 5) + 1;
    month = m + 3 - 12 * _floor(m / 10);
    year = b * 100 + d - 4800 + _floor(m / 10);
    return new DateTime(year, month, day);
  }

  int _getLeapMonthOffset(int a11, int timeZone) {
    var k, last, arc, i;
    k = _floor((a11 - 2415021.076998695) / 29.530588853 + 0.5);
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = _getSunLongitude(_getNewMoonDay(k + i, timeZone), timeZone);
    do {
      last = arc;
      i++;
      arc = _getSunLongitude(_getNewMoonDay(k + i, timeZone), timeZone);
    } while (arc != last && i < 14);
    return i - 1;
  }

  int _getLunarMonth11(int yy, int timeZone) {
    var k, off, nm, sunLong;
    //off = _jdFromDate(31, 12, yy) - 2415021.076998695;
    off = _jdFromDate(31, 12, yy) - 2415021;
    k = _floor(off / 29.530588853);
    nm = _getNewMoonDay(k, timeZone);
    sunLong = _getSunLongitude(nm, timeZone); // sun longitude at local midnight
    if (sunLong >= 9) {
      nm = _getNewMoonDay(k - 1, timeZone);
    }
    return nm;
  }

  int _getSunLongitude(int dayNumber, int timeZone) {
    return _floor(_sunLongitude(dayNumber - 0.5 - timeZone / 24) / pi * 6);
  }

  double _sunLongitude(double jdn) {
    var t, t2, dr, m, l0, dl, l;
    t = (jdn - 2451545.0) /
        36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    t2 = t * t;
    dr = pi / 180; // degree to radian
    m = 357.52910 +
        35999.05030 * t -
        0.0001559 * t2 -
        0.00000048 * t * t2; // mean anomaly, degree
    l0 = 280.46645 + 36000.76983 * t + 0.0003032 * t2; // mean longitude, degree
    dl = (1.914600 - 0.004817 * t - 0.000014 * t2) * sin(dr * m);
    dl = dl +
        (0.019993 - 0.000101 * t) * sin(dr * 2 * m) +
        0.000290 * sin(dr * 3 * m);
    l = l0 + dl; // true longitude, degree
    l = l * dr;
    l = l - pi * 2 * (_floor(l / (pi * 2))); // Normalize to (0, 2*PI)
    return l;
  }

  int _jdFromDate(int dd, int mm, int yy) {
    var a, y, m, jd;
    a = _floor((14 - mm) / 12);
    y = yy + 4800 - a;
    m = mm + 12 * a - 3;
    jd = dd +
        _floor((153 * m + 2) / 5) +
        365 * y +
        _floor(y / 4) -
        _floor(y / 100) +
        _floor(y / 400) -
        32045;
    if (jd < 2299161) {
      jd = dd + _floor((153 * m + 2) / 5) + 365 * y + _floor(y / 4) - 32083;
    }
    return jd;
  }

  int _getNewMoonDay(int k, int timeZone) {
    return _floor(_newMoon(k) + 0.5 + timeZone / 24);
  }

  double _newMoon(int k) {
    double t, t2, t3, dr, jd1, m, mpr, f, c1, deltat, jdNew;
    t = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
    t2 = t * t;
    t3 = t2 * t;
    dr = pi / 180;
    jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * t2 - 0.000000155 * t3;
    jd1 = jd1 +
        0.00033 *
            sin((166.56 + 132.87 * t - 0.009173 * t2) * dr); // Mean new moon
    m = 359.2242 +
        29.10535608 * k -
        0.0000333 * t2 -
        0.00000347 * t3; // Sun's mean anomaly
    mpr = 306.0253 +
        385.81691806 * k +
        0.0107306 * t2 +
        0.00001236 * t3; // Moon's mean anomaly
    f = 21.2964 +
        390.67050646 * k -
        0.0016528 * t2 -
        0.00000239 * t3; // Moon's argument of latitude
    c1 = (0.1734 - 0.000393 * t) * sin(m * dr) + 0.0021 * sin(2 * dr * m);
    c1 = c1 - 0.4068 * sin(mpr * dr) + 0.0161 * sin(dr * 2 * mpr);
    c1 = c1 - 0.0004 * sin(dr * 3 * mpr);
    c1 = c1 + 0.0104 * sin(dr * 2 * f) - 0.0051 * sin(dr * (m + mpr));
    c1 = c1 - 0.0074 * sin(dr * (m - mpr)) + 0.0004 * sin(dr * (2 * f + m));
    c1 = c1 - 0.0004 * sin(dr * (2 * f - m)) - 0.0006 * sin(dr * (2 * f + mpr));
    c1 = c1 +
        0.0010 * sin(dr * (2 * f - mpr)) +
        0.0005 * sin(dr * (2 * mpr + m));
    if (t < -11) {
      deltat = 0.001 +
          0.000839 * t +
          0.0002261 * t2 -
          0.00000845 * t3 -
          0.000000081 * t * t3;
    } else {
      deltat = -0.000278 + 0.000265 * t + 0.000262 * t2;
    }
    jdNew = jd1 + c1 - deltat;
    return jdNew;
  }

  int _floor(num) {
    return num.floor();
  }

  String _twoDigits(num) {
    return ((num < 10) ? '0' + num.toString() : num.toString());
  }
}
