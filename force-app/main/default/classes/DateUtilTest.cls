/**
 * Class:   DateUtilTest.cls
 * Testing: DateUtil.cls
 * @desc:   Work in progress
 */
@isTest
private class DateUtilTest {

    @isTest
    static void  testDateToString() {
        //  Setup
        Date dMonday    = Date.newInstance(2020, 05, 04);
        Date dTuesday   = Date.newInstance(2020, 05, 05);
        Date dWednesday = Date.newInstance(2020, 05, 06);
        Date dThursday  = Date.newInstance(2020, 05, 07);
        Date dFriday    = Date.newInstance(2020, 05, 08);
        Date dSaturday  = Date.newInstance(2020, 05, 09);
        Date dSunday    = Date.newInstance(2020, 05, 10);

        //  Asserts
        System.assertEquals('2020-05-04', DateUtil.dateToString(dMonday));
        System.assertEquals('2020-05-05', DateUtil.dateToString(dTuesday));
        System.assertEquals('2020-05-06', DateUtil.dateToString(dWednesday));
        System.assertEquals('2020-05-07', DateUtil.dateToString(dThursday));
        System.assertEquals('2020-05-08', DateUtil.dateToString(dFriday));
        System.assertEquals('2020-05-09', DateUtil.dateToString(dSaturday));
        System.assertEquals('2020-05-10', DateUtil.dateToString(dSunday));
    }

    @isTest
    static void testGetDateTimeOfDate() {
        //  Setup
        Date testDate = Date.newInstance(2020, 12, 13);
        DateTime expectedDateTime = DateTime.newInstance(2020, 12, 13, 12, 0, 0);

        //  Asserts
        System.assertEquals(expectedDateTime, DateUtil.getDateTimeOfDate(testDate));
    }

    @isTest
    static void testMonthNameForDate() {
        //  Setup
        Date testDate     = Date.newInstance(2020, 01, 10);
        String sJanuary   = DateUtil.monthNameForDate(testDate);
        String sFebruary  = DateUtil.monthNameForDate(testDate.addMonths(1));
        String sMarch     = DateUtil.monthNameForDate(testDate.addMonths(2));
        String sApril     = DateUtil.monthNameForDate(testDate.addMonths(3));
        String sMay       = DateUtil.monthNameForDate(testDate.addMonths(4));
        String sJune      = DateUtil.monthNameForDate(testDate.addMonths(5));
        String sJuly      = DateUtil.monthNameForDate(testDate.addMonths(6));
        String sAugust    = DateUtil.monthNameForDate(testDate.addMonths(7));
        String sSeptember = DateUtil.monthNameForDate(testDate.addMonths(8));
        String sOctober   = DateUtil.monthNameForDate(testDate.addMonths(9));
        String sNovember  = DateUtil.monthNameForDate(testDate.addMonths(10));
        String sDecember  = DateUtil.monthNameForDate(testDate.addMonths(11));

        //  Asserts
        System.assertEquals('January',   sJanuary);
        System.assertEquals('February',  sFebruary);
        System.assertEquals('March',     sMarch);
        System.assertEquals('April',     sApril);
        System.assertEquals('May',       sMay);
        System.assertEquals('June',      sJune);
        System.assertEquals('July',      sJuly);
        System.assertEquals('August',    sAugust);
        System.assertEquals('September', sSeptember);
        System.assertEquals('October',   sOctober);
        System.assertEquals('November',  sNovember);
        System.assertEquals('December',  sDecember);
    }

    @isTest
    static void testDayNameOfWeek() {
        //  Setup
        Date dMonday    = Date.newInstance(2020, 05, 04);
        Date dTuesday   = Date.newInstance(2020, 05, 05);
        Date dWednesday = Date.newInstance(2020, 05, 06);
        Date dThursday  = Date.newInstance(2020, 05, 07);
        Date dFriday    = Date.newInstance(2020, 05, 08);
        Date dSaturday  = Date.newInstance(2020, 05, 09);
        Date dSunday    = Date.newInstance(2020, 05, 10);

        //  Asserts
        System.assertEquals('Monday',    DateUtil.dayNameOfWeek(dMonday));
        System.assertEquals('Tuesday',   DateUtil.dayNameOfWeek(dTuesday));
        System.assertEquals('Wednesday', DateUtil.dayNameOfWeek(dWednesday));
        System.assertEquals('Thursday',  DateUtil.dayNameOfWeek(dThursday));
        System.assertEquals('Friday',    DateUtil.dayNameOfWeek(dFriday));
        System.assertEquals('Saturday',  DateUtil.dayNameOfWeek(dSaturday));
        System.assertEquals('Sunday',    DateUtil.dayNameOfWeek(dSunday));
    }

