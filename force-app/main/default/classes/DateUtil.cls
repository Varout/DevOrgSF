/**
 * Class: DateUtil.cls
 * Test:  DateUtilTest.cls
 * @desc: Date Util class to manipulate Dates for various uses.
 */
public class DateUtil {

    public final static Integer DAYS_FROM_SUN_TO_SAT = 6;
    public final static Integer DAYS_FROM_SUN_TO_FRI = 5;

    /**
     * For a given Date, convert it to a string format YYYY-MM-DD.
     */
    public static String dateToString(Date theDate) {
        String stringYear  = String.valueof(theDate.year());
        String stringMonth = String.valueOf(theDate.month());
        String stringDay   = String.valueOf(theDate.day());

        if (stringMonth.length() == 1) { stringMonth = '0' + stringMonth; }
        if (stringDay.length()   == 1) { stringDay   = '0' + stringDay; }

        String returnString = stringYear + '-' + stringMonth + '-' + stringDay;

        return returnString;
    }

    /**
     * For a given Date, returns an instance of DateTime at midday for a Date.
     */
    public static DateTime getDateTimeOfDate(Date theDate) {
        return DateTime.newInstance( theDate, Time.newInstance(12, 0, 0, 0));
    }

    /**
     * For a given Date, return the name of the month the date is in.
     */
    public static String monthNameForDate(Date theDate) {
        return DateUtil.getDateTimeOfDate(theDate).format('MMMM');
    }

    /**
     * For a given Date, return the name of the day of the week.
     */
    public static String dayNameOfWeek(Date theDate) {
        return DateUtil.getDateTimeOfDate(theDate).format('EEEE');
    }

    /**
     * For a given Date, returns a String representing the day of the week.
     * 1 = Monday to 7 = Sunday.
     */
    public static String dayNumberOfWeek(Date theDate) {
        return DateUtil.getDateTimeOfDate(theDate).format('u');
    }

    /**
     * For a given Date, returns the Monday before. If the current Date is a Monday, returns the same Date.
     * Used to avoid the built-in Date.toStartOfWeek() function which changes depending on the locale of the user.
     */
    public static Date mondayBefore(Date theDate) {
        Date startOfWeek = theDate;
        while (!DateUtil.dayNumberOfWeek(startOfWeek).equals('1')) {
            startOfWeek = startOfWeek.addDays(-1);
        }
        return startOfWeek;
    }

    /**
     * Returns the Sunday before the given Date.
     * Returns the same Date if it is a Sunday.
     */
    public static Date sundayBefore(Date theDate) {
        Date startOfWeek = theDate;
        while (!DateUtil.dayNumberOfWeek(startOfWeek).equals('7')) {
            startOfWeek = startOfWeek.addDays(-1);
        }
        return startOfWeek;
    }

    /**
     * Returns the Saturday after the given Date.
     * Returns the same Date if it is a Saturday.
     */
    public static Date saturdayAfter(Date theDate) {
        Date sunday   = DateUtil.sundayBefore(theDate);
        Date saturday = sunday.addDays(DAYS_FROM_SUN_TO_SAT);
        return saturday;
    }

    /**
     * Returns the Friday after the given Date.
     * Returns the same Date if it is a Friday.
     */
    public static Date fridayAfter(Date theDate) {
        Date sunday = DateUtil.sundayBefore(theDate);
        Date friday = sunday.addDays(DAYS_FROM_SUN_TO_FRI);
        //  At times the Friday is the Friday before because of how DateUtil.sundayBefore() is calculated
        if (friday < theDate) {
            friday = friday.addDays(7);
        }
        return friday;
    }

}