    @isTest
    static void testDayNumberOfWeek() {
        //  Setup
        Date dMonday    = Date.newInstance(2020, 05, 04);
        Date dTuesday   = Date.newInstance(2020, 05, 05);
        Date dWednesday = Date.newInstance(2020, 05, 06);
        Date dThursday  = Date.newInstance(2020, 05, 07);
        Date dFriday    = Date.newInstance(2020, 05, 08);
        Date dSaturday  = Date.newInstance(2020, 05, 09);
        Date dSunday    = Date.newInstance(2020, 05, 10);

        //  Asserts
        System.assertEquals('1', DateUtil.dayNumberOfWeek(dMonday));
        System.assertEquals('2', DateUtil.dayNumberOfWeek(dTuesday));
        System.assertEquals('3', DateUtil.dayNumberOfWeek(dWednesday));
        System.assertEquals('4', DateUtil.dayNumberOfWeek(dThursday));
        System.assertEquals('5', DateUtil.dayNumberOfWeek(dFriday));
        System.assertEquals('6', DateUtil.dayNumberOfWeek(dSaturday));
        System.assertEquals('7', DateUtil.dayNumberOfWeek(dSunday));
        System.assertEquals('1', DateUtil.dayNumberOfWeek(dSunday.addDays(1)));
        System.assertNOtEquals('8', DateUtil.dayNumberOfWeek(dSunday.addDays(1)));
    }

    @isTest
    static void testMondayBefore() {
        //  Setup
        Date testMondayOne   = Date.newInstance(2019, 12, 16);      
        Date testMondayTwo   = Date.newInstance(2020, 02, 24);      
        Date testMondayThree = Date.newInstance(2020, 04, 06);      
        Date testMondayFour  = Date.newInstance(2020, 06, 22);
        
        //  Asserts
        System.assertEquals(testMondayOne,     DateUtil.mondayBefore(testMondayOne));
        System.assertEquals(testMondayTwo,     DateUtil.mondayBefore(testMondayTwo.addDays(2)));
        System.assertEquals(testMondayThree,   DateUtil.mondayBefore(testMondayThree.addDays(4)));
        System.assertEquals(testMondayFour,    DateUtil.mondayBefore(testMondayFour.addDays(6)));
        System.assertNotEquals(testMondayFour, DateUtil.mondayBefore(testMondayFour.addDays(7)));
    }

    @isTest
    static void testSundayBefore() {
        //  Setup
        Date testSunday = Date.newInstance(2019, 12, 15); 
        
        //  Assert
        System.assertEquals(testSunday,    DateUtil.sundayBefore(testSunday));
        System.assertEquals(testSunday,    DateUtil.sundayBefore(testSunday.addDays(3)));
        System.assertEquals(testSunday,    DateUtil.sundayBefore(testSunday.addDays(6)));
        System.assertNotEquals(testSunday, DateUtil.sundayBefore(testSunday.addDays(-1)));
        System.assertNotEquals(testSunday, DateUtil.sundayBefore(testSunday.addDays(8)));
    }

    @isTest
    static void testSaturdayAfter() {
        //  Setup
        Date testSaturday = Date.newInstance(2019, 12, 14);

        //  Asserts
        System.assertEquals(testSaturday,    DateUtil.saturdayAfter(testSaturday));
        System.assertEquals(testSaturday,    DateUtil.saturdayAfter(testSaturday.addDays(-6)));
        System.assertEquals(testSaturday,    DateUtil.saturdayAfter(testSaturday.addDays(-3)));
        System.assertEquals(testSaturday,    DateUtil.saturdayAfter(testSaturday.addDays(-1)));
        System.assertNotEquals(testSaturday, DateUtil.saturdayAfter(testSaturday.addDays(-7)));
        System.assertNotEquals(testSaturday, DateUtil.saturdayAfter(testSaturday.addDays(1)));
        System.assertEquals(testSaturday.addDays(7), DateUtil.saturdayAfter(testSaturday.addDays(1)));
    }

    @isTest
    static void testFridayAfter() {
        //  Setup
        Date testFriday = Date.newInstance(2020, 05, 08);

        //  Assert
        System.assertEquals(testFriday,    DateUtil.fridayAfter(testFriday));
        System.assertEquals('5',           DateUtil.dayNumberOfWeek(testFriday));
        System.assertEquals(testFriday,    DateUtil.fridayAfter(testFriday.addDays(-6)));
        System.assertEquals(testFriday,    DateUtil.fridayAfter(testFriday.addDays(-3)));
        System.assertNotEquals(testFriday, DateUtil.fridayAfter(testFriday.addDays(-7)));
        System.assertEquals('5',           DateUtil.dayNumberOfWeek(DateUtil.fridayAfter(testFriday.addDays(-7))));
        System.assertNotEquals(testFriday, DateUtil.fridayAfter(testFriday.addDays(1)));
        System.assertEquals('5',           DateUtil.dayNumberOfWeek(DateUtil.fridayAfter(testFriday.addDays(1))));
    }

}